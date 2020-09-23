//
//  Dia_Update.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/3/11.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Dia_Update: UIViewController {
    
    @IBOutlet var content: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancel(_ sender: Any) {
        JzActivity.getControlInstance.closeDialLog()
    }
    
    @IBAction func ok(_ sender: Any) {
        Command.cangetBattery=false
        let a=DataLoading()
        a.label=a.檢查更新
        JzActivity.getControlInstance.openDiaLog(a, false, "DataLoading")
        DonloadFile().dataloading({
            a in
            Command.cangetBattery=true
            DispatchQueue.main.async {
                if(a){
                    JzActivity.getControlInstance.closeDialLog()
                    PublicBeans.資料庫.autoCreat()
                }else{
                     JzActivity.getControlInstance.closeDialLog()
                    var fa=Dia_NoSensor()
                    fa.labeltext="jz.386".getFix()
                JzActivity.getControlInstance.openDiaLog(fa, false, "Dia_NoSensor")
                }
            }
        })
    }
    
}
