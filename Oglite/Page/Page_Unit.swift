//
//  Page_Unit.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/5/14.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzSimplePicker
import JzOsFrameWork
class Page_Unit: UIViewController {
    var pre:SimplePicker! = nil
    var tem:SimplePicker! = nil
    
    @IBOutlet var prebt: UIButton!
    @IBOutlet var tembt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        pre=SimplePicker(view,["jz.377".getFix(),"jz.378".getFix(),"jz.379".getFix()], {a in
            self.prebt.setTitle(a, for: .normal)
            SharePre.pre=["jz.377".getFix(),"jz.378".getFix(),"jz.379".getFix()].firstIndex(of: a)!
        },UIColor(named: "backcolor")!,Int(view.frame.width/1.7))
        
        tem=SimplePicker(view,["jz.375".getFix(),"jz.376".getFix()], {a in
            self.tembt.setTitle(a, for: .normal)
            SharePre.tem=["jz.375".getFix(),"jz.376".getFix()].firstIndex(of: a)!
              },UIColor(named: "backcolor")!,Int(view.frame.width/1.7))
        tem.close()
        pre.close()
        self.prebt.setTitle(["jz.377".getFix(),"jz.378".getFix(),"jz.379".getFix()][SharePre.pre], for: .normal)
        self.tembt.setTitle(["jz.375".getFix(),"jz.376".getFix()][SharePre.tem], for: .normal)
    }
    @IBAction func setire(_ sender: Any) {
        tem.close()
        pre.open()
    }
    @IBAction func setup(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
    
    @IBAction func setpre(_ sender: Any) {
        tem.open()
        pre.close()
    }
}
