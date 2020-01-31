//
//  Page_SignIn.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/29.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
class Page_SignIn: UIViewController {
    @IBOutlet var forget: UILabel!
    @IBOutlet var sig: UIButton!
    @IBOutlet var reg: UIButton!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var admin: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        reg.setTitle("Registration".Mt(), for: .normal)
        sig.setTitle("Sign_in".Mt(), for: .normal)
        forget.text="Forgot_password".Mt()
    }
    
    @IBAction func signin(_ sender: Any) {
        let a=Progress()
        a.label="\("Sign_in".Mt())..."
        JzActivity.getControlInstance.openDiaLog(a)
        Cloud.Signin(admin.text!
            , password.text!, {
                result in
                print("response\(result)")
                JzActivity.getControlInstance.closeDialLog()
                switch(result){
                case 0:
                    
                    break
                case 1:
                    JzActivity.getControlInstance.toast("errorpass".Mt())
                    break
                case -1:
                    JzActivity.getControlInstance.toast("nointer".Mt())
                    break
                default:
                    break
                }
                
        })
    }
    
    @IBAction func register(_ sender: Any) {
        JzActivity.getControlInstance.changePage(Page_Enroll(), "Page_Enroll", true)
    }
}
