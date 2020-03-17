//
//  Dia_Select_Way.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
class Dia_Select_Way: UIViewController {
    var dismissback:(()->Void?)? = nil
    @IBOutlet var entersensorid: UILabel!
    @IBOutlet var keytit: UILabel!
    @IBOutlet var readtit: UILabel!
    @IBOutlet var scantit: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func toScan(_ sender: Any) {
        if(dismissback != nil){dismissback!()}
        
        PublicBeans.selectway=PublicBeans.Scan
        JzActivity.getControlInstance.closeDialLog("Dia_Select_Way")
    }
    
    @IBAction func toTrigger(_ sender: Any) {
        if(dismissback != nil){dismissback!()}
        PublicBeans.selectway=PublicBeans.Trigger
       JzActivity.getControlInstance.closeDialLog("Dia_Select_Way")
       
    }
    
    @IBAction func toKeyin(_ sender: Any) {
        if(dismissback != nil){dismissback!()}
        PublicBeans.selectway=PublicBeans.KetIn
       JzActivity.getControlInstance.closeDialLog("Dia_Select_Way")
        
    }
}
