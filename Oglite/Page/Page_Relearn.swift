//
//  Page_Relearn.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
class Page_Relearn: UIViewController {
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var tit: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)/\(PublicBeans.Year)"
        content.text=ItemDao.getRelearm()
    }
    
    @IBAction func readid(_ sender: Any) {
        
        switch PublicBeans.選擇按鈕 {
        case Page_Home.tit[0]:
            let page=Page_Idcopy_obd()
            JzActivity.getControlInstance.changePage(page, Page_Home.tit[0], true)
            break
        case Page_Home.tit[1]:
            let page=Page_Idcopy_obd()
            JzActivity.getControlInstance.changePage(page, Page_Home.tit[1], true)
            break
        case Page_Home.tit[3]:
            let page=Page_Idcopy_obd()
            JzActivity.getControlInstance.changePage(page, Page_Home.tit[3], true)
            break
        case Page_Home.tit[2]:
            JzActivity.getControlInstance.changePage(Page_Program(), Page_Home.tit[2], true)
            break
        default:
            break
        }
    }
    
}
