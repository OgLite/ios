//
//  Dia_Select_Way.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Dia_Select_Way: UIViewController {
    var dismissback:(()->Void?)? = nil
    @IBOutlet var entersensorid: UILabel!
    @IBOutlet var keytit: UILabel!
    @IBOutlet var readtit: UILabel!
    @IBOutlet var scantit: UILabel!
    
    @IBOutlet var scanhint: UILabel!
    @IBOutlet var keyint: UILabel!
    @IBOutlet var readt: UILabel!
    @IBOutlet var scanlabelt: UILabel!
    @IBOutlet var scanlabel: UILabel!
    @IBOutlet var tit: UILabel!
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
    override func viewDidAppear(_ animated: Bool) {
        keyint.text="jz.26".getFix()
        readt.text="jz.231".getFix()
        scanlabel.text="jz.120".getFix()
        entersensorid.text="jz.137".getFix()
        scanhint.text="jz.314".getFix()
    }
}
