//
//  Page_Program_Detail.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/24.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsAdapter
import JzOsFrameWork
import JzOsTool
class Page_Program_Detail: UIViewController {
    var programFinish=false
    @IBOutlet var relearnPro: UIButton!
    @IBOutlet var hintlabel: UILabel!
    @IBOutlet var programbt: UIButton!
    @IBOutlet var menubt: UIButton!
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
                self.programbt.setTitle("jz.28".getFix(), for: .normal)
            }else{
                self.programbt.setTitle("jz.231".getFix(), for: .normal)
            }
        }
        return cell
    }, {
        a in
        if(a==0){return}
        print("scan\(PublicBeans.selectway==PublicBeans.Scan)")
        if(PublicBeans.selectway==PublicBeans.Scan){
            PublicBeans.getId({
                id in
                self.model[a-1].id=id
            })
        }
    })
    override func viewDidAppear(_ animated: Bool) {
        adapter.notifyDataSetChange()
        if(programFinish){
            let act=(JzActivity.getControlInstance.getActivity() as! ViewController)
//            act.backbt.setImage(UIImage(named: "btn_Menu"), for: .normal)
            act.goMenu=true
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)/\(PublicBeans.Year)"
        let a=Dia_Select_Way()
        a.dismissback={
            self.adapter.notifyDataSetChange()
        }
        JzActivity.getControlInstance.openDiaLog(a, false, "Dia_Select_Way")
        tb.separatorStyle = .none
        hintlabel.text="jz.425".getFix()
    }
    var programSuccess = -1
    @IBAction func read(_ sender: Any) {
        if(programSuccess==0){
            JzActivity.getControlInstance.goBack()
            return
        }
        if(canNext()){
            Command.programSensor(model, {
                self.adapter.notifyDataSetChange()
                self.programbt.setTitle("jz.28".getFix(), for: .normal)
                self.programbt.setBackgroundImage(UIImage(named: "btn_letf"), for: .normal)
                self.relearnPro.isHidden=false
                self.relearnPro.setTitle("jz.135".getFix(), for: .normal)
                self.menubt.isHidden=true
                var tempHint="jz.130".getFix()
                self.hintlabel.textColor=UIColor.gray
                self.programSuccess=0
                for i in 0..<PublicBeans.燒錄數量{
                    if(self.model[i].result == .燒錄失敗){
                        self.programSuccess=1
                        tempHint="jz.132".getFix()
                        self.menubt.isHidden=false
                        self.relearnPro.isHidden=true
                        self.programbt.setBackgroundImage(UIImage(named: "btn_right"), for: .normal)
                        self.programbt.setTitle("jz.288".getFix(), for: .normal)
                        self.hintlabel.textColor=UIColor.orange
                    }
                }
                self.hintlabel.text=tempHint
                self.programFinish=true
                let act=(JzActivity.getControlInstance.getActivity() as! ViewController)
//                act.backbt.setImage(UIImage(named: "btn_Menu"), for: .normal)
                act.goMenu=true
            })
        }else{
            readSensor()
        }
    }
    @IBAction func gorelearm(_ sender: Any) {
       let rel=Page_Relearn()
        rel.gomenu=true
        JzActivity.getControlInstance.changePage(rel, "Page_Relearn", true)
    }
    @IBAction func goMenu(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
    
    func readSensor(){
        Command.getPrID(model, {
            self.adapter.notifyDataSetChange()
            self.canNext()
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
                self.programbt.setTitle("jz.231".getFix(), for: .normal)
                return false
            }
        }
        self.programbt.setTitle("jz.28".getFix(), for: .normal)
        return true
    }
    
    func insert(_ id:String){
        for i in model{
            if(i.id==id){
                JzActivity.getControlInstance.toast("jz.289".getFix())
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
