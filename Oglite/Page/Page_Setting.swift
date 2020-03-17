//
//  Page_Setting.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/4.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzAdapter
import JzIos_Framework
class Page_Setting: UIViewController {
    let pagearea=JzActivity.getControlInstance.getNewController("Main", "Page_Area") as! Page_Area
      let policy=JzActivity.getControlInstance.getNewController("Main", "Page_Policy") as! Page_Policy
    let Favroite=Page_Setting_Favorite()
    @IBOutlet weak var tb: UITableView!
    lazy var adapter=LinearAdapter(tb: tb, count: {
        return 5
    }, nib: ["Cell_DataSelect"], getcell: {
        a,b,c in
        let cell=a.dequeueReusableCell(withIdentifier: "Cell_DataSelect") as! Cell_DataSelect
        cell.cont.heightAnchor.constraint(equalToConstant: 170).isActive=true
        cell.tit.text=["My Favorite\n- Add or remove vehicles","Area & Language","Update","Set UP Password","Privacy Policy"][c]
        cell.ima.image=UIImage(named: ["btn_icon_My Favourite_n","btn_Area & Language","btn_Updata","btn_Set password","btn_privacy policy"][c])
        cell.actionpage=[self.Favroite,self.pagearea,Page_Update(),Page_Reset_Password(),self.policy][c]
        return cell
    },{a in})
    override func viewDidLoad() {
        super.viewDidLoad()
        pagearea.Setting=true
        policy.Setting=true
        adapter.notifyDataSetChange()
        
    }
    
}
