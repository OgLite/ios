//
//  Page_Policy.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/29.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
class Page_Policy: UIViewController {
    @IBOutlet weak var agr: UIButton!
    @IBOutlet weak var dis: UIButton!
    @IBOutlet weak var policy: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        policy.text="Welcome".Mt()
        dis.setTitle("Disagree".Mt(), for: .normal)
        agr.setTitle("Agree".Mt(), for: .normal)
    }

    @IBAction func disagree(_ sender: Any) {
        JzActivity.getControlInstance.closeApp()
    }
    
    @IBAction func agree(_ sender: Any) {
        let a=JzActivity.getControlInstance.getNewController("Main", "Page_SignIn")
        JzActivity.getControlInstance.changePage(a, "Page_SignIn", true)
        
    }
}
