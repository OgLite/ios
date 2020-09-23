//
//  Select_Ble.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/11.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
import JzOsAdapter
class Select_Ble: UIViewController {
    @IBOutlet var tb: UITableView!
    
    @IBOutlet var cancelbt: UIButton!
    @IBOutlet var tit: UILabel!
    var act=JzActivity.getControlInstance.getActivity() as! ViewController
    lazy var adapter=LinearAdapter(tb: tb, count: {
        return self.act.bles.count
    }, nib: ["Cell_BleScan"], getcell: {
        a,b,c in
        let cell=a.dequeueReusableCell(withIdentifier: "Cell_BleScan") as! Cell_BleScan
        if(self.act.bles[c].name != nil){
             cell.blename.text=self.act.bles[c].name
        }else{
            cell.blename.text="unknown"
        }
       
        return cell
    }, {a in
        let progress=Progress()
        progress.label=progress.連線BLE
        JzActivity.getControlInstance.openDiaLog(progress,false, "progress")
        self.act.helper.connect(self.act.bles[a], 10)
    })
    override func viewDidLoad() {
        super.viewDidLoad()
        tb.separatorStyle = .none
        act.scanback={
            self.adapter.notifyDataSetChange()
        }
        tit.text="jz.198".getFix()
        cancelbt.setTitle("jz.114".getFix(), for: .normal)
    }

    @IBAction func cancel(_ sender: Any) {
        act.scanback=nil
        act.helper.stopScan()
    JzActivity.getControlInstance.closeDialLog("Select_Ble")
    }
    
  
}
