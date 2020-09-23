//
//  ConversionJson.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/9/14.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation

class ConversionJson: NSObject {
    static let shared = ConversionJson()
    
    // 解析拿到的 json 轉成 Dictionary 的格式，若沒有回傳 nil
    func JsonToDictionary(data: Data) ->  Dictionary<String,AnyObject>? {
        do {
            //create json object from data
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                // print(json)
                return json
            }
        } catch let error {
            print("JSON to Dictionary error: \(error.localizedDescription)")
        }
        return nil
    } // end func JSONtoDictionary
    
    // 解析拿到的 Dictionary 轉成 JSON 格式
    func DictionaryToJson(parameters: Dictionary<String,AnyObject>) -> Data? {
        do {
            return  try JSONSerialization.data(withJSONObject: parameters,options: .prettyPrinted)
        } catch let error {
            print("Dictionary to JSON error: \(error.localizedDescription)")
            return nil
        }
    }
    
    // 檢查 json 是否為 "<null>"
    func nullToNil(value: AnyObject?) -> AnyObject? {
        if value is NSNull {    return nil } else { return value }
    }
}
