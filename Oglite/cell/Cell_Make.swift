//
//  Cell_Make.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
public class Cell_Make: UICollectionViewCell {
    var selectmake=""
    @IBOutlet weak var carbt: UIButton!
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func tomodel(_ sender: Any) {
        PublicBeans.Make=selectmake
        JzActivity.getControlInstance.changePage(Page_Select_Model(), "Page_Select_Model", true)
    }
   
   
}
public class make{
      var make=[String]()
      var makeing=[String]()
   }
