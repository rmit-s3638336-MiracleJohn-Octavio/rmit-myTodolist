//
//  toneTableViewCell.swift
//  checkMate
//
//  Created by Miracle John Octavio Jr on 20/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit

class toneTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheckTone: UIButton!
    @IBOutlet weak var lblTone: UILabel!
    
    // MARK: - Defaults
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Events
    
    @IBAction func btnCheckTone_Tapped(_ sender: UIButton) {
        updateCheckbox(sender)
    }
    
    // MARK: - Methods
    
    func updateCheckbox (_ sender:UIButton) {
        sender.setImage(MyGlobals.shared.imgChecked_Small, for: .normal)
//        if (MyGlobals.shared.arrTask[sender.tag].IsTaskComplete == 0) {
//            MyGlobals.shared.arrTask[sender.tag].IsTaskComplete = 1
//            sender.setImage(MyGlobals.shared.imgChecked, for: .normal)
//        } else {
//            MyGlobals.shared.arrTask[sender.tag].IsTaskComplete = 0
//            sender.setImage(MyGlobals.shared.imgUnChecked, for: .normal)
//        }
    }

}
