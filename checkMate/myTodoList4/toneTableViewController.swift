//
//  toneTableViewController.swift
//  myTodoList4
//
//  Created by Miracle John Octavio Jr on 10/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit

class toneTableViewController: UITableViewController {
    
    // This will recieve the index from Root
    var intIndex =  Int()

// MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let currRow = indexPath.row
        let toneId = MyGlobals.shared.arrTask[intIndex].ToneId
        
        if (toneId == currRow) {
            cell.btnCheckTone.setImage(MyGlobals.shared.imgChecked_Small, for: .normal)
        } else {
            cell.btnCheckTone.setImage(MyGlobals.shared.imgUnChecked_Small, for: .normal)
        }
        
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
    }
    
    // Reset all checkbox
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row // mjNotes: Selected Row
        print("Row: \(row)")
        
        MyGlobals.shared.arrTask[intIndex].ToneId = indexPath.row
        
        // Back to Root View Controller
        // mjNotes: The "_ =" prevents the compiler from displaying a warning message
//        _ = self.navigationController?.popToRootViewController(animated: true) // Root
        _ = self.navigationController?.popViewController(animated: true)         // Previous
        
    }
    
    

}
