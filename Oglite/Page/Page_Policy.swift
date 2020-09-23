//
//  Page_Policy.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/29.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Page_Policy: UIViewController {
    @IBOutlet weak var agr: UIButton!
    @IBOutlet weak var dis: UIButton!
    @IBOutlet weak var policy: UITextView!
    var Setting=false
    override func viewDidLoad() {
        super.viewDidLoad()
        policy.text="jz.72".getFix()
        dis.setTitle("Disagree".getFix(), for: .normal)
        agr.setTitle((Setting) ? "jz.9".getFix():"jz.145".getFix(), for: .normal)
    }

    @IBAction func disagree(_ sender: Any) {
        JzActivity.getControlInstance.closeApp()
    }
    
    @IBAction func agree(_ sender: Any) {
        if(Setting){
            JzActivity.getControlInstance.goMenu()
        }else{
            let a=JzActivity.getControlInstance.getNewController("Main", "Page_SignIn")
                   JzActivity.getControlInstance.changePage(a, "Page_SignIn", true)
                   
        }
       
    }
}
