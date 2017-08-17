//
//  MainTableViewController.swift
//  myTodoList4
//
//  Created by Miracle John Octavio Jr on 6/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit


class MainTableViewController: UITableViewController {
    
// MARK: - Load

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // mjNotes: Prepare Initial Data            .
        var arrTaskList = MyGlobals.shared.mStringToArray("First,Second Second Second Second Second Second Second Second Second Second Second Second ,Third")
        var arrTaskCompleted = [1, 0, 1]
        var arrTaskDateTime = MyGlobals.shared.mStringToArray(MyGlobals.shared.mDateToString(Date()) + "|" + MyGlobals.shared.mDateToString(Date()) + "|" + MyGlobals.shared.mDateToString(Date()),"|")
        var arrIsAlarmMessageOn = [1, 1, 0]
        
        for i in 0 ..< arrTaskList.count {
            var lStruTask = gstruTask()
            lStruTask.Task = arrTaskList[i]
            lStruTask.IsTaskComplete = arrTaskCompleted[i]
            lStruTask.DateTime = MyGlobals.shared.mStringToDate(arrTaskDateTime[i])
            lStruTask.IsAlarmMessageOn = arrIsAlarmMessageOn[i]
            MyGlobals.shared.arrTask.append(lStruTask)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Sort the Array by Date Descending
        MyGlobals.shared.arrTask.sort{ $1.DateTime > $0.DateTime}
        // Reload Data
        self.tableView.reloadData()
    }

// MARK: - DataSource
    
    // mjNotes: Returns the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // mjNotes: Returns the total numnber of array elements
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyGlobals.shared.arrTask.count
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
    
    // mjNotes: This will fill up the cells with rows found
    // Data Load
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as! customTableViewCell
        
        cell.lblTask.text = MyGlobals.shared.arrTask[indexPath.row].Task
        cell.btnCheckTask.tag = indexPath.row
        
        let dteDateToday_DateFormat = MyGlobals.shared.mDateToString(Date(),genmDateFormat.MonDayYrs)
        let dteDateOnList_DateFormat  = MyGlobals.shared.mDateToString(MyGlobals.shared.arrTask[indexPath.row].DateTime,genmDateFormat.MonDayYrs)
        let dteDateToday_TimeFormat = MyGlobals.shared.mDateToDate(Date())
        let dteDateOnList_TimeFormat  = MyGlobals.shared.mDateToDate(MyGlobals.shared.arrTask[indexPath.row].DateTime)
        
        if (dteDateOnList_DateFormat == dteDateToday_DateFormat) {
            // Today
            cell.lblDateTime.text = MyGlobals.shared.mDateToString(MyGlobals.shared.arrTask[indexPath.row].DateTime,genmDateFormat.HrsMin)
            if (dteDateOnList_TimeFormat < dteDateToday_TimeFormat) {
                // Past
                cell.lblDateTime.textColor = UIColor.red
            } else {
                // Future
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
        } else {
            cell.btnCheckTask.setImage(MyGlobals.shared.imgChecked, for: .normal)
        }
        
        return cell
    }
    

// MARK: - Navigation
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let lEntryTableViewController: entryTableViewController = segue.destination as! entryTableViewController
        if (segue.identifier == "segueAddViewController") {
            lEntryTableViewController.enmOperation = genmOperation.Add
        } else if (segue.identifier == "segueEditViewController") {
            var selectedIndexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            lEntryTableViewController.intIndex = selectedIndexPath.row
            
            lEntryTableViewController.enmOperation = genmOperation.Edit
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
    
    
    @IBAction func test(_ sender: AnyObject) {
        print(MyGlobals.shared.mDateToString(Date(),genmDateFormat.MonDayYrs))
    }
    
// MARK: - Unused Default Code
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
}
