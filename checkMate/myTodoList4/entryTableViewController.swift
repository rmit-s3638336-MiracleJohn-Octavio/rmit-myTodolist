//
//  addTableViewController.swift
//  myTodoList4
//
//  Created by Miracle John Octavio Jr on 10/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit

class entryTableViewController: UITableViewController, UITextFieldDelegate {

// MARK: - Controls
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var swtIsAlarmMessageOn: UISwitch!
    
    @IBOutlet weak var txtTask: UITextField!
    @IBOutlet weak var dtpTask: UIDatePicker!
    @IBOutlet weak var lblDateTimeSelected: UILabel!
    
    // Presets
    @IBOutlet weak var btnSet08am: UIButton!
    @IBOutlet weak var btnSet11am: UIButton!
    @IBOutlet weak var btnSet04pm: UIButton!
    @IBOutlet weak var btnSet07pm: UIButton!
    
    @IBOutlet weak var btnSetToday: UIButton!
    @IBOutlet weak var btnAddHrs: UIButton!
    @IBOutlet weak var btnAddDys: UIButton!
    @IBOutlet weak var btnAddWek: UIButton!
    
    // Tone
    @IBOutlet weak var lblToneName: UILabel!
    
    // Icon
    @IBOutlet weak var imgIcon: UIImageView!
    
    
// MARK: - Variables
    
    var curDate = Date()
    var curCalendar = Calendar.current
    var curComponent = DateComponents()
    
    // Used for Add and Edit
    var enmOperation = genmOperation.Add
    
    // This will recieve the index from Root
    var intIndex =  Int()
    
    // Field Variables
    var strTitle = String()
//    var strTask = String()            // Use the lookup instead
//    var dteDate = Date()              // Use the lookup instead
//    var blnAlarmMessageOn = Bool()    // Use the lookup instead
//    var strToneName = String()        // Use the lookup instead
//    var strIconFile = String()        // Use the lookup instead

    
// MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize
        initVariables()
        
        // Set focus
        txtTask.becomeFirstResponder()
        txtTask.delegate = self
        txtTask.keyboardType = UIKeyboardType.asciiCapable
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Display Data Entry -- put it here to avoid delay in
        
        // displaying the data
        displayDataEntry()
    }
    
    func initVariables() {
        
        // Fill up the Lookup
        MyGlobals.shared.arrTask_Lookup.ToneId = 0
        
        
        switch enmOperation {
        case genmOperation.Add:
            title = "Add Task"
            MyGlobals.shared.arrTask_Lookup.Task = ""
            MyGlobals.shared.arrTask_Lookup.DateTime = Date()
            MyGlobals.shared.arrTask_Lookup.IsAlarmMessageOn = 1
            MyGlobals.shared.arrTask_Lookup.ToneId = 0
            MyGlobals.shared.arrTask_Lookup.IconFile = ""
        case genmOperation.Edit:
            strTitle = "Edit Task"
            MyGlobals.shared.arrTask_Lookup.Task = MyGlobals.shared.arrTask[intIndex].Task
            MyGlobals.shared.arrTask_Lookup.DateTime = MyGlobals.shared.arrTask[intIndex].DateTime
            MyGlobals.shared.arrTask_Lookup.IsAlarmMessageOn = MyGlobals.shared.arrTask[intIndex].IsAlarmMessageOn
            MyGlobals.shared.arrTask_Lookup.ToneId = MyGlobals.shared.arrTask[intIndex].ToneId
            MyGlobals.shared.arrTask_Lookup.IconFile = MyGlobals.shared.arrTask[intIndex].IconFile
        }
    }
    
    func displayDataEntry() {
        
        // Values taken from the Lookup
        
        // Layout the values
        navItem.title = strTitle
        txtTask.text = MyGlobals.shared.arrTask_Lookup.Task
        dtpTask.date  = MyGlobals.shared.arrTask_Lookup.DateTime
        swtIsAlarmMessageOn.setOn(MyGlobals.shared.arrTask_Lookup.IsAlarmMessageOn == 1, animated: true)
        lblToneName.text = "(" + MyGlobals.shared.arrTone[MyGlobals.shared.arrTask_Lookup.ToneId] + ")"
        if (MyGlobals.shared.arrTask_Lookup.IconFile != "") {
            imgIcon.image = UIImage(named: MyGlobals.shared.arrTask_Lookup.IconFile)
        }
        // Make the UIImage for Icon Circle
        imgIcon.layer.borderWidth = 2
        imgIcon.layer.masksToBounds = false
        imgIcon.layer.borderColor = UIColor.gray.cgColor
        imgIcon.layer.cornerRadius = 25
        imgIcon.clipsToBounds = true
        
        // Update the DateTime object
        lblDateTimeSelected.text = MyGlobals.shared.mDateToString(dtpTask.date)
    }

    
// MARK: - Events
    
    @IBAction func btnSave_Tapped(_ sender: AnyObject) {
        var lStruTask = gstruTask()
        if (txtTask.text != "") {
            
            // Similar Value/Operation
            lStruTask.Task = txtTask.text!
            lStruTask.DateTime = dtpTask.date
            if (swtIsAlarmMessageOn.isOn == true) {
                lStruTask.IsAlarmMessageOn = 1
            } else {
                lStruTask.IsAlarmMessageOn = 0
            }
            lStruTask.ToneId = MyGlobals.shared.arrTask_Lookup.ToneId
            lStruTask.IconFile = MyGlobals.shared.arrTask_Lookup.IconFile
            
            // Not Similar Value/Operation
            switch enmOperation {
            case genmOperation.Add:
                lStruTask.IsTaskComplete = 0
                
                MyGlobals.shared.arrTask.append(lStruTask)
                txtTask.text = ""
            case genmOperation.Edit:
                lStruTask.IsTaskComplete = MyGlobals.shared.arrTask[intIndex].IsTaskComplete // Same Value
                
                MyGlobals.shared.arrTask[intIndex] = lStruTask
            }
        }
        
        // Back to Root View Controller
        // mjNotes: The "_ =" prevents the compiler from displaying a warning message
        _ = self.navigationController?.popToRootViewController(animated: true)    }
    
    @IBAction func btnPresets_Tapped(_ sender: UIButton) {
        
        setDate(sender)
    }
    
    @IBAction func dtpTask_ValueChanged(_ sender: UIDatePicker) {
        updateLblDateTimeSelected(sender)
    }
    
    // Remove the focus on textView
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtTask.resignFirstResponder()
        return true
    }
    
// MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass the current value to Global Lookup
        MyGlobals.shared.arrTask_Lookup.Task = txtTask.text!
        MyGlobals.shared.arrTask_Lookup.DateTime = dtpTask.date
        if (swtIsAlarmMessageOn.isOn == true) {
            MyGlobals.shared.arrTask_Lookup.IsAlarmMessageOn = 1
        } else {
            MyGlobals.shared.arrTask_Lookup.IsAlarmMessageOn = 0
        }
        if (MyGlobals.shared.arrTask_Lookup.IconFile != "") {
            imgIcon.image = UIImage(named: MyGlobals.shared.arrTask_Lookup.IconFile)
        }
        
        if (segue.identifier == "segueToneView") {
            let tvc: toneTableViewController = segue.destination as! toneTableViewController
            tvc.intIndex = intIndex
        } else if (segue.identifier == "segueIconView") {
            
        }
    }
    
    
// MARK: - Methods
    
    func setDate(_ sender: UIButton) {
        let locDate = dtpTask.date
        let locCalendar = Calendar.current
        var locComponent = locCalendar.dateComponents([.day,.month,.year, .hour, .minute, .second], from: locDate)
        
        curDate = Date()
        curCalendar = Calendar.current
        curComponent = curCalendar.dateComponents([.day,.month,.year, .hour, .minute, .second], from: curDate)
        
        /*
         Apply the values accordingly
         */
        
        switch sender {
        case btnSet08am:
            locComponent.hour = 08
            locComponent.minute = 00
        case btnSet11am:
            locComponent.hour = 11
            locComponent.minute = 00
        case btnSet04pm:
            locComponent.hour = 16
            locComponent.minute = 00
        case btnSet07pm:
            locComponent.hour = 19
            locComponent.minute = 00
            
        case btnSetToday:
            locComponent.day = curComponent.day
            locComponent.month = curComponent.month
            locComponent.year = curComponent.year
        case btnAddHrs:
            locComponent.hour! += 3
        case btnAddDys:
            locComponent.day! += 3
        case btnAddWek:
            locComponent.day! += 7
            
        default:
            break
            
        }
        
        //        let month = calendar.component(.month, from: date)
        //        let day = calendar.component(.day, from: date)
        //        let hour = calendar.component(.hour, from: date)
        //        let minutes = calendar.component(.minute, from: date)
        //        let seconds = calendar.component(.second, from: date)
        //        print("hours = \(month) \(day) \(hour):\(minutes):\(seconds)")
        
        dtpTask.setDate(locCalendar.date(from: locComponent)!, animated: true)
        updateLblDateTimeSelected(dtpTask)
        
    }
    
    func updateLblDateTimeSelected(_ sender: UIDatePicker) {
        lblDateTimeSelected.text = MyGlobals.shared.mDateToString(sender.date, genmDateFormat.WekDayMonHrsMin)
    }

}
