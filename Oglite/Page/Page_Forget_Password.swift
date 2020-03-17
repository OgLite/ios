//
//  Page_Forget_Password.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/30.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
class Page_Forget_Password: UIViewController {
    @IBOutlet var mail: UITextField!
    @IBOutlet var sub: UIButton!
    @IBOutlet var l2: UILabel!
    @IBOutlet var l1: UILabel!
    var run=false
    override func viewDidLoad() {
        super.viewDidLoad()
        l1.text=("Og_email".Mt())
        l2.text=("Go_email".Mt())
        sub.setTitle(("Submit".Mt()), for: .normal)
    }
    
    @IBAction func submit(_ sender: Any) {
        if(run){return}
        run=true
        let a=Progress()
        a.label=a.資料載入
        JzActivity.getControlInstance.openDiaLog(a,true, "Progress")
        Cloud.ResetPass(mail.text!,{
            a in
            JzActivity.getControlInstance.closeDialLog()
            let f=DataLoading()
            self.run=false
            switch(a){
            case 0:
                f.label=f.傳送信件
                break
            case 1:
                f.label=f.沒有網路
                break
            case -1:
                f.label=f.沒有網路
                break
            default:
                break
            }
            JzActivity.getControlInstance.openDiaLog(f,true,"Progress")
        })
    }
    
    
    
}
