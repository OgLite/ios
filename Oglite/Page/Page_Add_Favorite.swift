//
//  Page_Add_Favorite.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/4.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzSimplePicker
import JzOsFrameWork
import JzOsSqlHelper
class Page_Add_Favorite: UIViewController {
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b1: UIButton!
    var make:SimplePicker! = nil
    var model:SimplePicker! = nil
    var year:SimplePicker! = nil
    var makeitem=PublicBeans.getMake()
    var modelitem=PublicBeans.getModel()
    var yearitem=PublicBeans.getYear()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        make=SimplePicker(view, makeitem.make, {a in
            PublicBeans.Make=a
            PublicBeans.Model=PublicBeans.getModel().model[0]
            PublicBeans.Year=PublicBeans.getYear().year[0]
            print("selection\(a)")
            self.resetUi()
        },UIColor(named: "backcolor")!,Int(view.frame.width/1.7))
        model=SimplePicker(view, modelitem.model, {a in
            PublicBeans.Model=a
            PublicBeans.Year=PublicBeans.getYear().year[0]
            self.resetUi()
        },UIColor(named: "backcolor")!,Int(view.frame.width/1.7))
        year=SimplePicker(view, yearitem.year, {a in
            PublicBeans.Year=a
            self.resetUi()
        },UIColor(named: "backcolor")!,Int(view.frame.width/1.7))
        make.notifyDataSetChange()
        hidden()
        getMmy()
    }
    
    
    @IBAction func selectmake(_ sender: Any) {
        hidden()
        make.open()
    }
    
    @IBAction func selectmodel(_ sender: Any) {
        hidden()
        modelitem=PublicBeans.getModel()
        model.resetitem(modelitem.model)
        model.open()
    }
    
    @IBAction func selectyear(_ sender: Any) {
        hidden()
        yearitem=PublicBeans.getYear()
        year.resetitem(yearitem.year)
        year.open()
    }
    
    @IBAction func back(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
    
    @IBAction func setup(_ sender: Any) {
        let sql=SqlHelper("favorite")
        sql.autoCreat()
        sql.exSql("delete from favorite where make='\(PublicBeans.Make)' and model='\(PublicBeans.Model)' and year='\(PublicBeans.Year)'")
        sql.exSql("insert into `favorite` (make,model,year) values ('\(PublicBeans.Make)','\(PublicBeans.Model)','\(PublicBeans.Year)')")
        sql.closeDB()
         JzActivity.getControlInstance.goBack()
    }
    func hidden(){
        make.close()
        model.close()
        year.close()
    }
    func getMmy(){
        PublicBeans.資料庫.query("select `Make`,`Model`,`Year` from `Summary table` limit 0,1", {a in
             PublicBeans.Make=a.getString(0)
             PublicBeans.Model=a.getString(1)
             PublicBeans.Year=a.getString(2)
            resetUi()
        }, {})
    }
    func resetUi(){
        b1.setTitle(PublicBeans.Make, for: .normal)
        b2.setTitle(PublicBeans.Model, for: .normal)
        b3.setTitle(PublicBeans.Year, for: .normal)
    }
}
