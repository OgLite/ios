//
//  SensorData.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/3/18.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import JzIos_Framework
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
    func getC()->Float{
        switch (JzActivity.getControlInstance.getPro("Tem","2")) {
        case "0":
            return self.c
        case "1":
            return (self.c*9/5)+32
        default:
            return self.c
        }
    }
    func getKpa()->Float{
        switch (JzActivity.getControlInstance.getPro("Pre","2")) {
        case "0":
            return Float(Int(kpa*0.145037738))
        case "2":
            return kpa
        case "1":
            return Float(Int(kpa*0.01))
        default:
            return kpa
        }
    }
    static func getTem()->String{
        switch(JzActivity.getControlInstance.getPro("Tem","0")){
        case "0":return "C:"
        case "1":return "F:"
        default: return "C:"
        }
    }
    static func getPre()->String{
        switch(JzActivity.getControlInstance.getPro("Pre","2")){
        case "0":return "Psi:"
        case "1":return "Bar:"
        case "2":return "Kpa:"
        default: return "Kpa:"
        }
    }
}
