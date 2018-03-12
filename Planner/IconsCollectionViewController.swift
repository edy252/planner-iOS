//
//  IconsCollectionViewController.swift
//  Planner
//
//  Created by Edgar Yu on 2/22/18.
//  Copyright © 2018 AppleInc. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

let iconSize = 50

protocol IconsContainerDelegate: class {
    func addNewSubroutine()
}

class IconsCollectionViewController: UICollectionViewController {
    
//    var icons = [UIColor]()
    var delegate : IconsContainerDelegate?
    var subroutines = [Subroutine]()
    var selectedIndex: Int?
    
    // Delegate method
    @objc func addIconButtonTapped() {
        delegate?.addNewSubroutine()    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subroutines.count + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currentIconCell", for: indexPath) as! CurrentIconsCollectionViewCell
        let editButton = UIButton(frame: CGRect(x:0, y:0, width: iconSize, height: iconSize))
        
        // last collectionViewCell is the add button
        if (indexPath.row == subroutines.count) {
//            editButton.setImage(UIImage(named: "icons8-plus-math-40"), for: UIControlState.normal)
            cell.setButtonImage(with: "icons8-plus-math-40")
//            cell.setIconImage(with: "icons8-plus-math-40")
            editButton.isUserInteractionEnabled = true
            editButton.addTarget(self, action: #selector(addIconButtonTapped), for: UIControlEvents.touchUpInside)
        }
            
        // icon collection cell
        else {
            // if iconPath exists, set button img
            if let iconPath = subroutines[indexPath.row].iconPath {
                cell.setButtonImage(with: iconPath)
            }
            
            // Change border of selected / deselected cells
            if cell.cellIndex == selectedIndex {
                cell.iconButton?.layer.borderColor = UIColor.red.cgColor
                cell.iconButton?.layer.borderWidth = 2
            } else {
                //            cell.layer.borderColor = UIColor.cgColor
                cell.iconButton?.layer.borderWidth = 0
            }
            
//            if let iconPath = subroutines[indexPath.row] {
//                let icon = UIImage(named: iconPath)
//                editButton.setImage(icon, for: UIControlState.normal)
//            }
//            editButton.isUserInteractionEnabled = false
            
            // if does not exist, leave blank
        }
        
        cell.cellIndex = indexPath.row
        
        editButton.maskAsCircle()
        cell.contentView.addSubview(editButton)
//        cell.maskAsCircle()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(iconSize), height: CGFloat(iconSize))
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

//extension UICollectionViewCell {
//    func maskAsCircle() {
//        self.contentMode = UIViewContentMode.scaleAspectFill
//        self.layer.cornerRadius = self.frame.height / 2
//        self.layer.masksToBounds = false
//        self.clipsToBounds = true
//        
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.lightGray.cgColor
//    }
//}

