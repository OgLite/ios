//
//  Cloud.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/30.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
class Cloud{
    static let link="https://bento2.orange-electronic.com/App_Asmx/ToolApp.asmx"
    
    static var SigninBack:((_ Result: Int) -> Void?)? = nil
    static func Signin(_ admin:String,_ password:String,_ callback:@escaping (_ Result:Int)->Void){
        Cloud.SigninBack=callback
        let url = URL(string: link)!
        var request = URLRequest(url: url)
        request.setValue("application/soap+xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let data="<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
            "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n" +
            "  <soap12:Body>\n" +
            "    <ValidateUser xmlns=\"http://tempuri.org/\">\n" +
            "      <UserID>"+admin+"</UserID>\n" +
            "      <Pwd>"+password+"</Pwd>\n" +
            "    </ValidateUser>\n" +
            "  </soap12:Body>\n" +
        "</soap12:Envelope>"
        var res = -1
        request.httpBody = data.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let back=SigninBack!
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "Unknown error")
                    res = -1
                    DispatchQueue.main.async {
                        back(res)
                    }
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                res = -1
                DispatchQueue.main.async {
                    back(res)
                }
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            print(responseString!.components(separatedBy: "ValidateUserResult").count)
            if(responseString!.components(separatedBy: "ValidateUserResult").count != 3){
                print("noequal")
                res = 1
            }else{
                if(responseString!.components(separatedBy: "ValidateUserResult")[1].replace(">", "").replace("<", "").replace("/", "").contains("true")){
                    res = 0
                }else{
                    res = 1
                }
            }
            DispatchQueue.main.async {
                back(res)
            }
            
        }
        task.resume()
    }
    static func ResetPass(_ admin:String,_ callback:@escaping (_ Result:Int)->Void){
           let url = URL(string:link)!
           var request = URLRequest(url: url)
           request.setValue("application/soap+xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
           request.httpMethod = "POST"
           let data="<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
               "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n" +
               "  <soap12:Body>\n" +
               "    <SysResetPwd xmlns=\"http://tempuri.org/\">\n" +
               "      <UserID>"+admin+"</UserID>\n" +
               "    </SysResetPwd>\n" +
               "  </soap12:Body>\n" +
           "</soap12:Envelope>"
           var res = -1
           request.httpBody = data.data(using: .utf8)
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
             let back=callback
               guard let data = data,
                   let response = response as? HTTPURLResponse,
                   error == nil else {
                       print("error", error ?? "Unknown error")
                       res = -1
                       DispatchQueue.main.async {
                        back(res)
                       }
                       return
               }
               
               guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                   print("statusCode should be 2xx, but is \(response.statusCode)")
                   print("response = \(response)")
                   res = -1
                   DispatchQueue.main.async {
                       back(res)
                   }
                   return
               }
               
               let responseString = String(data: data, encoding: .utf8)
               print("responseString = \(responseString)")
               print(responseString!.components(separatedBy: "SysResetPwdResult").count)
               if(responseString!.components(separatedBy: "SysResetPwdResult").count != 3){
                   res = -1
               }else{
                   if(responseString!.components(separatedBy: "SysResetPwdResult")[1].replace(">", "").replace("<", "").replace("/", "").contains("true")){
                       res = 0
                   }else{
                       res = 1
                   }
               }
               DispatchQueue.main.async {
               back(res)
               }
               
           }
           task.resume()
       }
    static func Register(_ admin:String,_ password:String,_ SerialNum:String,_ storetype:String,_ companyname:String,_ firstname:String,_ lastname:String,_ phone:String,_ State:String,_ city:String,_ streat:String,_ zp:String,_ callback:@escaping (_ Result:Int)->Void){
           let url = URL(string: link)!
           var request = URLRequest(url: url)
           request.setValue("application/soap+xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
           request.httpMethod = "POST"
           var data="<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
               "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n" +
               "  <soap12:Body>\n" +
               "    <Register xmlns=\"http://tempuri.org/\">\n" +
               "      <Reg_UserInfo>\n" +
               "        <UserID>"+admin+"</UserID>\n" +
               "        <UserPwd>"+password+"</UserPwd>\n" +
               "      </Reg_UserInfo>\n" +
               "      <Reg_StoreInfo>\n" +
               "        <StoreType>"+storetype+"</StoreType>\n" +
               "        <CompName>"+companyname+"</CompName>\n" +
               "        <FirstName>"+firstname+"</FirstName>\n" +
               "        <LastName>"+lastname+"</LastName>\n" +
               "        <Contact_Tel>"+phone+"</Contact_Tel>\n" +
               "        <Continent>"+State+"</Continent>\n" +
               "        <Country>"+State+"</Country>\n" +
               "        <State>"+city+"</State>\n" +
               "        <City>"+city+"</City>\n" +
               "        <Street>"+streat+"</Street>\n" +
               "        <CompTel>"+companyname+"</CompTel>\n" +
               "      </Reg_StoreInfo>\n" +
               "      <Reg_DeviceInfo>\n" +
               "        <SerialNum>"+SerialNum+"</SerialNum>\n" +
               "        <DeviceType>USBPad</DeviceType>\n" +
               "        <ModelNum>phone</ModelNum>\n" +
               "        <AreaNo>"+zp+"</AreaNo>\n" +
               "        <Firmware_1_Copy>EU-1.0</Firmware_1_Copy>\n" +
               "        <Firmware_2_Copy>EU-1.0</Firmware_2_Copy>\n" +
               "        <Firmware_3_Copy>EU-1.0</Firmware_3_Copy>\n" +
               "        <DB_Copy>EU-1.0 </DB_Copy>\n" +
               "        <MacAddress>00</MacAddress>\n" +
               "        <IpAddress>00</IpAddress>\n" +
               "      </Reg_DeviceInfo>\n" +
               "    </Register>\n" +
               "  </soap12:Body>\n" +
           "</soap12:Envelope>"
           var res = -1
           request.httpBody = data.data(using: .utf8)
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
              let back=callback
               guard let data = data,
                   let response = response as? HTTPURLResponse,
                   error == nil else {
                       print("error", error ?? "Unknown error")
                       res = -1
                       DispatchQueue.main.async {
                        back(res)
                       }
                       return
               }
               
               guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                   print("statusCode should be 2xx, but is \(response.statusCode)")
                   print("response = \(response)")
                   res = -1
                   DispatchQueue.main.async {
                      back(res)
                   }
                   return
               }
               
               let responseString = String(data: data, encoding: .utf8)
               print("responseString = \(responseString)")
               print(responseString!.components(separatedBy: "RegisterResult").count)
               if(responseString!.components(separatedBy: "RegisterResult").count != 3){
                      res = -1
               }else{
                   if(responseString!.components(separatedBy: "RegisterResult")[1].replace(">", "").replace("<", "").replace("/", "").contains("true")){
                       res = 0
                   }else{
                       res = 1
                   }
               }
               
               
               DispatchQueue.main.async {
                 back(res)
               }
               
           }
           task.resume()
       }
    static func AddIfNotValid(_ serial:String,_ admin:String,_ pass:String,_ result:@escaping(_ a:Bool)->Void){
              let url = URL(string: link)!
              var request = URLRequest(url: url)
              request.setValue("application/soap+xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
              request.httpMethod = "POST"
              let data="<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
              "    <soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n" +
              "      <soap12:Body>\n" +
              "        <Register xmlns=\"http://tempuri.org/\">\n" +
              "          <Reg_UserInfo>\n" +
              "            <UserID>\(admin)</UserID>\n" +
              "            <UserPwd>\(pass)</UserPwd>\n" +
              "          </Reg_UserInfo>\n" +
              "          <Reg_StoreInfo>\n" +
              "            <StoreType>Distributor</StoreType>\n" +
              "            <CompName>spare</CompName>\n" +
              "            <FirstName>spare</FirstName>\n" +
              "            <LastName>spare</LastName>\n" +
              "            <Contact_Tel>spare</Contact_Tel>\n" +
              "            <Continent>spare</Continent>\n" +
              "            <Country>spare</Country>\n" +
              "            <State>spare</State>\n" +
              "            <City>spare</City>\n" +
              "            <Street>spare</Street>\n" +
              "            <CompTel>spare</CompTel>\n" +
              "          </Reg_StoreInfo>\n" +
              "          <Reg_DeviceInfo>\n" +
              "            <SerialNum>SP:\(serial)</SerialNum>\n" +
              "            <DeviceType>USBPad</DeviceType>\n" +
              "            <ModelNum>PA001</ModelNum>\n" +
              "            <AreaNo></AreaNo>\n" +
              "            <Firmware_1_Copy>EU-1.0</Firmware_1_Copy>\n" +
              "            <Firmware_2_Copy>EU-1.0</Firmware_2_Copy>\n" +
              "            <Firmware_3_Copy>EU-1.0</Firmware_3_Copy>\n" +
              "            <DB_Copy>EU-1.0 </DB_Copy>\n" +
              "            <MacAddress>00</MacAddress>\n" +
              "            <IpAddress>00</IpAddress>\n" +
              "          </Reg_DeviceInfo>\n" +
              "        </Register>\n" +
              "      </soap12:Body>\n" +
              "    </soap12:Envelope>"
              request.httpBody = data.data(using: .utf8)
              let task = URLSession.shared.dataTask(with: request) { data, response, error in
                  guard let data = data,
                      let response = response as? HTTPURLResponse,
                      error == nil else {
                          print("error", error ?? "Unknown error")
                          result(false)
                          return
                  }
                  guard (200 ... 299) ~= response.statusCode else {
                      print("statusCode should be 2xx, but is \(response.statusCode)")
                      print("response = \(response)")
                       result(false)
                      return
                  }
                  let responseString = String(data: data, encoding: .utf8)
                 result(true)
                  print("responseString = \(responseString)")
              }
              task.resume()
          }

       
}
