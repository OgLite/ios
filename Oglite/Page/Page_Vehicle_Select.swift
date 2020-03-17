//
//  Page_Idcopy_Obd.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
import JzAdapter
import JzOsSqlHelper
class Page_Vehicle_Select: UIViewController {
    
    @IBOutlet weak var tb: UITableView!
    let scanner=Page_Scanner()
    let selectmake=Page_Select_Make()
    let favorite=Page_Favroite()
    lazy var adapter=LinearAdapter(tb: tb, count: {
        return 3
    }, nib: ["Cell_DataSelect"], getcell: {
        a,b,c in
        let cell=a.dequeueReusableCell(withIdentifier: "Cell_DataSelect") as! Cell_DataSelect
        cell.cont.heightAnchor.constraint(equalToConstant: self.tb.frame.height/3).isActive=true
        cell.tit.text=["Scan Code","Vehicle Selection","My Favorite"][c]
        self.scanner.scanback={
            code in
            var havedata=false
            if(code.components(separatedBy: "*").count>1){
                print("init*\(code.components(separatedBy: "*")[0])")
                PublicBeans.資料庫.query("select `Make`,`Model`,`Year`  from `Summary table` where `Direct Fit` not in('NA')  and `MMY number`='\(code.components(separatedBy: "*")[0])' limit 0,1", {
                    data in
                    havedata=true
                    PublicBeans.Make=data.getString(0)
                    PublicBeans.Model=data.getString(1)
                    PublicBeans.Year=data.getString(2)
                print("init\(code.components(separatedBy: "*")[0])")
JzActivity.getControlInstance.changePage(Page_Relearn(), "Page_Relearn", true)
                }, {
                    print("resultsuccess")
                })
            }
            if(!havedata){
            JzActivity.getControlInstance.openDiaLog(ErrorCode(),false,"ErrorCode")
            }
            return {}()
        }
        cell.actionpage=[self.scanner,self.selectmake,self.favorite][c]
        cell.ima.image=UIImage(named: ["btn_scan_n","btn_icon_My Favourite_n","btn_favourite_n"][c])
        return cell
    },{a in})
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.notifyDataSetChange()
        tb.bounces=false
    }
    
    
    @IBAction func back(_ sender: Any) {
        JzActivity.getControlInstance.goBack()
    }
    
}
