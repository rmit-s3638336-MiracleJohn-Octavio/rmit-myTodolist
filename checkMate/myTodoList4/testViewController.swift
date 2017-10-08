//
//  testViewController.swift
//  checkMate
//
//  Created by Miracle John Octavio Jr on 8/10/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit
import AudioToolbox

class testViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var txtSystemSoundID: UITextField!

    @IBAction func btnTest_Tapped(_ sender: AnyObject) {
        
        let id: UInt32 = UInt32(txtSystemSoundID.text!)!
        
        AudioServicesPlaySystemSound(SystemSoundID(id))
        
    }
    

}
