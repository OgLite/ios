//
//  Command.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import JzIos_Framework
import JzOsTool
public class Command{
    static var rx=""
    static var demo=false
    public static func sendData(_ data:String){
        rx=""
        let act=JzActivity.getControlInstance.getActivity() as! ViewController
        let spi=350
        var Tda=""
        if(data.count>spi){
            var long=0
            if(data.count%spi==0){long=data.count/spi}else{
                long=data.count/spi+1
            }
            let a=JzOSTool.timer()
            for i in 0..<long{
                a.zeroing()
                while(a.stop()<0.1){
                    
                }
                if(i==long-1){
                    Tda="87"+data.sub(i*spi..<data.count)+"78"
                }else{
                    if(i==0){
                        var slon=String(format:"%2X",long).replace(" ", "")
                        if(slon.count<2){slon="0"+slon}
                        Tda="87\(slon)"+data.sub(i*spi..<i*spi+spi)
                    }else{
                        Tda="87"+data.sub(i*spi..<i*spi+spi)
                    }
                }
                act.helper.sendData(Tda.HexToByte()!, "8D82", "8D81")
            }
        }else{
            act.helper.sendData(data.HexToByte()!, "8D82", "8D81")
        }
    }
    
    
    public static func getid(_ model:[Md_Idcopy],_ callback:@escaping (_ result:Bool)->Void){
        if(demo){
            DispatchQueue.global().async {
                let data=["aaaaaaaa","bbbbbbbb","cccccccc","dddddddd","eeeeeeee"]
                var a=0
                for i in model{
                    i.vid=data[a]
                    i.newid=""
                    i.condition=Md_Idcopy.尚未燒錄
                    a+=1
                }
                DispatchQueue.main.async {
                    callback(true)
                }
            }
        }else{
            let progress=Progress()
            progress.label="Programming".Mt()
            JzActivity.getControlInstance.openDiaLog(progress, false, "Progress")
            DispatchQueue.global().async {
                if(ObdCommand.laodingBootloader()){
                    var a=ObdCommand.GetId(model)
                    DispatchQueue.main.async {
                        JzActivity.getControlInstance.closeDialLog()
                        callback(a)
                    }
                }else{
                    DispatchQueue.main.async {
                        JzActivity.getControlInstance.closeDialLog()
                        callback(false)
                    }
                }
            }
        }
    }
    public enum readidResult {
        case 重複ID
        case 讀取成功
        case 讀取失敗
        case ID已滿
        case 讀取完畢
    }
    public static func readid(_ callback:@escaping (_ case:readidResult,_ id:String)->Void,_ direct:Int = -1){
        
        if(PublicBeans.selectway == PublicBeans.Trigger){JzActivity.getControlInstance.openDiaLog(Progress(), true, "Progress")}
        DispatchQueue.global().async {
            var id=""
            var readresult=true
            switch(PublicBeans.selectway){
            case PublicBeans.Scan:
                DispatchQueue.main.async {
                    let scanner=Page_Scanner()
                    scanner.scanback = {
                        code in
                        var spilt=code.components(separatedBy: "*")
                        if(spilt.count<3){spilt=code.components(separatedBy: ":")}
                        if(spilt.count>=3){
                            if(spilt[1].count != 8){
                                readresult=false
                                JzActivity.getControlInstance.toast("ID_code_should_be_8_characters".Mt())
                            }else{
                                readresult=true
                                id=spilt[1]
                            }
                        }else{
                            readresult=false
                            JzActivity.getControlInstance.toast("Please_scan_the_QR_Code_on_the_catalog_or_poster".Mt())
                            
                        }
                        chackIdresult( id, readresult, callback,direct)
                        return {}()
                    }
                    JzActivity.getControlInstance.changePage(scanner, "scanner", true)
                }
                
                break
            case PublicBeans.Trigger:
                id=["11111111","22222222","33333333","44444444","55555555"].randomElement()!
                readresult=[true,false].randomElement()!
                chackIdresult(id, readresult, callback,direct)
                break
            case PublicBeans.KetIn:
                
                break
            default:
                break
            }
            
        }
    }
    public static func programVehicle(_ model:[Md_Idcopy],_ callback:@escaping()->Void){
        if(demo){
            for i in model{
                      if(i.readable||i.newid.count>0){i.condition=[Md_Idcopy.燒錄失敗,Md_Idcopy.燒錄成功].randomElement()!}
                  }
                  callback()
        }else{
            let progress=Progress()
                  progress.label="Programming".Mt()
                  JzActivity.getControlInstance.openDiaLog(progress, false, "Progress")
                  DispatchQueue.global().async {
                      let a = ObdCommand.SetireId(model)
                    DispatchQueue.main.async {
                        JzActivity.getControlInstance.closeDialLog()
                        callback()
                    }
                  }
        }
      
      
    }
    public static func programSensor(_ model:[Md_Program],_ callback:()->Void){
        for i in 0..<PublicBeans.燒錄數量{
            model[i].result=[Md_Program.switchcase.燒錄成功,Md_Program.switchcase.燒錄失敗].randomElement()!
        }
        callback()
    }
    public static func chackIdresult(_ id:String,_ readresult:Bool,_ callback:@escaping (_ case:readidResult,_ id:String)->Void,_ direct:Int){
        DispatchQueue.main.async {
            
            JzActivity.getControlInstance.closeDialLog()
            if(readresult){
                callback(.讀取成功,id)
                
            }else{
                JzActivity.getControlInstance.toast("讀取失敗")
                callback(.讀取失敗,id)
            }
            
        }
    }
    public static func readSensor(_ callback:@escaping (_ content:[String])->Void ){
        let progress=Progress()
                   progress.label="Programming".Mt()
                   JzActivity.getControlInstance.openDiaLog(progress, false, "Progress")
        DispatchQueue.global().async {
            sleep(3)
            DispatchQueue.main.async {
                JzActivity.getControlInstance.closeDialLog()
                let a=["C03547D8","50psi","10°C","100%","10V"]
                callback(a)
            }
        }
    }
    
}
