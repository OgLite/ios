//
//  Page_Idcopy_obd.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
import JzAdapter
class Page_Idcopy_obd: UIViewController{
    @IBOutlet var tit: UILabel!
    @IBOutlet var tb: UITableView!
    @IBOutlet var programbt: UIButton!
    var needposition=true
    var model=[Md_Idcopy(),Md_Idcopy(),Md_Idcopy(),Md_Idcopy(),Md_Idcopy()]
    var idcount=PublicBeans.getidcount()
    lazy var adapter=LinearAdapter(tb: self.tb, count: {
        return self.model.count+2
    }, nib: ["Cell_TopVehicle","Cell_Vehicle_Detail"], getcell: {
        a,b,c in
        if(c==0){
            let cell=a.dequeueReusableCell(withIdentifier: "Cell_TopVehicle") as! Cell_TopVehicle
            cell.contentView.heightAnchor.constraint(equalToConstant: 143).isActive=true
            cell.model=self.model
            cell.needposition=self.needposition
            cell.updaueUI()
            return cell
        }else if(c==1){
            return Cell_Vehicle_Detail.loadtit(a)
        }else{
            let cell=Cell_Vehicle_Detail.obd(a, self.model, c,self.needposition)
            if(c==2){
                cell.t3.becomeFirstResponder()
                cell.t2.becomeFirstResponder()
            }
            cell.t3.textWillChange={
                a in
                if(a.count==0&&self.model[c-2].readable){
                    cell.v3.backgroundColor = UIColor(named: "boldgreen")
                    self.model[c-2].newid=a
                }else{
                    cell.v3.backgroundColor = .white
                    self.model[c-2].newid=a
                }
                if(self.canpr()){
                    self.programbt.setTitle("Program".Mt(), for: .normal)
                }else{
                    self.programbt.setTitle("讀取", for: .normal)
                }
            }
            cell.t2.textWillChange={
                a in
                if(a.count==0&&self.model[c-2].readable){
                    cell.v2.backgroundColor = UIColor(named: "boldgreen")
                    self.model[c-2].vid=a
                }else{
                    cell.v2.backgroundColor = .white
                    self.model[c-2].vid=a
                }
                if(self.canpr()){
                    self.programbt.setTitle("Program".Mt(), for: .normal)
                }else{
                    self.programbt.setTitle("讀取", for: .normal)
                }
            }
            return cell
        }
    }, {a in
        if(a<2 || !self.needposition){return}
        if(!self.model[a-2].newid.isEmpty){return}
        self.model[a-2].readable = !self.model[a-2].readable
        self.notifyDataSetChange()
    })
    func notifyDataSetChange(){
        self.adapter.notifyDataSetChange()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)/\(PublicBeans.Year)"
        adapter.notifyDataSetChange()
        tb.separatorStyle = .none
        model[0].setup(wh: "LF", vid: "", newid: "", condition: Md_Idcopy.尚未燒錄)
        model[1].setup(wh: "RF", vid: "", newid: "", condition: Md_Idcopy.尚未燒錄)
        model[2].setup(wh: "RR", vid: "", newid: "", condition: Md_Idcopy.尚未燒錄)
        model[3].setup(wh: "LR", vid: "", newid: "", condition: Md_Idcopy.尚未燒錄)
        model[4].setup(wh: "SP", vid: "", newid: "", condition: Md_Idcopy.尚未燒錄)
        print("id=\(PublicBeans.getWheelCount())")
        if(PublicBeans.getWheelCount() != 5 || PublicBeans.選擇按鈕 == Page_Home.tit[3]){
            model.remove(at: 4)
        }
        let a=Dia_Select_Way()
        if(PublicBeans.選擇按鈕==Page_Home.tit[3]){
            
        }else{
            a.dismissback={
                self.readVehicleId()
                self.notifyDataSetChange()
                return ()
            }
        }
        
        JzActivity.getControlInstance.openDiaLog(a, false, "Dia_Select_Way")
        programbt.setTitle("Next".Mt(), for: .normal)
        print("obdversion:\(PublicBeans.getObdVersion())")
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func readVehicleId(){
        Command.getid(model,{
            a in
            if(a){
                self.adapter.notifyDataSetChange()
            }else{
                JzActivity.getControlInstance.toast("車種選擇錯誤")
            }
        })
    }
    @IBAction func readsensor(_ sender: Any) {
        if(canNext()&&needposition){
            needposition=false
            programbt.setTitle("讀取", for: .normal)
            adapter.notifyDataSetChange()
            return
        }else if(!canNext()){
            JzActivity.getControlInstance.toast("Please Select tire position \n" +
                "(multiple choice)")
            return
        }
        if(canpr()){
            switch PublicBeans.選擇按鈕 {
            case Page_Home.tit[0]:
                Command.programVehicle(self.model, {self.adapter.notifyDataSetChange()})
                break
            case Page_Home.tit[1]:
                Command.programVehicle(self.model, {self.adapter.notifyDataSetChange()})
                break
            case Page_Home.tit[3]:
                Command.programVehicle(self.model, {self.adapter.notifyDataSetChange()})
                break
            default:
                break
            }
            
        }else{
            Command.readid({
                (result,id) in
                switch(result){
                case.讀取成功:
                    self.checkId(id)
                if(self.canpr()){self.programbt.setTitle("Program".Mt(), for: .normal)}
                    break
                case .讀取失敗:
                    if(self.canpr()){self.programbt.setTitle("Program".Mt(), for: .normal)}
                    break
                default:
                    break
                }
            },getposition())
        }
    }
    func canpr()->Bool{
        for i in model{
            if((i.newid==""&&i.readable)||(i.vid==""&&i.readable)){
                return false
            }
        }
        return true
    }
    func getposition()->Int{
        for i in 0..<model.count{
            if((model[i].readable&&model[i].vid.isEmpty)){
                return i
            }
        }
        for i in 0..<model.count{
            if(model[i].readable&&model[i].newid.isEmpty){
                return i
            }
        }
        
        return -1
    }
    func canNext()->Bool{
        for i in model{
            if(i.readable){
                return true
            }
        }
        return false
    }
    func checkId(_ id:String){
        var newid=[String]()
        var vid=[String]()
        for i in self.model{
            if(i.readable){
                vid.append(i.vid)
            }
        }
        for i in self.model{
            if(i.readable){newid.append(i.newid)}
        }
        for i in model{
            if(i.readable){
                if(i.vid.isEmpty){
                    if(vid.contains(id)){
                        JzActivity.getControlInstance.toast("id重複")
                    }else{
                        i.vid=id
                        adapter.notifyDataSetChange()
                        return
                    }
                }else if(i.newid.isEmpty){
                    if(newid.contains(id)){
                        JzActivity.getControlInstance.toast("id重複")
                    }else{
                        i.newid=id
                        adapter.notifyDataSetChange()
                        return
                    }
                }
            }
        }
        
        
    }
}
