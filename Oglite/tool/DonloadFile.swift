//
//  DonloadFile.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//
import JzIos_Framework
import JzOsSqlHelper
import Foundation
import JzOsTool
public class DonloadFile{
    public static func dataloading(){
        let a=Progress()
        a.label=a.資料載入
        JzActivity.getControlInstance.openDiaLog(a,true,"Progress")
        let sql=SqlHelper("mmy.db")
        if(JzActivity.getControlInstance.getPro("dataloading", "false") != "false"){
            sql.autoCreat()
            PublicBeans.資料庫=sql
            JzActivity.getControlInstance.closeDialLog()
            return
        }
        DispatchQueue.global().async {
            if(!downAllobd()){dataloading()}
            if(!downAllS19()){dataloading()}
            let mmy=mmyname()
            if(mmy==nil){
                DispatchQueue.main.async {dataloading()  }
            }else{
                sql.initByUrl(mmy!,{
                    result in
                    if(result){
                        PublicBeans.資料庫=sql
                        JzActivity.getControlInstance.setPro("mmy", mmy!)
                        JzActivity.getControlInstance.setPro("dataloading", "true")
                        DispatchQueue.main.async {JzActivity.getControlInstance.closeDialLog()
                        }
                    }else{
                        DispatchQueue.main.async {dataloading()  }
                    }
                })
            }
        }
    }
    public static func mmyname()->String?{
        var Area=PublicBeans.地區
        if(Area=="North America"){
            Area="US"
        }else{
            Area="EU"
        }
        let url = URL(string: "https://bento2.orange-electronic.com/Orange%20Cloud/Database/MMY/\(Area)/")
        var data: Data? = nil
        if let anUrl = url {
            do{
                try data = Data(contentsOf: anUrl)
                let ds=String(decoding: data!, as: UTF8.self).components(separatedBy: "HREF=")
                let filename=ds[2].components(separatedBy: ">")[1].components(separatedBy: "<")[0]
                print(filename)
                return "https://bento2.orange-electronic.com/Orange%20Cloud/Database/MMY/\(Area)/\(filename)"
                
            }catch{print(error)
                return nil
            }
        }
        return nil
    }
    public static func progress(_ pro:Int){
        DispatchQueue.main.async {
            JzActivity.getControlInstance.closeDialLog()
            let a=Progress()
            a.label="\(a.資料載入)...\(pro)%"
            JzActivity.getControlInstance.openDiaLog(a,true,"Progress")
        }
    }
    public static func downAllS19()->Bool{
        PublicBeans.OBD資料庫.exSql("CREATE TABLE if not exists `s19` ( name VARCHAR, data TEXT);")
        let a = JzOSTool.http().listHttpFile("https://bento2.orange-electronic.com", "/Orange%20Cloud/Database/SensorCode/SIII/")
        if a != nil{
            for i in 0..<a!.count{
                if(!self.downs19(a![i])){return false}
                 progress(i*100/a!.count/2+50)
            }
        }else{
            print("失敗")
            return false
        }
        return true
    }
    public static func downs19(_ name:String)->Bool{ let a=JzOSTool.http().listHttpFile("https://bento2.orange-electronic.com", "/Orange%20Cloud/Database/SensorCode/SIII/\(name)/")
        if let dir=a{
            if(dir.count>0){
                if(JzActivity.getControlInstance.getPro(name, "nodata")==dir[0]){return true}
                let file=JzOSTool.http().getFileText("https://bento2.orange-electronic.com/Orange%20Cloud/Database/SensorCode/SIII/\(name)/\(dir[0])")
                if file != nil{
                    PublicBeans.OBD資料庫.exSql("delete from `s19` where name='\(name)'")
                    PublicBeans.OBD資料庫.exSql("insert into `s19` (name,data) values ('\(name)','\(file!.replace("\r\n", ""))')")
                    JzActivity.getControlInstance.setPro(name,dir[0])
                    return true
                }else{
                    print("失敗")
                }
            }
        }
        return false
    }
    public static func downAllobd()->Bool{
        PublicBeans.OBD資料庫.exSql("CREATE TABLE if not exists `obd` ( name VARCHAR, data TEXT);")
        let a=JzOSTool.http().listHttpFile("https://bento2.orange-electronic.com", "/Orange%20Cloud/Drive/OBD%20DONGLE/")
        if a != nil{
            for i in 0..<a!.count{
                if(!self.downobd(a![i])){return false}
                  progress(i*100/a!.count/2)
            }
        }else{
            print("失敗")
            return false
        }
        return true
    }
    public static func downobd(_ name:String)->Bool{
        let a=JzOSTool.http().listHttpFile("https://bento2.orange-electronic.com","/Orange%20Cloud/Drive/OBD%20DONGLE/\(name)/")
        if let dir=a{
            if(dir.count>0){
                if(JzActivity.getControlInstance.getPro(name, "nodata")==dir[0]){return true}
                let file=JzOSTool.http().getFileText("https://bento2.orange-electronic.com/Orange%20Cloud/Drive/OBD%20DONGLE/\(name)/\(dir[0])")
                if file != nil{
                    PublicBeans.OBD資料庫.exSql("delete from `obd` where name='\(name)'")
                    PublicBeans.OBD資料庫.exSql("insert into `obd` (name,data) values ('\(name)','\(file!.replace("\r\n", ""))')")
                    JzActivity.getControlInstance.setPro(name,dir[0])
                    return true
                }else{
                    print("失敗")
                }
                
            }
        }
        return false
    }
    public static func checkUpdate(caller:@escaping(_ a:Bool)->Void){
        let a=Progress()
        a.label="Check Updates"
        JzActivity.getControlInstance.openDiaLog(a,true,"Progress")
          let sql=SqlHelper("mmy.db")
       DispatchQueue.global().async {
                   if(!downAllobd()){
                    DispatchQueue.main.async {
                        caller(false)
                    }
                    }
                   if(!downAllS19()){
                    DispatchQueue.main.async {
                        caller(false)
                    }
        }
                   let mmy=mmyname()
                   if(mmy==nil){
                       DispatchQueue.main.async {caller(false)  }
                   }else{
                    if(mmy==JzActivity.getControlInstance.getPro("mmy", "nodata")){
                        DispatchQueue.main.async {
                           caller(true)
                        }
                        return}
                       sql.initByUrl(mmy!,{
                           result in
                           if(result){
                               PublicBeans.資料庫=sql
                               JzActivity.getControlInstance.setPro("mmy", mmy!)
                               DispatchQueue.main.async {
                                caller(true)
                               }
                           }else{
                               DispatchQueue.main.async {caller(false)  }
                           }
                       })
                   }
               }
    }
}
