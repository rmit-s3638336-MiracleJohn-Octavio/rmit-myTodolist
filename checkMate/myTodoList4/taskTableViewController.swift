//
//  taskTableViewController.swift
//  checkMate
//
//  Created by Miracle John Octavio Jr on 20/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit
import CoreData

class taskTableViewController: UITableViewController {
    
// MARK: - Variables
    
    // Array that will hold the record from Core Data
    var _arrTask = [Task]()

// MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init Globals
        MyGlobals.shared.mInitialize()        
        
        // Create Timer
//        let tmrReloadData = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(reloadData), userInfo: nil, repeats: true)
//        tmrReloadData.fire()
    }
    
    func viewDidAppear_Old(_ animated: Bool) {
        
        // Sort the Array by Date Descending
        MyGlobals.shared.arrTask.sort{ $1.DateTime > $0.DateTime}
        
        // Reload Data
        reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*
         Function:
         - This will Load records from CoreData to Array everytime the View will appear
         */
        
        let objRequest = NSFetchRequest<Task>(entityName: "Task")                   // Need to "import CoreData"
        // let objPredicate = NSPredicate(format: "name CONTAINS[cd] %@", "alpha")
        // objRequest.predicate = objPredicate
        
        _arrTask = (try! gObjContext.fetch(objRequest))
        self.tableView.reloadData()
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
// MARK: - DataSource
    
    // mjNotes: Returns the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // mjNotes: Returns the total numnber of array elements
    func tableView_Old(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyGlobals.shared.arrTask.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
         Function:
         - This will return the number if elements from an Array that contains the records from Core Data
         */
        
        return _arrTask.count
        
    }
    
    // mjNotes: If the row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row // mjNotes: Selected Row
        print("Row: \(row)")
    }
    
    // mjNotes: Delete Row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MyGlobals.shared.arrTask.remove(at: indexPath.row) // Remove Element from Array
            tableView.reloadData() // Reload data from TableView
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
// MARK: - Data Load
    
    // mjNotes: This will fill up the cells with rows found
    // Data Load
    func tableView_Old(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell", for: indexPath) as! taskTableViewCell
        
        cell.lblTask.text = MyGlobals.shared.arrTask[indexPath.row].Task
        cell.btnCheckTask.tag = indexPath.row
        
        let dteDateToday_DateFormat = MyGlobals.shared.mDateToString(Date(),genmDateFormat.MonDayYrs)
        let dteDateOnList_DateFormat  = MyGlobals.shared.mDateToString(MyGlobals.shared.arrTask[indexPath.row].DateTime,genmDateFormat.MonDayYrs)
        let dteDateToday_TimeFormat = MyGlobals.shared.mDateToDate(Date())
        let dteDateOnList_TimeFormat  = MyGlobals.shared.mDateToDate(MyGlobals.shared.arrTask[indexPath.row].DateTime)
        
        if (dteDateOnList_DateFormat == dteDateToday_DateFormat) {
            // Today
            
            let elapsed = Date().timeIntervalSince(dteDateOnList_TimeFormat)
            if (dteDateOnList_TimeFormat < dteDateToday_TimeFormat) {
                // Past
                cell.lblDateTime.text = MyGlobals.shared.mDateToString(MyGlobals.shared.arrTask[indexPath.row].DateTime,genmDateFormat.HrsMinSec)
                cell.lblDateTime.textColor = UIColor.red
            } else {
                // Future
                cell.lblDateTime.text = MyGlobals.shared.mDateToString(MyGlobals.shared.arrTask[indexPath.row].DateTime,genmDateFormat.HrsMinSec) + " (" + MyGlobals.shared.mSecondsToHoursMinutes(Int(elapsed) * -1) + ")"
                cell.lblDateTime.textColor = UIColor.darkGray
            }
        } else {
            // Not Today
            cell.lblDateTime.text = MyGlobals.shared.mDateToString(MyGlobals.shared.arrTask[indexPath.row].DateTime)
            if (dteDateOnList_TimeFormat < dteDateToday_TimeFormat) {
                // Past
                cell.lblDateTime.textColor = UIColor.red
            } else {
                // Future
                cell.lblDateTime.textColor = UIColor.darkGray
            }
        }
        
        if (MyGlobals.shared.arrTask[indexPath.row].IsTaskComplete == 0 ) {
            cell.btnCheckTask.setImage(MyGlobals.shared.imgUnChecked, for: .normal)
            
            // Make it black
            cell.lblTask.textColor = UIColor.black
        } else {
            cell.btnCheckTask.setImage(MyGlobals.shared.imgChecked, for: .normal)
            
            // Strikethrough
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: cell.lblTask.text!)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
            cell.lblTask.attributedText = attributeString
            
            // Make it grey
            cell.lblTask.textColor = UIColor.lightGray
        }
        
        // Icon
        if (MyGlobals.shared.arrTask[indexPath.row].IconFile != "") {
            cell.imgIcon.image = UIImage(named: MyGlobals.shared.arrTask[indexPath.row].IconFile)
        } else {
            cell.imgIcon.image = UIImage(named: "emptyIcon.png")
        }
        // Make the UIImage for Icon Circle
        cell.imgIcon.layer.borderWidth = 2
        cell.imgIcon.layer.masksToBounds = false
        cell.imgIcon.layer.borderColor = UIColor.gray.cgColor
        cell.imgIcon.layer.cornerRadius = 25
        cell.imgIcon.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
         Function:
         - This will load the element from array to the TableViewController cells
         */
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell", for: indexPath) as! taskTableViewCell
        
        let objTask = _arrTask[indexPath.row]
        cell.lblTask?.text = objTask.name
        
        return cell
    }

    
    
// MARK: - Navigation
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    func prepare_Old(for segue: UIStoryboardSegue, sender: Any?) {
        let lEntryTableViewController: entryTableViewController = segue.destination as! entryTableViewController
        
        if (segue.identifier == "segueAddViewController") {
            
            lEntryTableViewController.enmOperation = genmOperation.Add
            
        } else if (segue.identifier == "segueEditViewController") {
            
            var selectedIndexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            lEntryTableViewController.intIndex = selectedIndexPath.row
            lEntryTableViewController.enmOperation = genmOperation.Edit
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
         Function:
         - This will call the ViewController that will have the Data Entry
         - It will pass the value of the current selected cell to the ViewController
         
         */
        
        if segue.identifier == "segueEditViewController" {
            let v = segue.destination as! entryTableViewController
            let indexpath = self.tableView.indexPathForSelectedRow
            v._objTask = _arrTask[(indexpath?.row)!]
        }
    }
    
// MARK: - Methods
    
    
    /*
     mjNotes:
     These next 2 functions will auto adjust the lblTask from
     TableViewCell. Without these function thew cell will
     not automatically adjust its height
     
     Label must have constraint of leading, trailing, top,
     bottom and width
     
     */
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
