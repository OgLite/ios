//
//  Md_Idcopy.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
public class Md_Idcopy{
    public static var 尚未燒錄="0"
    public static var 燒錄成功="1"
    public static var 燒錄失敗="2"
    var wh="WH"
    var vid="Vehice ID"
    var newid="New ID"
    var condition=""
    var readable=false
    func setup(wh:String,vid:String,newid:String,condition:String){
        self.wh=wh
        self.vid=vid
        self.newid=newid
        self.condition=condition
    }
}
