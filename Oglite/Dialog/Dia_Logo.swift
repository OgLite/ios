//
//  Dia_Logo.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/5/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Dia_Logo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            sleep(3)
            DispatchQueue.main.async {
                JzActivity.getControlInstance.closeDialLog("Dia_Logo")
            }
        }
    }
}
