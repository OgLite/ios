//
//  Page_Update.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/3/10.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
class Page_Update: UIViewController {

    @IBOutlet var versioncode: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        versioncode.text=Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
       
    }

    override func viewWillAppear(_ animated: Bool) {
        DonloadFile.checkUpdate(caller: {a in
            JzActivity.getControlInstance.closeDialLog()
            if(a){
                JzActivity.getControlInstance.toast("更新成功")
                JzActivity.getControlInstance.setPro("update", "nodata")
            }else{
                JzActivity.getControlInstance.toast("更新失敗")
            }
        })
    }
   

}
