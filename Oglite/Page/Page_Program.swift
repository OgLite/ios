//
//  Page_Program.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/24.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsTool
import JzOsFrameWork
class Page_Program: UIViewController {
    
    @IBOutlet var nextbt: UIButton!
    @IBOutlet var quality: UILabel!
    @IBOutlet var tit: UILabel!
    @IBOutlet var numbercount: JzTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        numbercount.digits="1234"
        numbercount.textCount=1
        tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)/\(PublicBeans.Year)"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        nextbt.setTitle("jz.145".getFix(), for: .normal)
        quality.text="jz.249".getFix()
    }
    
    @IBAction func next(_ sender: Any) {
        if(numbercount.text!.isEmpty){
            PublicBeans.燒錄數量=4
        }else{
            PublicBeans.燒錄數量=Int(numbercount.text!)!
        }
        JzActivity.getControlInstance.changePage(Page_Program_Detail(), "Page_Program_Detail", true)
    }
    
    @IBAction func goMenu(_ sender: Any) {
    JzActivity.getControlInstance.goMenu()
    }
}
