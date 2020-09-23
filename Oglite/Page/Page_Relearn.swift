//
//  Page_Relearn.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsSqlHelper
import JzOsFrameWork
class Page_Relearn: UIViewController {
    var gomenu=false
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var tit: UILabel!
    
    @IBOutlet var gomenub: UIButton!
    @IBOutlet var btnext: UIButton!
    override func viewDidLoad() {
        tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)/\(PublicBeans.Year)"
        content.text=ItemDao.getRelearm()
        addFavorite()
    }
    override func viewDidAppear(_ animated: Bool) {
        if(gomenu){
            gomenub.setTitle("jz.9".getFix(), for: .normal)
            btnext.isHidden=true
            gomenub.setBackgroundImage(UIImage(named: "btn_rectangle"), for: .normal)
        }else{
            
        }
        if(PublicBeans.選擇按鈕 == "jz.135".getFix()){
            btnext.isHidden=true
            gomenub.setBackgroundImage(nil, for: .normal)
            gomenub.setBackgroundImage(UIImage(named: "btn_rectangle"), for: .normal)
        }
    }
    
    @IBAction func readid(_ sender: Any) {
        if(gomenu){
            JzActivity.getControlInstance.goMenu()
            return
        }
        PublicBeans.changeFunction()
    }
    @IBAction func menu(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
    
    func addFavorite(){
        let sql=SqlHelper("favorite")
        sql.autoCreat()
        sql.exSql("delete from favorite where make='\(PublicBeans.Make)' and model='\(PublicBeans.Model)' and year='\(PublicBeans.Year)'")
        sql.exSql("insert into `favorite` (make,model,year) values ('\(PublicBeans.Make)','\(PublicBeans.Model)','\(PublicBeans.Year)')")
        sql.closeDB()
    }
}
