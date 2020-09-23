//
//  Page_Device_Information.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/5/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsAdapter
import JzOsFrameWork
import JzOsMultiLanugage
class Page_Device_Information: UIViewController {
    var clickCount=0
    @IBOutlet var tb: UITableView!
    var name=["jz.397".getFix(),"jz.414".getFix(),"jz.400".getFix(),"jz.399".getFix(),"jz.56".getFix()]
    var version=["OGlite",SharePre.ogversion,SharePre.mmyVersion,JzActivity.getControlInstance.getApkVersion(),SharePre.sn]
    lazy var adapter=LinearAdapter(tb: tb, count: {
        return self.name.size
    }, nib: ["Cell_Device_Infoemation"], getcell: {
        a,b,c in
        var cell=a.dequeueReusableCell(withIdentifier: "Cell_Device_Infoemation", for: b) as! Cell_Device_Infoemation
        cell.name.text=self.name[c]
        cell.version.text=self.version[c]
        return cell
    }, {position in})
    override func viewDidLoad() {
        super.viewDidLoad()
        tb.separatorStyle = .none
        adapter.notifyDataSetChange()
    }
    
    @IBAction func click(_ sender: Any) {
        clickCount+=1
        if(clickCount==10){
            clickCount=0
            SharePre.isBeta.toggle()
            DonloadFile().clearInit()
            JzActivity.getControlInstance.goMenu()
        }
    }
}
