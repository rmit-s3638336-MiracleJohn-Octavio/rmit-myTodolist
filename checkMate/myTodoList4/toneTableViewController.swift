//
//  toneTableViewController.swift
//  myTodoList4
//
//  Created by Miracle John Octavio Jr on 10/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit

// MARK: - Protocol

// Custom Delegation Step # 1
protocol ToneSelectedDelegate: class {
    func toneSelected(strToneSelected: String)
}

class toneTableViewController: UITableViewController {
    
// MARK: - Variables
    
    // This will recieve the index from Root
    var _intIndex =  Int()
    
    // Custom Delegation Step # 2
    weak var delegate:ToneSelectedDelegate?
    
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
        let currentTone = MyGlobals.shared.arrTone[indexPath.row]
        
        cell.lblTone.text = currentTone
        
        if (MyGlobals.shared.selectedTone == currentTone) {
            cell.btnCheckTone.setImage(MyGlobals.shared.imgChecked_Small, for: .normal)
        } else {
            cell.btnCheckTone.setImage(MyGlobals.shared.imgUnChecked_Small, for: .normal)
        }
        
        cell.isAccessibilityElement = true
        return cell
    }
    
// MARK: - Navigation
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    // Reset all checkbox
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get the selected tone
        MyGlobals.shared.selectedTone = MyGlobals.shared.arrTone[indexPath.row]
        
        // Custom Delegation Step # 3
        self.delegate?.toneSelected(strToneSelected: MyGlobals.shared.arrTone[indexPath.row])
        
        // Back to Root View Controller
        // _ = self.navigationController?.popToRootViewController(animated: true) // Root
        _ = self.navigationController?.popViewController(animated: true)          // Previous
        
    }
    
    

}
