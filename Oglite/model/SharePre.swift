//
//  SharePre.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/5/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import JzOsFrameWork
import JzOsMultiLanugage
public class SharePre {
    
    //ble連線紀錄
    static var blememory: String {
        get {
            return JzActivity.getControlInstance.getPro("blememory", "nodata")
        }
        set {
            JzActivity.getControlInstance.setPro("blememory", newValue)
        }
    }
    //SN
    static var sn:String{
        get {
            return JzActivity.getControlInstance.getPro("sn", "nodata")
        }
        set {
            JzActivity.getControlInstance.setPro("sn", newValue)
        }
    }
    //Ble版本號
    static var bleVersion:String{
        get {
            return JzActivity.getControlInstance.getPro("bleVersion", "nodata")
        }
        set {
            JzActivity.getControlInstance.setPro("bleVersion", newValue)
        }
    }
    //版本號
    static var ogversion:String{
        get {
            let data=JzActivity.getControlInstance.getPro("ogversion", "nodata").HexToByte()
            if(data==nil){
                return "nodata"
            }else{
                return String(decoding: data!,as: UTF8.self).replace(".srec", "")
            }
        }
        set {
            JzActivity.getControlInstance.setPro("ogversion", newValue)
        }
    }
    //睡眠時間
    static var sleepTime:Int{
        get {
            return JzActivity.getControlInstance.getPro("sleepTime", 300)
        }
        set {
            DispatchQueue.global().async {
                if(Command.setclose(newValue)){
                    JzActivity.getControlInstance.setPro("sleepTime", newValue)
                }
            }
            
        }
    }
    //資料庫版本
    static var mmyVersion:String{
        get {
            return JzActivity.getControlInstance.getPro("mmyVersion", "nodata")
        }
        set {
            JzActivity.getControlInstance.setPro("mmyVersion", newValue)
        }
    }
    //語言版本
    static var languageVersion:String{
        get {
            return JzActivity.getControlInstance.getPro("languageVersion", "nodata")
        }
        set {
            JzActivity.getControlInstance.setPro("languageVersion", newValue)
        }
    }
    //最新版本mmy
    static var mmyinit:String{
        get {
            return JzActivity.getControlInstance.getPro("mmyinit", "no").replace(".db", "")
        }
        set {
            JzActivity.getControlInstance.setPro("mmyinit", newValue)
        }
    }
    //最新版本mcu
    static var mcuinit:String{
        get {
            return JzActivity.getControlInstance.getPro("mcuinit", "nodata").replace(".srec", "")
        }
        set {
            JzActivity.getControlInstance.setPro("mcuinit", newValue)
        }
    }
    //最新版本Lan
    static var laninit:String{
        get {
            return JzActivity.getControlInstance.getPro("laninit", "nodata")
        }
        set {
            JzActivity.getControlInstance.setPro("laninit", newValue)
        }
    }
    //s19是否加載過
    static var s19init:Bool{
        get {
            return JzActivity.getControlInstance.getPro("s19init", false)
        }
        set {
            JzActivity.getControlInstance.setPro("s19init", newValue)
        }
    }
    //s19是否加載過
    static var obdinit:Bool{
        get {
            return JzActivity.getControlInstance.getPro("obdinit", false)
        }
        set {
            JzActivity.getControlInstance.setPro("obdinit", newValue)
        }
    }
    //是否為Beta
    static var isBeta:Bool{
        get {
            return JzActivity.getControlInstance.getPro("isBeta", false)
        }
        set {
            JzActivity.getControlInstance.setPro("isBeta", newValue)
        }
    }
    //溫度單位
    static var tem:Int{
        get {
            return JzActivity.getControlInstance.getPro("Tem", 0)
        }
        set {
            JzActivity.getControlInstance.setPro("Tem", newValue)
        }
    }
    //胎壓單位
    static var pre:Int{
        get {
            return JzActivity.getControlInstance.getPro("Pre", 2)
        }
        set {
            JzActivity.getControlInstance.setPro("Pre", newValue)
        }
    }
    //是否要顯示jz.language
    static var BetaLan:Bool{
        get {
            return JzActivity.getControlInstance.getPro("BetaLan", false)
        }
        set {
            JzLanguage.getInstance().testLan=newValue
            JzActivity.getControlInstance.setPro("BetaLan", newValue)
        }
    }
    //設定多國語言的語系
    static var setLan:String{
        get{
            return JzActivity.getControlInstance.getPro("setLan", "en")
        }
        set{
            JzLanguage.getInstance().lan=newValue
            JzActivity.getControlInstance.setPro("setLan", newValue)
        }
    }
    //登入的帳號
    static var admin:String{
        get{
            return JzActivity.getControlInstance.getPro("admin", "nodata")
        }
        set{
            JzActivity.getControlInstance.setPro("admin", newValue)
        }
    }
    //現在的版本
    static var localVersion:FileJsonVersion{
        get{
            let decoder = JSONDecoder()
            if(JzActivity.getControlInstance.getPro("localVersion", "").isEmpty){
                return FileJsonVersion()
            }else{
                do{
                    return  try decoder.decode(FileJsonVersion.self, from: JzActivity.getControlInstance.getPro("localVersion", "").data(using: String.Encoding.utf16)!)
                }catch{
                     print("取得失敗\(error)")
                    return FileJsonVersion()
                }
            }
        }
    }
    //最新的版本
    static var nowVersion:FileJsonVersion{
        get{
            let decoder = JSONDecoder()
            if(JzActivity.getControlInstance.getPro("nowVersion", "").isEmpty){
                return FileJsonVersion()
            }else{
                do{
                    return  try decoder.decode(FileJsonVersion.self, from: JzActivity.getControlInstance.getPro("nowVersion", "").data(using: String.Encoding.utf16)!)
                }catch{
                    print("取得失敗\(error)")
                    return FileJsonVersion()
                }
            }
        }
    }
}
