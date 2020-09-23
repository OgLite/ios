//
//  Cell_Model.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Cell_Model: UICollectionViewCell {
    var selectmodel=""
    @IBOutlet weak var tit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func toYear(_ sender: Any) {
        PublicBeans.Model=selectmodel
        JzActivity.getControlInstance.changePage(Page_Select_Year(), "Page_Select_Year", true)
    }
  
  
}
public class model{
     var model=[String]()
  }
