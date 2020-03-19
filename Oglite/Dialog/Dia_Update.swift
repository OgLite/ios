//
//  Dia_Update.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/3/11.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
class Dia_Update: UIViewController {

    @IBOutlet var intext: UILabel!
    @IBOutlet var content: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intext.text=JzActivity.getControlInstance.getPro("update", "已有新版本!!")
    }
    
    @IBAction func cancel(_ sender: Any) {
        JzActivity.getControlInstance.closeDialLog()
    }
    
    @IBAction func ok(_ sender: Any) {
        JzActivity.getControlInstance.closeDialLog()
      JzActivity.getControlInstance.setPro("dataloading", "false")
               DonloadFile.dataloading()
    }
    
}
