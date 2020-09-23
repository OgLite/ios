//
//  ViewController.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/29.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
import JzBleHelper_os
import IQKeyboardManagerSwift
import CoreBluetooth
import JzOsTool
import Firebase
import JzOsTaskHandler
import JzOsMultiLanugage
import JzOsHttpExtension
import SwiftSoup
class ViewController:JzActivity,BleCallBack{
    @IBOutlet var backbt: UIButton!
    @IBOutlet  var container: UIView!
    @IBOutlet var topright: UIButton!
    @IBOutlet var tit: UILabel!
    var timer: Timer?
    var timer2: Timer?
    lazy var helper=BleHelper(self)
    var scanback:(()->Void?)? = nil
    var goMenu=false
    static var updateBattery:((_ a:String)->Void?)? = nil
    public static var tempb=""
    public static var bleMemory:String
    {
        get{
            return tempb
        }
        set(myValue) {
            if(myValue.length>40000){
                self.tempb=myValue.sub((myValue.length-40000)..<myValue.length)
            }
            self.tempb=myValue
        }
    }
    @IBOutlet var iconarea: UIImageView!
    override func viewInit() {
        PublicBeans.txMemory.autoCreat()
        JzLanguage.getInstance().testLan=SharePre.BetaLan
        JzLanguage.getInstance().lan=SharePre.setLan
        ViewController.updateBattery={
            a in
            switch a {
            case "00":
                self.topright.setImage(UIImage(named: "icon_replace"), for: .normal)
                break
            case "01":
                self.topright.setImage(UIImage(named: "icon_low"), for: .normal)
                break
            case "02":
                self.topright.setImage(UIImage(named: "icon_ok"), for: .normal)
                break
            case "03":
                self.topright.setImage(UIImage(named: "icon_full"), for: .normal)
                break
            case "FF":
                self.topright.setImage(UIImage(named: "replace_battery"), for: .normal)
                break
            default:
                break
            }
            return()
        }
        IQKeyboardManager.shared.enable=true
        rootView=container
        PublicBeans.OBD資料庫.autoCreat()
        PublicBeans.資料庫.autoCreat()
        if(SharePre.admin=="nodata"){
            let area=JzActivity.getControlInstance.getNewController("Main", "Page_Area") as! Page_Area
            JzActivity.getControlInstance.setHome(area, "area")
        }else{
            JzActivity.getControlInstance.setHome(Page_Home(), "Page_Home")
        }
        JzActivity.getControlInstance.openDiaLog(Dia_Logo(), false, "Dia_Logo")
        //跑timer判斷有無資料需補上傳
        TaskHandler.newInstance().runTaskTimer("checkUploader", 5.0, {
            TaskHandler.newInstance().runTaskOnce("updateing", {
                PublicBeans.txMemory.query("select * from `updateResult`", {
                    it in
                    if((HttpCore.post(MemeoryUploader.ip, 5.0,it.getString(1).hexToByte()!)) != nil){
                        PublicBeans.txMemory.exSql("delete from `updateResult` where id=\(it.getString(0))")
                    }
                }, {})

            })
        })
        //取得電池電量
        TaskHandler.newInstance().runTaskTimer("getbattery", 5.0, { [self] in
            if(JzActivity.getControlInstance.getNowPageTag()=="Page_Home" && helper.isPaired()){
                Command.getBattery()
            }
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(askBle), userInfo: nil, repeats: true)
        self.timer2 = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(checkNewVersions), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.timer?.invalidate()
        self.timer2?.invalidate()
    }
   
    @objc func checkNewVersions(){
        if(helper.isPaired()){
            DonloadFile().checkNewVersion()
        }
    }
    @objc func askBle(){
        if(!helper.isOpen() || !helper.isPaired()){
            helper.startScan()
            JzActivity.getControlInstance.openDiaLog(Select_Ble(), false, "Select_Ble")
        }
    }
    @IBAction func signOut(_ sender: Any) {
        
    }
    
    override func changePageListener(_ controler: pagemenory) {
        if(Pagememory.count<2){
            backbt.isHidden=true
        }else{
            backbt.isHidden=false
        }
        controler.page.view.fixLanguage()
        PublicBeans.refrsh()
        if(PublicBeans.地區 == "EU"){
            iconarea.image=UIImage(named: "icon_EU")
        }else if(PublicBeans.地區 == "US"){
            iconarea.image=UIImage(named: "icon_NA")
        }else{
            iconarea.image=UIImage(named: "icon_tw")
        }
        print("Switch\(controler.tag)")
        goMenu=false
        backbt.setImage(UIImage(named: "btn_back"), for: .normal)
        if(controler.tag=="Page_Home"&&helper.isPaired()){
            checkUpdate()
        }
        switch controler.tag {
        case "Page_Vehicle_Select":
            tit.text=PublicBeans.選擇按鈕
        case "area":
            tit.text="jz.152".getFix()
        case "Page_Policy":
            tit.text="jz.63".getFix()
        case "Page_SignIn":
            tit.text="jz.5".getFix()
        case "Page_Home":
            tit.text="O-Genius Lite".getFix()
        default:
            break
        }
        if(SharePre.isBeta){
            tit.text="我是BETA"
        }
            }
    
    @IBAction func goback(_ sender: Any) {
        if(goMenu){
            JzActivity.getControlInstance.goMenu()
        }else{
            JzActivity.getControlInstance.goBack()
        }
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
        Command.ogCommand.cancel=true
    }
    //連線成功時回調
    func onConnectSuccess() {
        print("onConnectSuccess")
        helper.stopScan()
        SharePre.blememory="\(helper.connectPeripheral.identifier)"
        let progress=Progress()
        progress.label=progress.連線BLE
        JzActivity.getControlInstance.openDiaLog(progress, false, "Progress")
        DispatchQueue.global().async {
            TaskHandler.newInstance().runTaskOnce("onConnectSuccess", {
                sleep(4)
                Command.getState()
                usleep(1000*200)
                Command.readSN()
                print("SN",SharePre.sn)
                if(!Command.ogCommand.askVersion()){
                    self.helper.disconnect()
                }
                Command.setclose(SharePre.sleepTime)
                Command.readBleVersion()
                DispatchQueue.main.async {
                    JzActivity.getControlInstance.closeDialLog()
                    if(JzActivity.getControlInstance.getNowPageTag() == "Page_Home"){
                        self.checkUpdate()
                    }
                }
            })
        }
        JzActivity.getControlInstance.closeDialLog()
        checkUpdate()
    }
    //更新檢查
    func checkUpdate(){
        let cc = DonloadFile()
        if(cc.needInit()){
            Command.cangetBattery=false
            let a=DataLoading()
            a.label=a.檢查更新
            JzActivity.getControlInstance.openDiaLog(a, false, "DataLoading")
            DonloadFile().dataloading({
                a in
                Command.cangetBattery=true
                DispatchQueue.main.async {
                    JzActivity.getControlInstance.closeDialLog()
                    if(!a){
                        self.checkUpdate()
                    }
                }
            })
        }else if(cc.needUpdate()){
            JzActivity.getControlInstance.openDiaLog(Dia_Update(), false, "Dia_Update")
        }
    }
    
    //三種方式返回接收到的藍芽訊息
    func rx(_ a: BleBinary) {
        Command.rx=Command.rx+a.readHEX()
        ViewController.bleMemory += "RX \(Date().date2String("HH:mm:ss:SSS")):\(a.readHEX())\n"
        print("Ble->rx:\(a.readHEX())")
        if(a.readHEX()=="F500000304F20A" || "0AF700030000F5".contains(a.readHEX()) ){
            if(JzActivity.getControlInstance.getNowPage() is Page_Idcopy_obd  ){
                (JzActivity.getControlInstance.getNowPage() as! Page_Idcopy_obd).readsensor("")
            }else if(JzActivity.getControlInstance.getNowPage() is Page_CheckSesor_Detail){
                (JzActivity.getControlInstance.getNowPage() as! Page_CheckSesor_Detail).readsensor(self)
            }else if(JzActivity.getControlInstance.getNowPage() is Page_Program_Detail){
                (JzActivity.getControlInstance.getNowPage() as! Page_Program_Detail).read(self)
            }
        }
    }
    
    //三種方式返回傳送的藍芽訊息
    func tx(_ b: BleBinary) {
        ViewController.bleMemory += "TX: \(Date().date2String("HH:mm:ss:SSS")):\(b.readHEX())\n"
        print("Ble->tx:\(b.readHEX())")
    }
    
    //返回搜尋到的藍芽,可將搜尋到的藍芽儲存於陣列中，可用於之後的連線
    func scanBack(_ device: CBPeripheral) {
        if(!helper.isPaired() && "\(device.identifier)" == SharePre.blememory){
            let progress=Progress()
            progress.label=progress.連線BLE
            JzActivity.getControlInstance.openDiaLog(progress, false, "Progress")
            helper.connect(device, 5)
        }
        if(!bles.contains(device)){
            if(device.name != nil){
                if(device.name!.contains("OG_Lite")){
                    bles.append(device)
                }
            }
        }
        print(device.name)
        if(scanback != nil){scanback!()}
    }
    
    //藍芽未打開，經聽到此function可提醒使用者打開藍芽
    func needOpen() {
        print("noble")
    }
}

