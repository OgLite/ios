//
//  Register_error.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/30.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Register_error: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let pan=UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(pan)
    }
    @objc func tap(){
        JzActivity.getControlInstance.closeDialLog()
    }


}
