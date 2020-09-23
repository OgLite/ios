//
//  Page_Home.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/31.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsAdapter
import JzOsSqlHelper
import JzOsFrameWork
class Page_Home: UIViewController {
    @IBOutlet weak var tb: UITableView!
    var adapter:GridAdapter! = nil
    var imagep=["btn_check sensor_p","btn_Program_P","btn_ID copy_P","btn_OBDII relearn_p","btn_ID Copy by OBD_P","btn_Online shopping_p","btn_RelearnProcedure_P","btn_Setting_p"]
//    "btn_User's manual_p"
    var imagen=["btn_check sensor_n","btn_Program_n","btn_ID copy_n","btn_OBDII relearn_n","btn_ID Copy by OBD_n","btn_Online shopping_n","btn_RelearnProcedure_P","btn_Setting_n"]
//    "btn_User's manual_n"
    var pageswitch=[Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Vehicle_Select(),Page_WebView(),Page_Vehicle_Select(),Page_Setting()]
//    Page_Setting()
    static var tit=["jz.10".getFix(),"jz.28".getFix(),"jz.117".getFix(),"jz.15".getFix(),"jz.401".getFix(),"jz.17".getFix(),"jz.135".getFix(),"jz.36".getFix()]
//    "app_user_manual".getFix()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        Page_Home.tit=["jz.10".getFix(),"jz.28".getFix(),"jz.117".getFix(),"jz.15".getFix(),"jz.401".getFix(),"jz.17".getFix(),"jz.135".getFix(),"jz.36".getFix()]
        pageswitch=[Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Vehicle_Select(),Page_WebView(),Page_Vehicle_Select(),Page_Setting()]
        adapter=GridAdapter(tb: tb, width: UIScreen.main.bounds.width/2,height: 190, count: {return Page_Home.tit.count}, spilt: 2
            , nib: "HomeItem", getcell: {
                a,b,c in
                print(c)
                let cell=a.dequeueReusableCell(withReuseIdentifier: "HomeItem", for: b) as! HomeItem
                cell.ima.setImage(UIImage(named: self.imagen[c]), for: .normal)
                cell.ima.setImage(UIImage(named: self.imagep[c]), for: .highlighted)
                cell.tit.text=Page_Home.tit[c]
                cell.pageswitch=self.pageswitch
                cell.index=c
                return cell
        })
        tb.bounces=false
        tb.separatorStyle = .none
        self.adapter.notifyDataSetChange()
    }
    
    
    
}
