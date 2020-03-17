//
//  PublicBeans.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import JzIos_Framework
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
    public static var 資料庫:SqlHelper! = nil
    public static var OBD資料庫:SqlHelper! = SqlHelper("obd.db")
    public static var Scan=0
    public static var KetIn=1
    public static var Trigger=2
    public static var selectway=0
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
        PublicBeans.資料庫.query("select `Wheel_Count` from `Summary table` where `OBD1`='\(getObd1())' and `Wheel_Count` not in('NA') limit 0,1", {
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
    public static func getOBDFile()->String{
        var obd=""
        PublicBeans.OBD資料庫.query("select data from obd where name='\(getObd1())'", {
            result in
            obd=result.getString(0)
        }, {})
        return obd
    }
    public static func getS19File()->String{
        var obd=""
        PublicBeans.OBD資料庫.query("select data from obd where name='\(gets19())'", {
            result in
            obd=result.getString(0)
        }, {})
        return obd
    }
    
    public static func getObdVersion()->String{
        return JzActivity.getControlInstance.getPro(getObd1(),"nodata").replace(".srec", "")
    }
    public static func getMake()->make{
        var sql=""
        if(PublicBeans.選擇按鈕==Page_Home.tit[0]||PublicBeans.選擇按鈕==Page_Home.tit[1]){
            sql="select distinct `Make`,`Make_img` from `Summary table` where `Direct Fit` not in('NA') and `Make` IS NOT NULL and `Make_img` not in('NA')  and `OBD1` not in('NA') order by `Make` asc"
        }else{
            sql="select distinct `Make`,`Make_img` from `Summary table` where `Direct Fit` not in('NA') and `Make` IS NOT NULL and `Make_img` not in('NA') order by `Make` asc"
        }
        let res=make()
        PublicBeans.資料庫.query(sql, {
            result in
            res.make.append(result.getString(0))
            res.makeing.append(result.getString((1)))
        },{
            
        })
        return res
    }
    public static func getModel()->model{
        let res=model()
        var sql=""
        if(PublicBeans.選擇按鈕==Page_Home.tit[0]||PublicBeans.選擇按鈕==Page_Home.tit[1]){
            sql="select distinct model from `Summary table` where make='\(PublicBeans.Make)' and `Direct Fit` not in('NA') and `OBD1` not in('NA') order by model asc"
        }else{
            sql="select distinct model from `Summary table` where make='\(PublicBeans.Make)' and `Direct Fit` not in('NA') order by model asc"
        }
        PublicBeans.資料庫.query(sql, {
            result in
            res.model.append(result.getString(0))
        },{
            
        })
        return res
    }
    public static func getYear()->year{
        let res=year()
        var sql=""
        if(PublicBeans.選擇按鈕==Page_Home.tit[0]||PublicBeans.選擇按鈕==Page_Home.tit[1]){
            sql="select distinct Year from `Summary table` where model='\(PublicBeans.Model)' and make='\(PublicBeans.Make)' and `Direct Fit` not in('INDIRECT') and `OBD1` not in('NA') order by Year asc"
        }else{
            sql="select distinct Year from `Summary table` where model='\(PublicBeans.Model)' and make='\(PublicBeans.Make)' and `Direct Fit` not in('INDIRECT')  order by Year asc"
        }
        PublicBeans.資料庫.query(sql, {
            result in
            res.year.append(result.getString(0))
        },{
            
        })
        return res
    }
}
