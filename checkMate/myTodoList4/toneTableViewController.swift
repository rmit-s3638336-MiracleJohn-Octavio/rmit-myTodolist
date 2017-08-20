//
//  toneTableViewController.swift
//  myTodoList4
//
//  Created by Miracle John Octavio Jr on 10/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit

class toneTableViewController: UITableViewController {

// MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyGlobals.shared.arrTone = MyGlobals.shared.mStringToArray("Apex,Beacon,Bulletin,By The Seaside,Chimes,Circuit,Constellation,Cosmic,Crystals")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
// MARK: - DataSource
    
    // mjNotes: Returns the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // mjNotes: Returns the total numnber of array elements
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyGlobals.shared.arrTone.count
    }
    
    // mjNotes: This will fill up the cells with rows found
    // Data Load
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toneTableViewCell", for: indexPath) as! toneTableViewCell
        cell.lblTone.text = MyGlobals.shared.arrTone[indexPath.row]
        return cell
    }
    
    // mjNotes: Delete Row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // TODO: Delete this if done testing
//        if editingStyle == .delete {
//            gArrTaskList.remove(at: indexPath.row) // Remove Element from Array
//            tableView.reloadData() // Reload data from TableView
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
    }
    
    
// MARK: - Navigation
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        // mjNotes: Pass the selected row to the new View
//        
//        
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//        if (segue.identifier == "segueEditViewController") {
//            var selectedIndexPath: IndexPath = self.tableView.indexPathForSelectedRow!
//            let editVC: editViewController = segue.destination as! editViewController
//            
//            // Pass the value
//            editVC.strTask = gArrTask[selectedIndexPath.row].Task
//            editVC.intIndex = selectedIndexPath.row
//        }

    }
    
    // Reset all checkbox
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row // mjNotes: Selected Row
        print("Row: \(row)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toneTableViewCell", for: indexPath) as! toneTableViewCell
        cell.btnCheckTone.setImage(MyGlobals.shared.imgUnChecked_Small, for: .normal)
        
    }
    
    

}
