//
//  iconCollectionViewController.swift
//  checkMate
//
//  Created by Miracle John Octavio Jr on 21/08/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class iconCollectionViewController: UICollectionViewController {
    
// MARK: - Variables
    
    // This will recieve the index from Root
    var intIndex =  Int()

// MARK: - Controls
    
    @IBOutlet var myCollectionView: UICollectionView!
    
// MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // This will calcualte the layout of the collection view
        let itemSize = UIScreen.main.bounds.width/5 - 1
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        myCollectionView.collectionViewLayout = layout
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

// MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return MyGlobals.shared.arrIconFile.count
    }

// MARK: - Data Load
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! iconCollectionViewCell
        
        cell.imgIcon.image = UIImage(named: MyGlobals.shared.arrIconFile[indexPath.row])
        cell.isAccessibilityElement = true
    
        return cell
    }

// MARK: - Events
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        MyGlobals.shared.arrTask_Lookup.IconFile = MyGlobals.shared.arrIconFile[indexPath.row]
        
        // Back to Root View Controller
        // mjNotes: The "_ =" prevents the compiler from displaying a warning message
        //        _ = self.navigationController?.popToRootViewController(animated: true) // Root
        _ = self.navigationController?.popViewController(animated: true)         // Previous
    }
    
// MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */
    

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
