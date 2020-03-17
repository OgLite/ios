//
//  Cell_Year.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
class Cell_Year: UICollectionViewCell {
    var selectyear=""
    @IBOutlet weak var tit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func goPage(_ sender: Any) {
        PublicBeans.Year=selectyear
        switch PublicBeans.選擇按鈕 {
        case Page_Home.tit[0]:
            JzActivity.getControlInstance.changePage(Page_Relearn(), "Page_Relearn", true)
            break
        case Page_Home.tit[1]:
            JzActivity.getControlInstance.changePage(Page_Relearn(), "Page_Relearn", true)
        case Page_Home.tit[3]:
            JzActivity.getControlInstance.changePage(Page_Relearn(), "Page_Relearn", true)
            break
        case Page_Home.tit[2]:
            JzActivity.getControlInstance.changePage(Page_Program(), Page_Home.tit[2], true)
            break
        case Page_Home.tit[4]:
            JzActivity.getControlInstance.changePage(Page_CheckSensor_Location(), Page_Home.tit[4], true)
            break
        default:
            break
        }
    }
    
}
public class year{
    var year=[String]()
}
