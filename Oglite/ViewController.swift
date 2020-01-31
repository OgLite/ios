//
//  ViewController.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/29.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
import IQKeyboardManagerSwift
class ViewController:JzActivity {
    @IBOutlet weak var backbt: UIButton!
    @IBOutlet weak var container: UIView!
    override func viewInit() {
        IQKeyboardManager.shared.enable=true
        rootView=container
        let area=JzActivity.getControlInstance.getNewController("Main", "Page_Area") as! Page_Area
        JzActivity.getControlInstance.setHome(area, "area")
    }
    override func changePageListener(_ controler: pagemenory) {
        if(Pagememory.count<2){
            backbt.isHidden=true
        }else{
            backbt.isHidden=false
        }
        print("Switch\(controler.tag)")
    }
    
    @IBAction func goback(_ sender: Any) {
        JzActivity.getControlInstance.goBack()
    }
}

