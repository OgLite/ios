//
//  Page_Update.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/3/10.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Page_Update: UIViewController {

    @IBOutlet var versioncode: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        versioncode.text=Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
       
    }

    override func viewWillAppear(_ animated: Bool) {
    }
   

}
