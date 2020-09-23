//
//  SignOut.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/3/10.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class SignOut: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancel(_ sender: Any) {
        JzActivity.getControlInstance.closeDialLog()
    }
    
    
    @IBAction func yes(_ sender: Any) {
        JzActivity.getControlInstance.removePro()
       exit(0)
    }
    
}
