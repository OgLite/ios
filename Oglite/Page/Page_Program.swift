//
//  Page_Program.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/24.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsTool
import JzIos_Framework
class Page_Program: UIViewController {
    
    @IBOutlet var tit: UILabel!
    @IBOutlet var numbercount: JzTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        numbercount.digits="1234"
        numbercount.textCount=1
        tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)/\(PublicBeans.Year)"
        
    }
    
    
    @IBAction func next(_ sender: Any) {
        if(numbercount.text!.isEmpty){
            PublicBeans.燒錄數量=4
        }else{
            PublicBeans.燒錄數量=Int(numbercount.text!)!
        }
        JzActivity.getControlInstance.changePage(Page_Program_Detail(), "Page_Program_Detail", true)
    }
    
}
