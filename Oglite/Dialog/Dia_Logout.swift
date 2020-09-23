//
//  Dia_Logout.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/5/14.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Dia_Logout: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.fixLanguage()
    }

    @IBAction func close(_ sender: Any) {
        JzActivity.getControlInstance.closeDialLog()
    }
    @IBAction func out(_ sender: Any) {
        JzActivity.getControlInstance.setPro("admin", "nodata")
        JzActivity.getControlInstance.closeApp()
    }
    
}
