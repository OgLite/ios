//
//  Page_Reset_Password.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/3/10.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Page_Reset_Password: UIViewController {

    @IBOutlet var username: UITextField!
    
    @IBOutlet var confirmpass: UITextField!
    @IBOutlet var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func setup(_ sender: Any) {
       
        let admin=JzActivity.getControlInstance.getPro("admin", "nodata")
        if(admin != username.text){
            JzActivity.getControlInstance.toast("請再次確認您的信箱")
            return
        }
        if(password!.text!.isEmpty){
            JzActivity.getControlInstance.toast("密碼不得為空")
            return
        }
        if(password!.text != confirmpass!.text){
            JzActivity.getControlInstance.toast("請再次確認密碼")
                       return
        }
         JzActivity.getControlInstance.openDiaLog(Progress(), false, "Progress")
        Cloud.AddIfNotValid("resetpassword", admin, password!.text!, {
            a in
            DispatchQueue.main.async {
                JzActivity.getControlInstance.closeDialLog()
                if(a){
                    JzActivity.getControlInstance.toast("密碼更改成功!")
                }else{
                    JzActivity.getControlInstance.toast("密碼更改失敗!")
                }
            }
        })
    }
    

}
