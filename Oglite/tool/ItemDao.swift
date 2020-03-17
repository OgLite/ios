//
//  ItemDao.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import JzIos_Framework
public class ItemDao{
    public static func getRelearm()->String{
        var result=""
        let a=JzActivity.getControlInstance.getPro("lan", "English")
                   var colume="Relearn Procedure (English)"
                   switch(a){
                   case "English":
                       colume="Relearn Procedure (English)"
                       break
                   case "繁體中文":
                       colume="Relearn Procedure (Traditional Chinese)"
                       break
                   case "简体中文":
                       colume="Relearn Procedure (Jane)"
                       break
                   case "Deutsch":
                       colume="Relearn Procedure (German)"
                       break
                   case "Italiano":
                       colume="Relearn Procedure (Italian)"
                       break
                   default:
                       break;
                   }
        let sql="select `\(colume)` from `Summary table` where make='\(PublicBeans.Make)' and model='\(PublicBeans.Model)' and year='\(PublicBeans.Year)' limit 0,1"
        PublicBeans.資料庫.query(sql,{
            a in
            result=a.getString(0)
        } , {})
        return result
    }
}
