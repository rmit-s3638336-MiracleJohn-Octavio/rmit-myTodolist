//
//  taskTableViewCell.swift
//  checkMate
//
//  Created by Miracle John Octavio Jr on 20/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit

class taskTableViewCell: UITableViewCell {
    
// MARK: - Variables
    
    var _objTask: Task?

//    @IBOutlet weak var btnCheckTask: chkButton!
    @IBOutlet weak var btnCheckTask: UIButton!
    @IBOutlet weak var lblTask: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var imgClockIcon: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    // MARK: - Defaultss
    
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
        if (_objTask?.isTaskComplete == 0) {
            
            // Save
            _objTask?.isTaskComplete = 1
            gObjAppDelegate.saveContext()
            
            sender.setImage(MyGlobals.shared.imgChecked, for: .normal)
            
            // Strikethrough
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: lblTask.text!)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
            lblTask.attributedText = attributeString
            lblTask.textColor = UIColor.lightGray
            
        } else {
            
            // Save
            _objTask?.isTaskComplete = 0
            gObjAppDelegate.saveContext()
            
            sender.setImage(MyGlobals.shared.imgUnChecked, for: .normal)
            
            // Normal
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: lblTask.text!)
            attributeString.removeAttribute(NSStrikethroughStyleAttributeName, range: NSMakeRange(0, attributeString.length))
            lblTask.attributedText = attributeString
            lblTask.textColor = UIColor.black
            
        }
    }

}
