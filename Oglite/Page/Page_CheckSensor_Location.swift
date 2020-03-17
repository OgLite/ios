//
//  Page_CheckSensor_Location.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/3/9.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzAdapter
import JzIos_Framework
class Page_CheckSensor_Location: UIViewController {
    
    @IBOutlet var tb: UITableView!
    lazy var adapter=LinearAdapter(tb: tb, count: {
            return 2
        }, nib: ["Cell_DataSelect"], getcell: {
            a,b,c in
            let cell=a.dequeueReusableCell(withIdentifier: "Cell_DataSelect") as! Cell_DataSelect
            cell.cont.heightAnchor.constraint(equalToConstant: self.tb.frame.height/3).isActive=true
            cell.tit.text=["Read sensor","Check Sensor Installation Location"][c]
            cell.ima.image=UIImage(named: ["btn_check sensor_n","btn_check_n"][c])
        cell.actionpage=[Page_CheckSesor_Detail(),Page_CheckSesor_Detail()][c]
            return cell
        },{a in})
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        adapter.notifyDataSetChange()
         tb.separatorStyle = .none
    }

    @IBAction func gomenu(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
    
}
