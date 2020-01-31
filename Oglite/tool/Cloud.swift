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
        var data="<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
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
                res = -1
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
}
