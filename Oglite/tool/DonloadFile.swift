//
//  DonloadFile.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//
import JzOsFrameWork
import JzOsSqlHelper
import Foundation
import JzOsTool
import JzOsTaskHandler
import JzOsMultiLanugage
import SwiftSoup
import JzOsHttpExtension
import FotaLibrary
import BleLibrary
public class DonloadFile{
    public  var webURL: String{
        get{
            if(SharePre.isBeta){
                return "https://bento2.orange-electronic.com/Orange%20Cloud/Beta"
            }else{
                return "https://bento2.orange-electronic.com/Orange%20Cloud"
            }
        }
    }
    public  var fileURL: String{
        get{
            if(SharePre.isBeta){
                return "/Orange%20Cloud/Beta"
            }else{
                return "/Orange%20Cloud"
            }
        }
    }
    //
    public  var arUrl: String{
        get{
            var Area=PublicBeans.地區
            return Area
        }
    }
    //
    public  var progressValue=0
    public  var progress:Int{
        get{
            return progressValue
        }
        set{
            progressValue=newValue
            DispatchQueue.main.async {
                JzActivity.getControlInstance.closeDialLog()
                let a=DataLoading()
                a.label="\(a.檢查更新)...\(Int(Float(newValue)*(Float(100)/Float(120))))%"
                a.updateing=true
                JzActivity.getControlInstance.openDiaLog(a,false,"Progress")
            }
        }
    }
    
    //判斷是否需要初次加載
    public  func needInit()->Bool{
        let item=SharePre.localVersion
        return item.lanVersion == "no" || item.mmyVersion == "no" || item.s19List.isEmpty || item.obdList.isEmpty
    }
    //檢查新版本
    public  func checkNewVersion(){
        DispatchQueue.global().async {
            TaskHandler.newInstance().runTaskOnce("checkNewVersion", {
                let data=HttpCore.get("https://bento2.orange-electronic.com/getVersion?country=\(PublicBeans.地區)&type=OG_lite&beta=\(SharePre.isBeta)",10)
                if(data != nil){
                    do{
                        let decoder = JSONDecoder()
                        let file = try decoder.decode(FileJsonVersion.self, from: data!)
                        file.storeOnline()
                    }catch{
                        
                    }
                }
            })
        }
    }
    //清除資料加載
    public  func clearInit(){
        FileJsonVersion().storeLocal()
    }
    //判斷是否需要更新
    public  func needUpdate()->Bool{
        let local=SharePre.localVersion
        let online=SharePre.nowVersion
        print("\(local.lanVersion) == \(online.lanVersion)")
        print("\(local.mmyVersion) == \(online.mmyVersion)")
        print("\(local.s19List) == \(online.s19List)")
        print("\(local.obdList) == \(online.obdList)")
        print("\(SharePre.ogversion) == \(online.mcuVerion)")
        return local.lanVersion != online.lanVersion || local.mmyVersion != online.mmyVersion || local.s19List != online.s19List || local.obdList != online.obdList || (!online.mcuVerion.contains(SharePre.ogversion))
    }
    //下載更新
    public  func dataloading(_ finish:@escaping(_ a:Bool)->Void){
        DispatchQueue.global().async {
            TaskHandler.newInstance().runTaskOnce("dataloading", {
                self.progress=0
                let data=HttpCore.get("https://bento2.orange-electronic.com/getVersion?country=\(PublicBeans.地區)&type=OG_lite&beta=\(SharePre.isBeta)",10)
                if(data != nil){
                    do{
                        let decoder = JSONDecoder()
                        let file = try decoder.decode(FileJsonVersion.self, from: data!)
                        file.storeOnline()
                        print("下載成功:data->\(file.obdList.count)")
                    }catch{
                        finish(false)
                        return
                    }
                }else{
                    finish(false)
                    return
                }
                if(!self.donloadLanguage()){
                    finish(false)
                    print("donloadLanguage")
                    return
                }
                if(!self.downAllobd()){
                    finish(false)
                    print("downAllobdFalse")
                    return
                }
                if(!self.downAllS19()){
                    finish(false)
                    print("downAllS19False")
                    return
                }
                self.progress+=1
                if(!self.donloadMmy()){
                    finish(false)
                    print("donloadMmyFalse")
                    return
                }
                
                var dd=SharePre.localVersion
                dd.mmyVersion=SharePre.nowVersion.mmyVersion
                dd.storeLocal()
                PublicBeans.資料庫.autoCreat()
                if(!self.downMcu()){
                    print("downMcuFalse")
                    finish(false)
                    return
                }
                var aok=SharePre.localVersion
                aok=SharePre.nowVersion
                aok.storeLocal()
                finish(true)
            })
        }
    }
    public  func donloadLanguage()->Bool{
        var local=SharePre.localVersion
        let online=SharePre.nowVersion
        if(local.lanVersion==online.lanVersion){
            return true
        }else{
            if(JzLanguage.getInstance().languageDB!.initByUrl("\(webURL)/Language/\(online.lanVersion)")){
                local.lanVersion=online.lanVersion
                local.storeLocal()
                return true
            }else{
                return false
            }
            
        }
    }
    
    public  func donloadMmy()->Bool{
        var local=SharePre.localVersion
        let online=SharePre.nowVersion
        if(local.mmyVersion == online.mmyVersion ){
            return true
        }
        if(PublicBeans.資料庫.initByUrl("\(webURL)/Database/MMY/\(arUrl)/\(online.mmyVersion)")){
            local.mmyVersion=online.mmyVersion
            local.storeLocal()
            return true
        }else{
            return false
        }
    }
    
    public  func downMcu()->Bool{
        let online=SharePre.nowVersion
        if(online.mcuVerion != "nodata" && online.mcuVerion.contains(SharePre.ogversion)){
            return true
        }
        print("\(webURL)/Drive/OG_lite/Firmware/\(online.mcuVerion)")
        let file=HttpCore.get("\(webURL)/Drive/OG_lite/Firmware/\(online.mcuVerion)",10)
        if(file==nil){
            print("下載mcu失敗")
            return false
        }else{
            DispatchQueue.main.async {
                let progress = Progress()
                progress.label="\("jz.200".getFix())...0%"
                JzActivity.getControlInstance.openDiaLog(progress, false, "mcuprogress")
            }
            print("下載mcu成功")
            var result=true
            var lastprogress=0
            SharePre.mcuinit=online.mcuVerion
            PublicBeans.OBD資料庫.exSql("delete from `s19` where name='mcu'")
            PublicBeans.OBD資料庫.exSql("insert into `s19` (name,data) values ('mcu','\(String(data: file!, encoding: .utf8)!.replace("\r", "").replace("\n", ""))')")
            Command.ogCommand.WriteBootloader(40, {
                a in
                if(lastprogress != a){
                    lastprogress=a
                    DispatchQueue.main.async {
                        JzActivity.getControlInstance.closeDialLog("mcuprogress")
                        let progress = Progress()
                        progress.label="\("jz.200".getFix())...\(a)%"
                        JzActivity.getControlInstance.openDiaLog(progress, false, "mcuprogress")
                    }
                }
                
            }, {
                a in
                result=a
                DispatchQueue.main.async {
                    JzActivity.getControlInstance.closeDialLog("mcuprogress")
                }
            })
            return result
        }
    }
    public  func mcuname()->String{
        let url = URL(string: "\(webURL)/Drive/OG_lite/Firmware/")
        var data: Data? = nil
        if let anUrl = url {
            do{
                try data = Data(contentsOf: anUrl)
                let ds=String(decoding: data!, as: UTF8.self).components(separatedBy: "HREF=")
                let filename=ds[2].components(separatedBy: ">")[1].components(separatedBy: "<")[0]
                print(filename)
                SharePre.mcuinit=filename
                return "\(filename)"
                
            }catch{print(error)
                return "nodata"
            }
        }
        return "nodata"
    }
    
    public  func downAllS19()->Bool{
        PublicBeans.OBD資料庫.exSql("CREATE TABLE if not exists `s19` ( name VARCHAR, data TEXT);")
        for i in SharePre.nowVersion.s19List{
            let res=downs19(i.key)
            progress+=1
            if(!res){
                return false
            }
        }
        return true
    }
    
    public func downs19(_ name:String)->Bool{
        let nowVersion=SharePre.nowVersion
        var local=SharePre.localVersion
        if(local.s19List[name] == nowVersion.s19List[name]){return true}
        print("rout:\(webURL)/Database/SensorCode/SIII/\(name)/\(nowVersion.s19List[name] ?? "")")
        let result=HttpCore.get("\(webURL)/Database/SensorCode/SIII/\(name)/\(nowVersion.s19List[name] ?? "")",10)
        if(result != nil){
            local.s19List[name]=nowVersion.s19List[name]
            local.storeLocal()
            PublicBeans.OBD資料庫.exSql("delete from `s19` where name='\(name)'")
            PublicBeans.OBD資料庫.exSql("insert into `s19` (name,data) values ('\(name)','\(String(data: result!, encoding: String.Encoding.utf8)!.replace("\r\n", ""))')")
            return true
        }else{
            return false
        }
    }
    
    public  func downAllobd()->Bool{
        PublicBeans.OBD資料庫.exSql("CREATE TABLE if not exists `obd` ( name VARCHAR, data TEXT);")
        for i in SharePre.nowVersion.obdList{
            let res=downobd(i.key)
            progress+=1
            if(!res){
                return false
            }
        }
        return true
    }
    
    public  func downobd(_ name:String)->Bool{
        let nowVersion=SharePre.nowVersion
        var local=SharePre.localVersion
        if(local.obdList[name] == nowVersion.obdList[name]){return true}
        let result=HttpCore.get("\(webURL)/Drive/OBD%20DONGLE%202/\(name)/\(nowVersion.obdList[name] ?? "")",10)
        if(result != nil){
            local.obdList[name]=nowVersion.obdList[name]
            local.storeLocal()
            PublicBeans.OBD資料庫.exSql("delete from `obd` where name='\(name)'")
            PublicBeans.OBD資料庫.exSql("insert into `obd` (name,data) values ('\(name)','\(String(data: result!, encoding: String.Encoding.utf8)!.replace("\r\n", ""))')")
            return true
        }else{
            return false
        }
    }
    
    
    
    
    
    
    //MARK:Ble更新
//    var manager: FotaPeripheralManager = AppDelegate.shared().peripheralManager
//    var fotaFile: FotaFile?
//    private var _stateChangedHandler: EventHandlerProtocol?
//    private var _progressHandler: EventHandlerProtocol?
//    private var _completedHandler: EventHandlerProtocol?
//    private var runQueue = DispatchQueue(label: "fota.RunQueue")
//    private var currentProgress: Int? = 0
//    private var lastProgress: Int? = nil
//    private var throughput: Double = 0.0
//    private var throughputTimer: Timer? = nil
//    private var controller: FotaController?
//    private var currentStep: FotaUpdateStep = FotaUpdateStep.idle
//    private var progressLock = DispatchQueue(label: "com.onsemi.fota.BleDeviceViewController.progressLock", attributes:  .concurrent)
//    private func run()
//    {
//        
//        guard manager.selected != nil else
//        {
//            return
//        }
//        
//        guard fotaFile != nil else
//        {
//            print("Error: No file selected!")
//            return
//        }
//        
//        
//        runQueue.async{
//            
//            self.currentProgress = 0
//            self.lastProgress = 0
//            self.throughput = 0
//            
//            
//            self.controller = FotaController()
//            
//            var options = FotaOptions()
//            options.forceUpdate = false
//            
//            self._progressHandler = self.controller?.eventProgress.addHandler(self, DonloadFile.onProgress)
//            self._completedHandler = self.controller?.eventCompleted.addHandler(self, DonloadFile.onCompleted)
//            let setup = UpdateSetup(provider: self.controller!, source: self.fotaFile ,options: options)
//            
//            DispatchQueue.main.async{
//                self.throughputTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onProgressTimerElapsed(timer:)), userInfo: nil, repeats: true)
//            }
//            
//            do
//            {
//                try self.manager.selected?.update(updateSetup: setup)
//            }
//            catch
//            {
//                print("Update failed: \(error)")
//            }
//            
//            self._progressHandler?.dispose()
//            self._completedHandler?.dispose()
//            
//            if self.manager.selected!.state != PeripheralState.idle
//            {
//                do{
//                    try self.manager.selected?.teardown()
//                }
//                catch
//                {
//                    print("Teardown faild")
//                }
//            }
//        }
//    }
//    
//    //更新完成
//    func onCompleted(args: FotaCompletedEventArgs)
//    {
//        DispatchQueue.main.async
//            {
//                print("Update finnished. Fota: \(args.status.description)")
//                print("更新失敗:\(args.status.description)")
//        }
//        self.throughputTimer?.invalidate()
//        self.throughputTimer = nil
//    }
//    
//    //更新中
//    func onProgress(args: FotaProgressEventArgs)
//    {
//        DispatchQueue.main.async {
//            if args.current == 0
//            {
//                self.currentStep = args.step
//                print("\(self.currentStep.description)")
//            }
//            
//            if args.total == 0
//            {
//                self.progress = 0
//                self.currentProgress = 0;
//            }
//            else
//            {
//                self.progressLock.sync {
//                    self.currentProgress = args.current
//                }
//                
//                let progress: Float = Float(args.current) / Float(args.total)
//                print(progress)
//                self.progress = Int(progress)
//            }
//        }
//    }
//    @objc private func onProgressTimerElapsed(timer: Timer)
//    {
//        progressLock.sync
//            {
//                if (currentStep == FotaUpdateStep.updateFotaImage || currentStep == FotaUpdateStep.updateAppImage)
//                {
//                    let progress = currentProgress! - lastProgress!
//                    lastProgress = currentProgress!
//                    if currentProgress == 0
//                    {
//                        throughput = 0
//                        return
//                    }
//                    
//                    throughput = Double(progress) / 1024
//                    DispatchQueue.main.async {
//                        print("\(self.currentStep.description) - \(String(format: "%.2f", self.throughput))kB/s")
//                    }
//                }
//        }
//    }
//    public func donloadBle(){
//        let fm = FileManager.default
//        let src = Bundle.main.path(forResource: "OGLE_BLE_BV10_SV10", ofType: "fota") ?? ""
//        print("OGLE_BLE_BV10_SV10 fileExists src=\(src)")
//        let dst = NSHomeDirectory() + "/Documents/as.fota"
//        if !fm.fileExists(atPath: dst) {
//            try! fm.copyItem(atPath: src, toPath: dst)
//        }
//        print("perSize:\(AppDelegate.shared().peripheralManager.peripherals)");
//        let act=JzActivity.getControlInstance.getActivity() as! ViewController
//        for i in AppDelegate.shared().peripheralManager.peripherals{
//            if("\(act.helper.connectPeripheral.identifier)" == "\(i.uuid)"){
//                AppDelegate.shared().peripheralManager.stopScan()
//                AppDelegate.shared().peripheralManager.selected = i
//                break
//            }
//        }
//        print("dst fileExists")
//        fotaFile = FotaFile(fileName: dst)
//        self.run()
//    }
}
