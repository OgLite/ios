//
//  Dia_Reset.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/5/14.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Dia_Reset: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.fixLanguage()
    }

    @IBAction func cancel(_ sender: Any) {
        JzActivity.getControlInstance.closeDialLog()
    }
    
   
    @IBAction func setup(_ sender: Any) {
        JzActivity.getControlInstance.removePro()
        JzActivity.getControlInstance.closeApp()
    }
    
}
