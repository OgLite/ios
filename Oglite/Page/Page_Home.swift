//
//  Page_Home.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/31.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzAdapter
import JzOsSqlHelper
import JzIos_Framework
class Page_Home: UIViewController {
    @IBOutlet weak var tb: UITableView!
    var adapter:GridAdapter! = nil
    var imagep=["btn_ID Copy by OBD_P","btn_OBDII relearn_p","btn_Program_P","btn_ID copy_P","btn_check sensor_p","btn_Online shopping_p","btn_User's manual_p","btn_Setting_p"]
    var imagen=["btn_ID Copy by OBD_n","btn_OBDII relearn_n","btn_Program_n","btn_ID copy_n","btn_check sensor_n","btn_Online shopping_n","btn_User's manual_n","btn_Setting_n"]
    var pageswitch=[Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Vehicle_Select(),Page_Setting()]
    
    static let tit=["ID Copy by OBD","OBD Relearn","Program","ID Copy","Check Sensor","Online Shopping","Manual","Setting"]
    override func viewDidLoad() {
        super.viewDidLoad()
        DonloadFile.dataloading()
    }
    override func viewWillAppear(_ animated: Bool) {
        if(JzActivity.getControlInstance.getPro("update", "nodata") != "nodata"){
             JzActivity.getControlInstance.openDiaLog(Dia_Update(), false, "Dia_Update")
        }
       
        adapter=GridAdapter(tb: tb, width: UIScreen.main.bounds.width/2,height: 170, count: {return 8}, spilt: 2
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
