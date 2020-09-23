//
//  Md_FileJsonVersion .swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/9/14.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import JzOsFrameWork
struct  FileJsonVersion:Codable {
    var mmyVersion = "no"
    var lanVersion = "no"
    var mcuVerion  = "no"
    var apkVersion = "no"
    var s19List = Dictionary<String,String>()
    var s18List = Dictionary<String,String>()
    var obdList = Dictionary<String,String>()
    
}
extension FileJsonVersion{
    func storeLocal(){
        do{
            let encodedData = try JSONEncoder().encode(self)
            let jsonString = String(data:encodedData,encoding: .utf8)
            JzActivity.getControlInstance.setPro("localVersion", jsonString!)
        }catch{
              print("儲存失敗")
        }
    }
    
    func storeOnline(){
        do{
            let encodedData = try JSONEncoder().encode(self)
            let jsonString = String(data:encodedData,encoding: .utf8)
            JzActivity.getControlInstance.setPro("nowVersion", jsonString!)
        }catch{
            print("儲存失敗")
        }
    }
}
