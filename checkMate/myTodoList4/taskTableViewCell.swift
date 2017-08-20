//
//  taskTableViewCell.swift
//  checkMate
//
//  Created by Miracle John Octavio Jr on 20/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit

class taskTableViewCell: UITableViewCell {

//    @IBOutlet weak var btnCheckTask: chkButton!
    @IBOutlet weak var btnCheckTask: UIButton!
    @IBOutlet weak var lblTask: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    
    // MARK: - Defaults
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //        updateCheckbox(btnCheckTask)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Events
    
    @IBAction func btnCheckTask_Tapped(_ sender: UIButton) {
        updateCheckbox(sender)
    }
    
    // MARK: - Methods
    
    func updateCheckbox (_ sender:UIButton) {
        if (MyGlobals.shared.arrTask[sender.tag].IsTaskComplete == 0) {
            MyGlobals.shared.arrTask[sender.tag].IsTaskComplete = 1
            sender.setImage(MyGlobals.shared.imgChecked, for: .normal)
        } else {
            MyGlobals.shared.arrTask[sender.tag].IsTaskComplete = 0
            sender.setImage(MyGlobals.shared.imgUnChecked, for: .normal)
        }
    }

}
