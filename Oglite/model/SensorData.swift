//
//  SensorData.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/3/18.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import JzOsFrameWork
class SensorData {
    var id = ""
    var idcount = 0
    var bat = ""
    var vol = 0
    var success = false
    var 有無胎溫 = false
    var 有無電池 = false
    var 有無電壓 = false
    var kpa:Float=0
    var c : Float=0
    
    //取得溫度狀態
    func getC()->String{
        var temp=""
        switch (JzActivity.getControlInstance.getPro("Tem",2)) {
        case 0:
            temp = String(format:"%.2f", self.c)
        case 1:
            temp = String(format:"%.2f", (self.c*9/5)+32)
        default:
            temp = String(format:"%.2f", self.c)
        }
        while(temp.length>0 && temp.contains(".")){
            if(temp.substring(temp.length-1,temp.length)=="0"){
                temp=temp.substring(0,temp.length-1)
            }else if(temp.substring(temp.length-1,temp.length)=="."){
                temp=temp.substring(0,temp.length-1)
                break
            }else{
                break
            }
        }
        return temp
    }
    //取得胎壓狀態
    func getKpa()->String{
        print("kpa\(kpa)")
        var temp=""
        switch (JzActivity.getControlInstance.getPro("Pre",2)) {
        case 0:
            temp =  String(format:"%.2f", kpa*0.14)
        case 2:
            temp =  String(format:"%.2f", kpa)
        case 1:
            temp =  String(format:"%.2f", kpa*0.01)
        default:
            temp = String(format:"%.2f", kpa)
        }
        while(temp.length>0 && temp.contains(".")){
            if(temp.substring(temp.length-1,temp.length)=="0"){
                temp=temp.substring(0,temp.length-1)
            }else if(temp.substring(temp.length-1,temp.length)=="."){
                temp=temp.substring(0,temp.length-1)
                break
            }else{
                break
            }
        }
        return temp
    }
    //取得電量狀態
    func getBat()->String{
        if(bat == "1"){
            return "ok"
        }else{
            return "NA"
        }
    }
    static func getTem()->String{
        switch(JzActivity.getControlInstance.getPro("Tem",0)){
        case 0:return "\("jz.375".getFix())"
        case 1:return "\("jz.376".getFix())"
        default: return "\("jz.375".getFix())"
        }
    }
     
    static func getPre()->String{
        switch(JzActivity.getControlInstance.getPro("Pre",2)){
        case 0:return "\("jz.377".getFix())"
        case 1:return "\("jz.378".getFix())"
        case 2:return "\("jz.379".getFix())"
        default: return "\("jz.379".getFix())"
        }
    }
}
