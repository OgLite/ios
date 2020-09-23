//
//  Md_Program.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/24.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
public class Md_Program{
  public  enum switchcase {
        case 燒錄成功
        case 燒錄失敗
        case 尚未燒錄
    }
   public var result=switchcase.尚未燒錄
   public var id=""
   var sensordata=SensorData()
   public var position=""
}
