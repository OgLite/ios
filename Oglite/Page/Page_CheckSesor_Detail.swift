//
//  Page_CheckSesor_Detail.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/24.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsAdapter
import JzOsFrameWork
class Page_CheckSesor_Detail: UIViewController {
    @IBOutlet var tb: UITableView!
    var content=[sensorinfo(),sensorinfo(),sensorinfo(),sensorinfo(),sensorinfo()]
    @IBOutlet var readBt: UIButton!
    @IBOutlet var menubt: UIButton!
    @IBOutlet var thiny: UILabel!
    @IBOutlet var tit: UILabel!
    var focus = 1
    lazy var adapter=LinearAdapter(tb: tb, count: {return PublicBeans.getWheelCount()+1}, nib: ["Cell_Sensor_Detail","Cell_CheckSensor_Top","Cell_Sensor_Info"], getcell: {
        a,b,c in
        if(c==0){
            var cell=a.dequeueReusableCell(withIdentifier: "Cell_CheckSensor_Top") as! Cell_CheckSensor_Top
            return cell
        }
        var cell=a.dequeueReusableCell(withIdentifier: "Cell_Sensor_Info") as! Cell_Sensor_Info
        cell.bat.text=self.content[c-1].bat
        cell.c.text=self.content[c-1].c
        cell.id.text=self.content[c-1].id
        cell.position.text=["jz.312".getFix(),"jz.309".getFix().replace(":", ""),"jz.310".getFix().replace(":", ""),"jz.311".getFix(),"SP"][c-1]
        if(self.focus == c){
            cell.stack.backgroundColor = UIColor(named:"boldgreen")
        }else{
            cell.stack.backgroundColor = UIColor.white
        }
        cell.psi.text=self.content[c-1].psi
        return cell
    }, {a in
        self.focus=a
        self.notify()
    })
    
    func notify(){
        adapter.notifyDataSetChange()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)/\(PublicBeans.Year)"
    }
    override func viewWillAppear(_ animated: Bool) {
        adapter.notifyDataSetChange()
        tb.separatorStyle = .none
        thiny.text="jz.235".getFix()
        menubt.setTitle("jz.9".getFix(), for: .normal)
        readBt.setTitle("jz.231".getFix(), for: .normal)
    }
    
    
    @IBAction func readsensor(_ sender: Any) {
        if(self.focus == -1){
            return
        }
        Command.readSensor({
            a in
            for i in 0..<PublicBeans.getWheelCount(){
                if(self.content[i].id==a[0]){
                    self.content[i].id=""
                    self.content[i].psi=""
                    self.content[i].c=""
                    self.content[i].bat=""
                    self.content[i].volt=""
                }
            }
            self.content[self.focus-1].id=a[0]
            self.content[self.focus-1].psi=a[1]
            self.content[self.focus-1].c=a[2]
            self.content[self.focus-1].bat=a[3]
            self.content[self.focus-1].volt=a[4]
            for i in 0..<PublicBeans.getWheelCount(){
                if(self.content[i].id.isEmpty){
                    self.focus=i+1
                    self.adapter.notifyDataSetChange()
                    return
                }
            }
            self.focus = -1
            self.adapter.notifyDataSetChange()
        })
    }
    
    @IBAction func menu(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
    
}
class sensorinfo{
    var id=""
    var psi=""
    var c=""
    var bat=""
    var volt=""
}
