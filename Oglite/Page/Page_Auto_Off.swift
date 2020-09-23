//
//  Page_Auto_Off.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/5/14.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzSimplePicker
import JzOsFrameWork
class Page_Auto_Off: UIViewController {
    var time:SimplePicker! = nil
    
    @IBOutlet var timebt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ok(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
    @IBAction func autolock(_ sender: Any) {
        time.open()
    }
    override func viewDidAppear(_ animated: Bool) {
        time=SimplePicker(view,["jz.366".getFix(),"jz.367".getFix(),"jz.368".getFix(),"jz.369".getFix(),"jz.370".getFix()], {a in
            self.timebt.setTitle(a, for: .normal)
            switch a{
            case "jz.366".getFix():
                SharePre.sleepTime=60
                break
            case "jz.367".getFix():
                SharePre.sleepTime=180
                break
            case "jz.368".getFix():
                SharePre.sleepTime=300
                break
            case "jz.369".getFix():
                SharePre.sleepTime=600
                break
            case "jz.370".getFix():
                SharePre.sleepTime=1800
                break
            default:
                break
            }
        },UIColor(named: "backcolor")!,Int(view.frame.width/1.7))
        time.close()
        self.timebt.setTitle(["jz.366".getFix(),"jz.367".getFix(),"jz.368".getFix(),"jz.369".getFix(),"jz.370".getFix()][[60,180,300,600,1800].firstIndex(of: SharePre.sleepTime)!], for: .normal)
        
    }
    
    
    
}
