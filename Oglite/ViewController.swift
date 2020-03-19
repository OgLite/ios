//
//  ViewController.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/29.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
import JzBleHelper_os
import IQKeyboardManagerSwift
import CoreBluetooth
import JzOsTool
import Firebase

class ViewController:JzActivity,BleCallBack{
    @IBOutlet weak var backbt: UIButton!
    @IBOutlet weak var container: UIView!
    
    @IBOutlet var topright: UIButton!
    lazy var helper=BleHelper(self)
    var scanback:(()->Void?)? = nil
    override func viewInit() {
        Messaging.messaging().subscribe(toTopic: "ogliteupdate") { error in
          print("Subscribed to ogliteupdate topic")
        }
        IQKeyboardManager.shared.enable=true
        rootView=container
        PublicBeans.OBD資料庫.autoCreat()
        if(JzActivity.getControlInstance.getPro("admin", "nodata")=="nodata"){
            let area=JzActivity.getControlInstance.getNewController("Main", "Page_Area") as! Page_Area
            JzActivity.getControlInstance.setHome(area, "area")
        }else{
            JzActivity.getControlInstance.setHome(Page_Home(), "Page_Home")
        }
    }
    @IBAction func signOut(_ sender: Any) {
        JzActivity.getControlInstance.openDiaLog(SignOut(), false, "SignOut")
   
    }
    
    override func changePageListener(_ controler: pagemenory) {
        if(Pagememory.count<2){
            backbt.isHidden=true
        }else{
            backbt.isHidden=false
        }
        PublicBeans.refrsh()
        print("Switch\(controler.tag)")
        if(controler.tag=="Page_Home"){
            topright.isHidden=false
            topright.setImage(UIImage(named: "exit"), for: .normal)
        }else{
            if(helper.isPaired()){
                topright.isHidden=false
            }else{
                topright.isHidden=true
            }
            topright.setImage(UIImage(named: "icon_O-Genius Lite Link"), for: .normal)
        }
    }
    
    @IBAction func goback(_ sender: Any) {
        JzActivity.getControlInstance.goBack()
    }
    var bles:[CBPeripheral]=[CBPeripheral]()
    
    //連線中的回調
    func onConnecting() {
        print("onConnecting")
    }
    //連線失敗時回調
    func onConnectFalse() {
        print("onConnectFalse")
        JzActivity.getControlInstance.closeDialLog()
        helper.startScan()
        JzActivity.getControlInstance.openDiaLog(Select_Ble(), false, "Select_Ble")
    }
    //連線成功時回調
    func onConnectSuccess() {
        print("onConnectSuccess")
        JzActivity.getControlInstance.closeDialLog()
        topright.isHidden=false
        topright.setImage(UIImage(named: "icon_O-Genius Lite Link"), for: .normal)
    }
    
    //三種方式返回接收到的藍芽訊息
    func rx(_ a: BleBinary) {
        Command.rx=Command.rx+a.readHEX()
        print("rx:\(a.readHEX())")
    }
    
    //三種方式返回傳送的藍芽訊息
    func tx(_ b: BleBinary) {
        print("tx:\(b.readHEX())")
    }
    
    //返回搜尋到的藍芽,可將搜尋到的藍芽儲存於陣列中，可用於之後的連線
    func scanBack(_ device: CBPeripheral) {
        if(!bles.contains(device)){
            bles.append(device)
        }
        print(device.name)
        if(scanback != nil){scanback!()}
        
    }
    
    //藍芽未打開，經聽到此function可提醒使用者打開藍芽
    func needOpen() {
        print("noble")
    }
    
}

