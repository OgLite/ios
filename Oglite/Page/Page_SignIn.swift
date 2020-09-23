//
//  Page_SignIn.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/29.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Page_SignIn: UIViewController {
    @IBOutlet var forget: UILabel!
    @IBOutlet var sig: UIButton!
    @IBOutlet var reg: UIButton!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var admin: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        reg.setTitle("jz.77".getFix(), for: .normal)
        sig.setTitle("jz.5".getFix(), for: .normal)
        forget.text="jz.79".getFix()
    }
    
    @IBAction func signin(_ sender: Any) {
        let a=Progress()
        a.label="\("jz.5".getFix())..."
        JzActivity.getControlInstance.openDiaLog(a,true,"Progress")
        Cloud.Signin(admin.text!
            , password.text!, {
                result in
                print("response\(result)")
                JzActivity.getControlInstance.closeDialLog()
                switch(result){
                case 0:
                    JzActivity.getControlInstance.setPro("admin", self.admin.text!)
                    JzActivity.getControlInstance.setPro("password", self.password.text!)
                    JzActivity.getControlInstance.setHome(Page_Home(), "Page_Home")
                    break
                case 1:
                    JzActivity.getControlInstance.toast("jz.211".getFix())
                    break
                case -1:
                    JzActivity.getControlInstance.toast("jz.210".getFix())
                    break
                default:
                    break
                }
                
        })
    }
    @IBAction func forget(_ sender: Any) {
        JzActivity.getControlInstance.changePage(Page_Forget_Password(), "Page_Forget_Password", true)
    }
    
    @IBAction func register(_ sender: Any) {
        JzActivity.getControlInstance.changePage(Page_Enroll(), "Page_Enroll", true)
    }
}
