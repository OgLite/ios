//
//  Page_Idcopy_obd.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
import JzOsAdapter
class Page_Idcopy_obd: UIViewController{
    @IBOutlet var tit: UILabel!
    @IBOutlet var tb: UITableView!
    @IBOutlet var programbt: UIButton!
    var clickPosition = -1
    var selectrow =  -1
    @IBOutlet var prbt: UIButton!
    @IBOutlet var mebt: UIButton!
    @IBOutlet var reselect: UIButton!
    @IBOutlet var relearm: UIButton!
    var needposition=true
    var model=[Md_Idcopy]()
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
            let cell=Cell_Vehicle_Detail.obd(a, self.model, c,self)
            cell.t3.textWillChange={
                a in
                print("textWillChange")
                if(a.count==0&&self.model[c-2].readable){
                    self.model[c-2].newid=a
                }else{
                    cell.v3.backgroundColor = .white
                    self.model[c-2].newid=a
                }
                if(self.canpr()){
                    self.programbt.setTitle("jz.28".getFix(), for: .normal)
                }else{
                    self.programbt.setTitle("jz.231".getFix(), for: .normal)
                }
            }
            cell.t2.textWillChange={
                a in
                print("textWillChange")
                if(a.count==0&&self.model[c-2].readable){
                    self.model[c-2].vid=a
                }else{
                    cell.v2.backgroundColor = .white
                    self.model[c-2].vid=a
                }
                if(self.canpr()){
                    self.programbt.setTitle("jz.28".getFix(), for: .normal)
                }else{
                    self.programbt.setTitle("jz.231".getFix(), for: .normal)
                }
            }
            return cell
        }
    }, {a in
        print("click\(a)")
    })
    
    
    func notifyDataSetChange(){
        self.adapter.notifyDataSetChange()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)/\(PublicBeans.Year)"
        adapter.notifyDataSetChange()
        tb.separatorStyle = .none
        if(PublicBeans.copyPosition[0]){
            let md=Md_Idcopy()
            md.readable=true
            md.setup(wh: "jz.312".getFix(), vid: "", newid: "", condition: Md_Idcopy.尚未燒錄)
            model.append(md)
        }
        if(PublicBeans.copyPosition[1]){
            let md=Md_Idcopy()
            md.readable=true
            md.setup(wh: "jz.309".getFix(), vid: "", newid: "", condition: Md_Idcopy.尚未燒錄)
            model.append(md)
        }
        if(PublicBeans.copyPosition[2]){
            let md=Md_Idcopy()
            md.readable=true
            md.setup(wh: "jz.310".getFix(), vid: "", newid: "", condition: Md_Idcopy.尚未燒錄)
            model.append(md)
        }
        if(PublicBeans.copyPosition[3]){
            let md=Md_Idcopy()
            md.readable=true
            md.setup(wh: "jz.311".getFix(), vid: "", newid: "", condition: Md_Idcopy.尚未燒錄)
            model.append(md)
        }
        if(PublicBeans.getWheelCount()==5&&PublicBeans.copyPosition[4]){
            let md=Md_Idcopy()
            md.readable=true
            md.setup(wh: "SP", vid: "", newid: "", condition: Md_Idcopy.尚未燒錄)
            model.append(md)
        }
        
        print("id=\(PublicBeans.getWheelCount())")
        let a=Dia_Select_Way()
        if(PublicBeans.選擇按鈕=="jz.117".getFix()||PublicBeans.選擇按鈕=="jz.15".getFix()){
            a.dismissback={
                self.notifyDataSetChange()
            }
        }else{
            a.dismissback={
                self.readVehicleId()
                self.notifyDataSetChange()
                return ()
            }
        }
        
        JzActivity.getControlInstance.openDiaLog(a, false, "Dia_Select_Way")
        programbt.setTitle("jz.404".getFix(), for: .normal)
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
                JzActivity.getControlInstance.toast("jz.407".getFix())
            }
        })
    }
    
    func allHidden(){
        mebt.isHidden=true
        prbt.isHidden=true
        reselect.isHidden=true
        relearm.isHidden=true
        for i in model{
            if(i.condition==Md_Idcopy.燒錄失敗){
                mebt.isHidden=false
                prbt.isHidden=false
                prbt.setTitle("jz.288".getFix(), for: .normal)
                return
            }
        }
        reselect.isHidden=false
        relearm.isHidden=false
    }
    
    @IBAction func readsensor(_ sender: Any) {
        if(canpr() && clickPosition == -1){
            switch PublicBeans.選擇按鈕 {
            case "jz.401".getFix():
                Command.writeId(self.model, {self.adapter.notifyDataSetChange()
                    self.allHidden()
                })
                break
            case "jz.15".getFix():
                Command.getid(model,{
                    a in
                    if(a){
                        Command.programVehicle(self.model, {self.adapter.notifyDataSetChange()})
                    }else{
                    JzActivity.getControlInstance.toast("jz.407".getFix())
                        JzActivity.getControlInstance.goMenu()
                    }
                    self.allHidden()
                })
                
                break
            case "jz.117".getFix():
                Command.writeId(self.model, {self.adapter.notifyDataSetChange()
                    self.allHidden()
                })
                break
            default:
                break
            }
        }else{
            if(isOriginal()||PublicBeans.選擇按鈕=="jz.15".getFix()){
                Command.readid({
                    (result,id) in
                    switch(result){
                    case.讀取成功:
                        self.checkId(id)
                        if(self.canpr()){self.programbt.setTitle("jz.28".getFix(), for: .normal)}
                        break
                    case .讀取失敗:
                        if(self.canpr()){self.programbt.setTitle("jz.28".getFix(), for: .normal)}
                        break
                    default:
                        break
                    }
                },getposition())
            }else{
                Command.getPrID({
                    a in
                    self.checkId(a)
                    if(self.canpr()){self.programbt.setTitle("jz.28".getFix(), for: .normal)}
                })
            }
        }
    }
    func canpr()->Bool{
        if(PublicBeans.選擇按鈕 == "jz.15".getFix()){
            for i in model{
                if((i.newid==""&&i.readable)){
                    return false
                }
            }
            return true
        }
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
    func isOriginal()->Bool{
        if(clickPosition != -1){
            if(clickPosition%2 == 0){
                return true
            }else{
                return false
            }
        }
        for i in model{
            if(i.vid.isEmpty){
                return true
            }
            if(i.newid.isEmpty){
                return false
            }
        }
        return false
    }
    
    func removeNew(_ id:String){
    for i in model{
        if(i.newid==id){
                   i.newid=""
               }
           }
    }
    
    func removeOld(_ id:String){
        for i in model{
            if(i.vid==id){
                i.vid=""
            }
        }
      }
    
    func checkId(_ id:String){
        if(clickPosition != -1){
            if(clickPosition % 2 == 0){
                removeOld(id)
                model[clickPosition/2].vid=id
                clickPosition = -1
            }else{
                removeNew(id)
                model[clickPosition/2].newid=id
                clickPosition = -1
            }
              adapter.notifyDataSetChange()
            return
        }
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
                        JzActivity.getControlInstance.toast("jz.289".getFix())
                    }else{
                        i.vid=id
                        adapter.notifyDataSetChange()
                        return
                    }
                }else if(i.newid.isEmpty){
                    if(newid.contains(id)){
                        JzActivity.getControlInstance.toast("jz.289".getFix())
                    }else{
                        i.newid=id
                        adapter.notifyDataSetChange()
                        return
                    }
                }
            }
        }
    }
    @IBAction func goBack(_ sender: Any) {
        JzActivity.getControlInstance.goBack()
    }
    
    @IBAction func gorelearm(_ sender: Any) {
        let rel=Page_Relearn()
        rel.gomenu=true
        JzActivity.getControlInstance.changePage(rel, "Page_Relearn", true)
    }
    @IBAction func gomenu(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
}
