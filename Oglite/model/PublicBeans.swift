//
//  PublicBeans.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import JzOsFrameWork
import JzOsSqlHelper
public class PublicBeans{
    public static var 地區=""
    public static var 語言=""
    public static var Make=""
    public static var Model=""
    public static var Year=""
    public static var 資料庫版本=""
    public static var 燒錄數量=4
    public static var 選擇按鈕=""
    public static var 資料庫:SqlHelper! = SqlHelper("mmy.db")
    public static var OBD資料庫:SqlHelper! = SqlHelper("obd.db")
    public static var txMemory:SqlHelper! = SqlHelper("txmemory.db")
    public static var Scan=0
    public static var KetIn=1
    public static var Trigger=2
    public static var selectway=0
    public static var BootloaderState=0
    public static var copyPosition=[Bool]()
    public static func refrsh(){
        PublicBeans.地區=JzActivity.getControlInstance.getPro("Area","EU")
        PublicBeans.語言=JzActivity.getControlInstance.getPro("lan","English")
        PublicBeans.資料庫版本=JzActivity.getControlInstance.getPro("mmy","nodata")
    }
    public static func gets19()->String{
        var s19=""
        PublicBeans.資料庫.query("select `Direct Fit` from `Summary table` where Make='\(Make)' and Model='\(Model)' and year='\(Year)' and `Direct Fit` not in('NA') limit 0,1", {
            result in
            s19=(result.getString(0))
        }, {})
        return s19
    }
    
    public static func getOePart()->String{
        var name=""
       PublicBeans.資料庫.query("select `OE Part Num` from `Summary table`   where `Direct Fit`='\(gets19())' limit 0,1", {
            result in
        name=result.getString(0)
        }, {})
        return name
    }
    
    public static func getSensorMode()->String{
        var name="SP201"
             PublicBeans.資料庫.query("select `Sensor` from `Summary table` where  `Direct Fit`='\(gets19())'", {
                  result in
              name=result.getString(0)
              }, {})
              return name
    }
    public static func getidcount()->Int{
        var idcount=0
        PublicBeans.資料庫.query("select `ID_Count` from `Summary table` where Make='\(Make)' and Model='\(Model)' and year='\(Year)' and `Direct Fit` not in('NA') limit 0,1", {
            result in
            idcount=(Int(result.getString(0))!)
        }, {})
        return idcount
    }
    public static func getWheelCount()->Int{
        var idcount=0
        PublicBeans.資料庫.query("select `Wheel_Count` from `Summary table` where Make='\(Make)' and Model='\(Model)' and year='\(Year)' and `Wheel_Count` not in('NA') limit 0,1", {
            result in
            idcount=(Int(result.getString(0))!)
        }, {})
        return idcount
    }
    public static func getObd1()->String{
        
        var obd=""
        PublicBeans.資料庫.query("select `OBD1` from `Summary table` where Make='\(Make)' and Model='\(Model)' and year='\(Year)' and `OBD1` not in('NA')   limit 0,1", {
            result in
            obd=String(result.getString(0))
        }, {})
        return obd
    }
//    0A02002A5331313336303030303033303030323043393639303030303631363930303030363136393030303030F5
    public static func getOBDFile()->String{
        //        let src = Bundle.main.path(forResource: "test", ofType: "srec") ?? ""
        //        let text = try! String(contentsOfFile:src, encoding: String.Encoding.utf8)
        //        return text.replace("\r","").replace("\n", "")
        var obd=""
        PublicBeans.OBD資料庫.query("select data from obd where name='\(getObd1())'", {
            result in
            obd=result.getString(0)
        }, {})
        return obd
    }
    public static func getX2()->String{
        var obd=""
        PublicBeans.OBD資料庫.query("select data from s19 where name='mcu'", {
            result in
            obd=result.getString(0)
        }, {})
        return obd
    }
    public static func getS19File()->String{
        var obd=""
        PublicBeans.OBD資料庫.query("select data from s19 where name='\(gets19())'", {
            result in
            obd=result.getString(0)
        }, {})
        return obd
    }
    public static func getMcu()->String{
        var obd=""
        PublicBeans.OBD資料庫.query("select data from s19 where name='mcu'", {
            result in
            obd=result.getString(0)
        }, {})
        return obd
    }
    public static func getObdVersion()->String{
        return JzActivity.getControlInstance.getPro(getObd1(),"nodata").replace(".srec", "")
    }
    //Make選擇
    public static func getMake()->make{
        var sql=""
        let res=make()
        if(PublicBeans.選擇按鈕=="jz.15".getFix()||PublicBeans.選擇按鈕=="jz.401".getFix()){
            sql="select distinct `Make`,`Make_img`,`OBD2` from `Summary table` where `Make` IS NOT NULL and `Make_img` not in('NA') and `Direct Fit` not in('SC2575','SC4379') replacer order by `Make` asc"
            if(PublicBeans.選擇按鈕=="jz.15".getFix()){
                sql = sql.replace("replacer", "and `OGL Auto` != '4'")
            }else{
                sql = sql.replace("replacer", "and `OGL CopyID`='True' and OBD2 not in('NA')")
            }
            PublicBeans.資料庫.query(sql, {
                result in
                if(!res.make.contains(result.getString(0))){
                    if(haveOBDfile(result.getString(2))){
                        res.make.append(result.getString(0))
                        res.makeing.append(result.getString((1)))
                    }
                }
            },{
                
            })
        }else{
            sql="select distinct `Make`,`Make_img` from `Summary table` where `Make` IS NOT NULL and `Make_img` not in('NA') and `Direct Fit` not in('SC2575','SC4379') replacer order by `Make` asc"
            switch  PublicBeans.選擇按鈕{
            case "jz.28".getFix():
                sql = sql.replace("replacer", "and `OGL Programe`='True' ")
                break
            case "jz.117".getFix():
                sql = sql.replace("replacer", "and `OGL CopyID`='True' ")
                break
            case "jz.10".getFix():
                sql = sql.replace("replacer", "and `OGL Read`='True'  ")
                break
            default:
                sql = sql.replace("replacer", "")
            }
            PublicBeans.資料庫.query(sql, {
                result in
                res.make.append(result.getString(0))
                res.makeing.append(result.getString((1)))
            },{
                
            })
        }
        return res
    }
    public static func haveOBDfile(_ dir:String)->Bool{
        var obd=""
        PublicBeans.OBD資料庫.query("select count(1) from obd where name='\(dir)'", {
            result in
            obd=result.getString(0)
        }, {})
        print("obdCount\(obd)")
        return obd=="1"
    }
    //Model選擇
    public static func getModel()->model{
        let res=model()
        var sql=""
        if(PublicBeans.選擇按鈕=="jz.15".getFix()||PublicBeans.選擇按鈕=="jz.401".getFix()){
            sql = "select distinct `Model`,`OBD2` from `Summary table` where `Make` = '\(PublicBeans.Make)' and `Direct Fit` not in('SC2575','SC4379') replacer"
            if(PublicBeans.選擇按鈕=="jz.15".getFix()){
                sql = sql.replace("replacer", "and `OGL Auto` != '4'")
            }else{
                sql = sql.replace("replacer", "and `OGL CopyID`='True' and OBD2 not in('NA')")
            }
            PublicBeans.資料庫.query(sql, {
                result in
                if(haveOBDfile(result.getString(1))){
                    res.model.append(result.getString(0))
                }
            },{
                
            })
        }else{
            sql = "select distinct `Model` from `Summary table` where `Make` = '\(PublicBeans.Make)' and `Direct Fit` not in('SC2575','SC4379') replacer"

            switch  PublicBeans.選擇按鈕{
            case "jz.28".getFix():
                sql = sql.replace("replacer", "and `OGL Programe`='True' ")
                break
            case "jz.117".getFix():
                sql = sql.replace("replacer", "and `OGL CopyID`='True' ")
                break
            case "jz.10".getFix():
                sql = sql.replace("replacer", "and `OGL Read`='True'  ")
                break
            default:
                sql = sql.replace("replacer", "")
            }
            PublicBeans.資料庫.query(sql, {
                result in
                res.model.append(result.getString(0))
            },{
                
            })
        }
        
        return res
    }
    //Year選擇
    public static func getYear()->year{
        let res=year()
        var sql=""
        if(PublicBeans.選擇按鈕=="jz.15".getFix()||PublicBeans.選擇按鈕=="jz.401".getFix()){
            sql="select distinct `Year`,`OBD2` from `Summary table` where model='\(PublicBeans.Model)' and make='\(PublicBeans.Make)' and `Direct Fit` not in('INDIRECT') and `OBD2` not in('NA') order by Year asc"
            if(PublicBeans.選擇按鈕=="jz.15".getFix()){
                sql = sql.replace("replacer", "and `OGL Auto` != '4'")
            }else{
                sql = sql.replace("replacer", "and `OGL CopyID`='True' and OBD2 not in('NA')")
            }
            PublicBeans.資料庫.query(sql, {
                result in
                if(haveOBDfile(result.getString(1))){
                    res.year.append(result.getString(0))
                }
            },{
                
            })
        }else{
            sql="select distinct `Year` from `Summary table` where `Make` = '\(PublicBeans.Make)' and `Model` = '\(PublicBeans.Model)' and `Direct Fit` not in('SC2575','SC4379') replacer"
            
            switch  PublicBeans.選擇按鈕{
            case "jz.28".getFix():
                sql = sql.replace("replacer", "and `OGL Programe`='True' ")
                break
            case "jz.117".getFix():
                sql = sql.replace("replacer", "and `OGL CopyID`='True' ")
                break
            case "jz.10".getFix():
                sql = sql.replace("replacer", "and `OGL Read`='True'  ")
                break
            default:
                sql = sql.replace("replacer", "")
            }
            PublicBeans.資料庫.query(sql, {
                result in
                res.year.append(result.getString(0))
            },{
                
            })
        }
        
        return res
    }
    public static func getLfPower()->String{
        var res=""
        let sql="select  `LF Power` from `Summary table` " +
        "where Make='\(PublicBeans.Make)' and Model='\(PublicBeans.Model)' and year='\(PublicBeans.Year)'  and  `Direct Fit` not in('NA') limit 0,1"
        PublicBeans.資料庫.query(sql, {
            result in
            res=result.getString(0)
        },{
            
        })
        return res
    }
    public static func getHEX()->String{
        var res=""
        let sql="select  `OBD Product No. (hex)` from `Summary table` " +
        "where Make='\(PublicBeans.Make)' and Model='\(PublicBeans.Model)' and year='\(PublicBeans.Year)'  and  `Direct Fit` not in('NA') limit 0,1"
        PublicBeans.資料庫.query(sql, {
            result in
            res=result.getString(0)
        },{
            
        })
        if(res.count==4){res=res.substring(2, 4)}else{return "00"}
        return res
    }
    public static func changeFunction(){
        let sql=SqlHelper("favorite")
        sql.autoCreat()
        sql.exSql("delete from favorite where make='\(PublicBeans.Make)' and model='\(PublicBeans.Model)' and year='\(PublicBeans.Year)'")
        sql.exSql("insert into `favorite` (make,model,year) values ('\(PublicBeans.Make)','\(PublicBeans.Model)','\(PublicBeans.Year)')")
        sql.closeDB()
        switch PublicBeans.選擇按鈕 {
        case "jz.10".getFix():
            JzActivity.getControlInstance.changePage(Page_CheckSesor_Detail(), "Page_CheckSesor_Detail", true)
            break
        case "jz.28".getFix():
            JzActivity.getControlInstance.changePage(Page_Program(), "Page_Program", true)
        case "jz.117".getFix():
            JzActivity.getControlInstance.changePage(Page_Select_Wheel(), "Page_Select_Wheel", true)
            break
        case "jz.15".getFix():
            JzActivity.getControlInstance.changePage(Page_Select_Wheel(), "Page_Select_Wheel", true)
            break
        case "jz.401".getFix():
            JzActivity.getControlInstance.changePage(Page_Select_Wheel(), "Page_Select_Wheel", true)
            break
        default:
            break
        }
    }
    //取得ScanID
    public static func getId(_ callback:@escaping(_ a:String)->Void){
        let scanner=Page_Scanner()
        scanner.scanback={
            code in
            var fullNameArr = code.components(separatedBy:"*")
            if(fullNameArr.count<3){fullNameArr=code.components(separatedBy:":")}
            if(fullNameArr.count>=3){
                if(fullNameArr[1].count < PublicBeans.getidcount()){
                    JzActivity.getControlInstance.toast(("jz.284".getFix()))
                }else{
                    callback(fullNameArr[1])
                }
            }else{
                JzActivity.getControlInstance.toast("jz.122".getFix())
            }
            return ()
        }
        JzActivity.getControlInstance.changePage(scanner, "Page_Scanner", true)
    }
    //
 
}
