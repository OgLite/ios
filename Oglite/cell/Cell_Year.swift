//
//  Cell_Year.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Cell_Year: UICollectionViewCell {
    var selectyear=""
    @IBOutlet weak var tit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func goPage(_ sender: Any) {
        PublicBeans.Year=selectyear
        JzActivity.getControlInstance.changePage(Page_Relearn(), "Page_Relearn", true)
    }
    
}
public class year{
    var year=[String]()
}
