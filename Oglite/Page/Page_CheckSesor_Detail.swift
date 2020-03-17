//
//  Page_CheckSesor_Detail.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/24.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzAdapter
import JzIos_Framework
class Page_CheckSesor_Detail: UIViewController {
    @IBOutlet var tb: UITableView!
    var content=["","","","",""]
    lazy var adapter=LinearAdapter(tb: tb, count: {return 5}, nib: ["Cell_Sensor_Detail"], getcell: {
        a,b,c in
        var cell=a.dequeueReusableCell(withIdentifier: "Cell_Sensor_Detail") as! Cell_Sensor_Detail
        cell.tit.text=["ID:","psi:","°C:","BAT:","Voltage:"][c]
        cell.con.text=self.content[c]
        return cell
    }, {a in})
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        adapter.notifyDataSetChange()
        tb.separatorStyle = .none
    }

    
    @IBAction func readsensor(_ sender: Any) {
        Command.readSensor({
            a in
            self.content=a
            self.adapter.notifyDataSetChange()
        })
    }
    
    @IBAction func menu(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
    
}
