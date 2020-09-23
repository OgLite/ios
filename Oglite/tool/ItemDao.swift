//
//  ItemDao.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import JzOsFrameWork
public class ItemDao{
    public static func getRelearm()->String{
        var result=""
        let a=SharePre.setLan
        var colume="Relearn Procedure (English)"
        switch(a){
        case "en":
            colume="Relearn Procedure (English)"
            break
        case "tw":
            colume="Relearn Procedure (Traditional Chinese)"
            break
        case "de":
            colume="Relearn Procedure (German)"
            break
        case "it":
            colume="Relearn Procedure (Italian)"
            break
        case "zh-rcn":
            colume="Relearn Procedure (Jane)"
            break
        default:
            break;
        }
        if( PublicBeans.地區 == "EU"){
            
        }else{
            
        }
        let sql="select `\(colume)` from `Summary table` where make='\(PublicBeans.Make)' and model='\(PublicBeans.Model)' and year='\(PublicBeans.Year)' limit 0,1"
        PublicBeans.資料庫.query(sql,{
            a in
            result="OE Part # :\n\(PublicBeans.getOePart())\n\nFor OrangeSensor:\n\((PublicBeans.地區 == "EU") ? PublicBeans.gets19(): "\(PublicBeans.getSensorMode()) USB")\n\nRelearn:\n\(a.getString(0))"
        } , {})
        return result
    }
}
