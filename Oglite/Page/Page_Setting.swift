//
//  Page_Setting.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/4.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsAdapter
import JzOsFrameWork
class Page_Setting: UIViewController {
    let pagearea=JzActivity.getControlInstance.getNewController("Main", "Page_Area") as! Page_Area
      let policy=JzActivity.getControlInstance.getNewController("Main", "Page_Policy") as! Page_Policy
    let Favroite=Page_Setting_Favorite()
    @IBOutlet weak var tb: UITableView!
    lazy var adapter=LinearAdapter(tb: tb, count: {
        return 10
    }, nib: ["Cell_DataSelect"], getcell: {
        a,b,c in
        let cell=a.dequeueReusableCell(withIdentifier: "Cell_DataSelect") as! Cell_DataSelect
        cell.cont.heightAnchor.constraint(equalToConstant: 100).isActive=true
        cell.tit.text=["jz.34".getFix()+"\n\("jz.430".getFix())","jz.53".getFix(),"jz.152".getFix(),"jz.194".getFix(),"jz.80".getFix(),"jz.63".getFix(),"jz.391".getFix(),"jz.385".getFix(),"jz.242".getFix(),"jz.111".getFix()][c]
        cell.ima.image=UIImage(named: ["btn_icon_My Favourite_n","btn_device_information","btn_Area & Language","btn_Updata","btn_Set password","btn_privacy policy","btn_unit","btn_auto_off","btn_reset","btn_Log out"][c])
        cell.actionpage=[self.Favroite,Page_Device_Information(),self.pagearea,Page_Update(),Page_Reset_Password(),self.policy,Page_Unit(),Page_Auto_Off(),Dia_Reset(),Dia_Logout()][c]
        return cell
    },{a in})
    override func viewDidLoad() {
        super.viewDidLoad()
        pagearea.Setting=true
        policy.Setting=true
    }
    override func viewDidAppear(_ animated: Bool) {
        adapter.notifyDataSetChange()
    }
    
    
}
