//
//  MemoryUploader.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/7/29.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import Alamofire
import JzOsSqlHelper
import JzOsFrameWork
class MemeoryUploader{
    public  static var ip="https://bento2.orange-electronic.com/exsql"
    public  struct HTTPBinResponse: Decodable { let url: String }
    //插入燒入紀錄
    public static func InsertMemory(memory:String,errorType:String){
        ViewController.bleMemory=""
        let sqls="insert into `oglitememory`.transfermemory (tx,errortype,serialnumber,make,model,year,account,number,devicetype,directfit) values ('\(memory)','\(errorType)','\(SharePre.sn)','\(PublicBeans.Make.replace("'", ""))','\(PublicBeans.Model.replace("'", ""))','\(PublicBeans.Year.replace("'", ""))','\(SharePre.admin)',\(PublicBeans.燒錄數量),'OGlite','\(PublicBeans.gets19())')"
        AF.upload(Data(sqls.utf8), to: ip,requestModifier: { $0.timeoutInterval = 5 }).responseDecodable(of: HTTPBinResponse.self){ response in
            var result=""
            if(response.data != nil){
                result=String(decoding: response.data!, as: UTF8.self)
            }
            if(result != "success"){
                PublicBeans.txMemory.exSql("CREATE TABLE if not exists updateResult (`id` INTEGER PRIMARY KEY AUTOINCREMENT \n ,`sql` varchar NOT NULL\n)")
                PublicBeans.txMemory.exSql("delete  from `updateResult`  where rowid <= (select (count(*)-1000) from `updateResult`)")
                PublicBeans.txMemory.exSql("insert into `updateResult` (sql) values ('\(sqls.toHex())')")
            }
        }
    }
    //插入Trigger紀錄
    public static func insertTrigger(memory:String,errorType:String,id:String="NA",tem:String="NA",pre:String="NA",bat:String="NA"){
        ViewController.bleMemory=""
        let sqls="insert into `oglitememory`.triggerinfo (make,model,year,admin,tx,type,serial,sensorid,tem,pre,bat,mcuversion,apkversion,bleversion) values ('\(PublicBeans.Make.replace("'", ""))','\(PublicBeans.Model.replace("'", ""))','\(PublicBeans.Year.replace("'", ""))','\(SharePre.admin)','\(memory)','\(errorType)','\(SharePre.sn)','\(id)','\(tem)','\(pre)','\(bat)','\(SharePre.ogversion)','\(JzActivity.getControlInstance.getApkVersion())','NA')"

        AF.upload(Data(sqls.utf8), to: ip,requestModifier: { $0.timeoutInterval = 5 }).responseDecodable(of: HTTPBinResponse.self){ response in
            var result=""
            if(response.data != nil){
                result=String(decoding: response.data!, as: UTF8.self)
            }
            if(result != "success"){
                PublicBeans.txMemory.exSql("CREATE TABLE if not exists updateResult (`id` INTEGER PRIMARY KEY AUTOINCREMENT \n ,`sql` varchar NOT NULL\n)")
                PublicBeans.txMemory.exSql("delete  from `updateResult`  where rowid <= (select (count(*)-1000) from `updateResult`)")
                PublicBeans.txMemory.exSql("insert into `updateResult` (sql) values ('\(sqls.toHex())')")
            }
        }
    }
    //插入OBD紀錄
    public static func insertOBD(memory:String,errorType:String){
        ViewController.bleMemory=""
        let sqls="insert into `oglitememory`.`obd_infomation` (make,model,year,admin,tx,type,serial) values ('\(PublicBeans.Make.replace("'", ""))','\(PublicBeans.Model.replace("'", ""))','\(PublicBeans.Year.replace("'", ""))','\(SharePre.admin)','\(memory)','\(errorType)','\(SharePre.sn)')"
        AF.upload(Data(sqls.utf8), to: ip,requestModifier: { $0.timeoutInterval = 5 }).responseDecodable(of: HTTPBinResponse.self){ response in
            var result=""
            if(response.data != nil){
                result=String(decoding: response.data!, as: UTF8.self)
            }
            if(result != "success"){
                PublicBeans.txMemory.exSql("CREATE TABLE if not exists updateResult (`id` INTEGER PRIMARY KEY AUTOINCREMENT \n ,`sql` varchar NOT NULL\n)")
                PublicBeans.txMemory.exSql("delete  from `updateResult`  where rowid <= (select (count(*)-1000) from `updateResult`)")
                PublicBeans.txMemory.exSql("insert into `updateResult` (sql) values ('\(sqls.toHex())')")
            }
        }
    }
    //插入COPY紀錄
    public static func insertCopyResult(memory:String,errorType:String){
        ViewController.bleMemory=""
        let sqls="insert into `oglitememory`.`copy_result` (serial,account,tx,make,model,year,number,errortype,device_type) values ('\(SharePre.sn)','\(SharePre.admin)','\(memory)','\(PublicBeans.Make.replace("'", ""))','\(PublicBeans.Model.replace("'", ""))','\(PublicBeans.Year.replace("'", ""))','\(PublicBeans.燒錄數量)','\(errorType)','Oglite')"
        AF.upload(Data(sqls.utf8), to: ip,requestModifier: { $0.timeoutInterval = 5 }).responseDecodable(of: HTTPBinResponse.self){
            response in
            var result=""
            if(response.data != nil){
                result=String(decoding: response.data!, as: UTF8.self)
            }
            if(result != "success"){
                PublicBeans.txMemory.exSql("CREATE TABLE if not exists updateResult (`id` INTEGER PRIMARY KEY AUTOINCREMENT \n ,`sql` varchar NOT NULL\n)")
                PublicBeans.txMemory.exSql("delete  from `updateResult`  where rowid <= (select (count(*)-1000) from `updateResult`)")
                PublicBeans.txMemory.exSql("insert into `updateResult` (sql) values ('\(sqls.toHex())')")
            }
        }
    }
}

extension String{
    /*
     String轉換成Hexstring
     */
    public func toHex()->String{
        var tempstring=""
        for i in Data(self.utf8){
            tempstring = tempstring+String(format:"%02X",i)
        }
        return tempstring
    }
    /*
     將Hex轉換成Byte陣列
     */
    func hexToByte() -> Data? {
        let trimmedString = self.trimmingCharacters(in: CharacterSet(charactersIn: "<> ")).replacingOccurrences(of: " ", with: "")
        
        // make sure the cleaned up string consists solely of hex digits, and that we have even number of them
        
        let regex = try! NSRegularExpression(pattern: "^[0-9a-f]*$", options: .caseInsensitive)
        
        let found = regex.firstMatch(in: trimmedString, options: [], range: NSMakeRange(0, trimmedString.count))
        if found == nil || found?.range.location == NSNotFound || trimmedString.count % 2 != 0 {
            return nil
        }
        let data = NSMutableData(capacity: trimmedString.count / 2)
        
        var index = trimmedString.startIndex
        while index < trimmedString.endIndex {
            let byteString = String(trimmedString[index ..< trimmedString.index(after: trimmedString.index(after: index))])
            let num = UInt8(byteString.withCString { strtoul($0, nil, 16) })
            data?.append([num] as [UInt8], length: 1)
            index = trimmedString.index(after: trimmedString.index(after: index))
        }
        
        return data as Data?
    }
    /*
     取得序列化物件
     */
    func getObject()->NSData?{
        let def=UserDefaults.standard
        return def.object(forKey: self) as? NSData
    }
    /*
     取得File
     */
    public func getFile(){
        var data=""
        //        objectStore.getInstance().sql.query("select data from file where name='\(self)'", {
        //            "select"
        //        }, {})
        
    }
}
extension Data{
    /*
     Data轉換成HexString
     */
    public func byteToHex()->String{
        var tempstring=""
        for i in self{
            tempstring = tempstring+String(format:"%02X",i)
        }
        return tempstring
    }
    
}
extension NSObject{
    /*
     儲存序列化物件
     */
    public func storeObject(name:String)->Bool{
        let data=NSKeyedArchiver.archivedData(withRootObject: self)
        //最后将data保存到文件：这里将其作为键值对保存到plist中
        let def=UserDefaults.standard
        def.set(data, forKey: name)
        return def.synchronize()
    }
}


class objectStore{
    public static var instance:objectStore? = nil
    var sql = SqlHelper("txmemory.db")
    init() {
        sql.autoCreat()
        sql.exSql("CREATE TABLE IF NOT EXISTS `file` (\n name VARCHAR PRIMARY KEY,\n data VARCHAR\n);")
    }
    public static func getInstance()->objectStore{
        if(objectStore.instance != nil){
            objectStore.instance=objectStore()
        }
        return objectStore.instance!
    }
    
}
