//
//  Dia_NoSensor.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/4/6.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Dia_NoSensor: UIViewController {

    @IBOutlet var label: UILabel!
    var labeltext="jz.300".getFix()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text=labeltext
        
    }

    @IBAction func close(_ sender: Any) {
        JzActivity.getControlInstance.closeDialLog("Dia_NoSensor")
    }
    

}
