//
//  addTableViewController.swift
//  myTodoList4
//
//  Created by Miracle John Octavio Jr on 10/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit

class entryTableViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    
    // Photo
    @IBOutlet weak var imgPhoto: UIImageView!
    
// MARK: - Variables
    
    var _objTask: Task?
    
    var _curDate = Date()
    var _curCalendar = Calendar.current
    var _curComponent = DateComponents()
    
    // Used for Add and Edit
    var _enmOperation = genmOperation.Add
    
    // This will recieve the index from Root
    var _intIndex =  Int()
    
    // Field Variables
    var _strTitle = String()
//    var strTask = String()            // Use the lookup instead Note: Lookup is a global Variable
//    var dteDate = Date()              // Use the lookup instead
//    var blnAlarmMessageOn = Bool()    // Use the lookup instead
//    var strToneName = String()        // Use the lookup instead
//    var strIconFile = String()        // Use the lookup instead

    
// MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize
        initialize()
        
        // This will hide the keyboard when top is detected (See extenxion Below)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Display Data Entry -- put it here to avoid delay in
        updateLookupData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        /* 
            Problem: Since that the tableView has a
            static cells, when the cells exceeds the
            screen it causes an abnormal display
            which causes the table to scroll automatically
            in the middle. 
         
            Solution: Disable the scroll on design time
            then enable it when the view appears on 
            runtime.
         
            Recreate: You can disable the code below
            to recreate the problem
        */
        tableView.isScrollEnabled = true
        
    }
    
    func initialize() {
        /*
         "task" is assigned to _objTask. So, if _objTask is NOT nil then its true. Hence,
         it will do the edit mode.
        */
        
        if let task = _objTask {
            // Set the Operation
            _strTitle = "Edit"
            _enmOperation = genmOperation.Edit
            
            // Set the variables for Lookups
            MyGlobals.shared.selectedTone = task.tone!
            MyGlobals.shared.selectedIcon = task.iconFile!
            
            // Set the value of Data Entry
            txtTask.text = task.name
            dtpTask.date  = task.dateTime as! Date
            swtIsAlarmMessageOn.setOn(task.isAlarmOn == 1, animated: true)
            if task.image != nil {
                if let imageData = UIImage(data: task.image as! Data) {
                    imgPhoto.image = imageData
                }
            }
            
        } else {
            // Set the Operation
            _strTitle = "Add"
            _enmOperation = genmOperation.Add
            
            // Set the variables for Lookups
            MyGlobals.shared.selectedTone = MyGlobals.shared.arrTone[0]
            MyGlobals.shared.selectedIcon = MyGlobals.shared.arrIcon[0]
            
            // Set the value of Data Entry
            txtTask.text = ""
            dtpTask.date  = Date()
            swtIsAlarmMessageOn.setOn(true, animated: true)
        }
        
        // Set value to general controls
        navItem.title = _strTitle
        
        // Set focus
        txtTask.becomeFirstResponder()
        txtTask.delegate = self
        txtTask.keyboardType = UIKeyboardType.asciiCapable
        
    }
    
    func updateLookupData() {
        
        // Values taken from the Lookup
        lblToneName.text = "(" + MyGlobals.shared.selectedTone + ")"
        imgIcon.image = UIImage(named: MyGlobals.shared.selectedIcon)
        
        // Make the UIImage for Icon Circle
        imgIcon.layer.borderWidth = 2
        imgIcon.layer.masksToBounds = false
        imgIcon.layer.borderColor = UIColor.gray.cgColor
        imgIcon.layer.cornerRadius = 25
        imgIcon.clipsToBounds = true
        
        // Update the DateTime object
        lblDateTimeSelected.text = MyGlobals.shared.mDateToString(dtpTask.date)
    }
    
// MARK: - Action
    
    @IBAction func btnSave_Tapped(_ sender: AnyObject) {
        if _objTask == nil {
            _objTask = Task(context: gObjContext)
        }
        
        // Pass the value
        _objTask?.name = txtTask.text
        _objTask?.dateTime = dtpTask.date as NSDate?
        if (swtIsAlarmMessageOn.isOn == true) {
            _objTask?.isAlarmOn = 1
        } else {
            _objTask?.isAlarmOn = 0
        }
        _objTask?.tone = MyGlobals.shared.selectedTone
        _objTask?.iconFile = MyGlobals.shared.selectedIcon
        _objTask?.image = UIImageJPEGRepresentation(imgPhoto.image!, 1) as NSData?   // You can low compression up to >0

        
        // Save
        gObjAppDelegate.saveContext()
        
        // _ = self.navigationController?.popToRootViewController(animated: true) // Root
        _ = self.navigationController?.popViewController(animated: true)          // Previous
    }
    
    @IBAction func btnPresets_Tapped(_ sender: UIButton) {
        setDate(sender)
    }
    
    @IBAction func btnSelectPhoto_Tapped(_ sender: AnyObject) {
    
        let imagePickController = UIImagePickerController()
        imagePickController.delegate = self
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Camera
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
                imagePickController.sourceType = .camera
                imagePickController.allowsEditing = false
                self.present(imagePickController, animated: true, completion: nil)
            }
        }))
        
        //Photo Library
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action: UIAlertAction) in
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)) {
                imagePickController.sourceType = .photoLibrary
                imagePickController.allowsEditing = true
                self.present(imagePickController, animated: true, completion: nil)
            }
        }))
        
        // Cancel BUtton
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Present the actionsheet
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func dtpTask_ValueChanged(_ sender: UIDatePicker) {
        updateLblDateTimeSelected(sender)
    }

// MARK: - Events
    
    // Remove the focus on textView
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtTask.resignFirstResponder()
        return true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgPhoto.image = image
        } else{
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!){
        // MARK: - Delete this
        
//        imgPhoto.image = image
//        picker.dismiss(animated: true, completion: nil);
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
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
            tvc._intIndex = _intIndex
        } else if (segue.identifier == "segueIconView") {
            
        }
    }
    
    
// MARK: - Methods
    
    func setDate(_ sender: UIButton) {
        let locDate = dtpTask.date
        let locCalendar = Calendar.current
        var locComponent = locCalendar.dateComponents([.day,.month,.year, .hour, .minute, .second], from: locDate)
        
        _curDate = Date()
        _curCalendar = Calendar.current
        _curComponent = _curCalendar.dateComponents([.day,.month,.year, .hour, .minute, .second], from: _curDate)
        
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
            locComponent.day = _curComponent.day
            locComponent.month = _curComponent.month
            locComponent.year = _curComponent.year
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
 
    func saveData() {
        // MARK: - Delete this
        
//        let task = Task(context: gObjContext)
//        task.name = txtTask.text!
//        gObjAppDelegate.saveContext()
    }
    
}

