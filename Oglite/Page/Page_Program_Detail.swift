//
//  Page_Program_Detail.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/24.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzAdapter
import JzIos_Framework
import JzOsTool
class Page_Program_Detail: UIViewController {
    
    @IBOutlet var programbt: UIButton!
    @IBOutlet var tb: UITableView!
    @IBOutlet var tit: UILabel!
    var model=[Md_Program(),Md_Program(),Md_Program(),Md_Program()]
    lazy var adapter=LinearAdapter(tb: tb, count: {
        return PublicBeans.燒錄數量+1
    }, nib: ["Cell_Program_Detail"], getcell: {
        a,b,c in
        
        let cell=Cell_Program_Detail.getcell(a,c,self.model )
        cell.idnumber.textWillChange={
                        a in
            self.model[c-1].id=a
            if(self.canNext()){
                    self.programbt.setTitle("Program".Mt(), for: .normal)
            }else{
            self.programbt.setTitle("Read", for: .normal)
            }
                       }
        return cell
    }, {
        a in
        
    })
    override func viewDidAppear(_ animated: Bool) {
        adapter.notifyDataSetChange()
        var a=JzOSTool.timer()
        a.zeroing()  }
    override func viewDidLoad() {
        super.viewDidLoad()
tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)/\(PublicBeans.Year)"
        let a=Dia_Select_Way()
        a.dismissback={
            self.adapter.notifyDataSetChange()
        }
        JzActivity.getControlInstance.openDiaLog(a, false, "Dia_Select_Way")
        tb.separatorStyle = .none
    }
    @IBAction func read(_ sender: Any) {
        if(canNext()){
            Command.programSensor(model, {
                adapter.notifyDataSetChange()
            })
        }else{
            readSensor()
        }
    }
    func readSensor(){
        Command.readid({
            a,b in
            switch(a){
            case .讀取成功:
                self.insert(b)
                if(self.canNext()){
         self.programbt.setTitle("Program".Mt(), for: .normal)
                }
                break
            case .讀取失敗:
                JzActivity.getControlInstance.toast("讀取失敗")
                break
            default:
                break
            }
        })
    }
    func getPosition()->Int{
        for i in 0..<PublicBeans.燒錄數量{
            if(model[i].id.isEmpty){
                return i
            }
        }
        return -1
    }
    func canNext()->Bool{
        for i in 0..<PublicBeans.燒錄數量{
            if(model[i].id.isEmpty){
                return false
            }
        }
        return true
    }
    
    func insert(_ id:String){
        for i in model{
            if(i.id==id){
              JzActivity.getControlInstance.toast("id重複")
                return
            }
            if(i.id.isEmpty){
                i.id=id
                adapter.notifyDataSetChange()
                return
            }
        }
    }
    
}
