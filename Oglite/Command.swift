//
//  Command.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import JzOsFrameWork
import JzOsTool
import JzOsTaskHandler
public class Command{
    static var rx=""
    static var demo=false
    static var ogCommand=OgCommand()
    static var timer=JzOSTool.timer()
    public static func sendData(_ data:String){
        ogCommand.cancel=false
        Command.timer.zeroing()
        rx=""
        let act=JzActivity.getControlInstance.getActivity() as! ViewController
        let spi=350
        var Tda=""
        if(data.count>spi){
            var long=0
            if(data.count%spi==0){long=data.count/spi}else{
                long=data.count/spi+1
            }
            let a=JzOSTool.timer()
            for i in 0..<long{
                a.zeroing()
                while(a.stop()<0.1){
                    
                }
                if(i==long-1){
                    Tda="87"+data.sub(i*spi..<data.count)+"78"
                }else{
                    if(i==0){
                        var slon=String(format:"%2X",long).replace(" ", "")
                        if(slon.count<2){slon="0"+slon}
                        Tda="87\(slon)"+data.sub(i*spi..<i*spi+spi)
                    }else{
                        Tda="87"+data.sub(i*spi..<i*spi+spi)
                    }
                }
                act.helper.sendData(Tda.HexToByte()!, "8D82", "8D81")
            }
        }else{
            act.helper.sendData(data.HexToByte()!, "8D82", "8D81")
        }
    }
    
    
    public static func getid(_ model:[Md_Idcopy],_ callback:@escaping (_ result:Bool)->Void){
        if(demo){
            DispatchQueue.global().async {
                let data=["aaaaaaaa","bbbbbbbb","cccccccc","dddddddd","eeeeeeee"]
                var a=0
                for i in model{
                    i.vid=data[a]
                    i.newid=""
                    i.condition=Md_Idcopy.尚未燒錄
                    a+=1
                }
                DispatchQueue.main.async {
                    callback(true)
                }
            }
        }else{
            let progress=Progress()
            progress.label="jz.8".getFix()
            JzActivity.getControlInstance.openDiaLog(progress, false, "Progress")
            DispatchQueue.global().async {
                if(ObdCommand.laodingBootloader()){
                    let a=ObdCommand.GetId(model)
                    if(a){
                        MemeoryUploader.insertOBD(memory: ViewController.bleMemory, errorType: "readSuccess")
                    }else{
                        MemeoryUploader.insertOBD(memory: ViewController.bleMemory, errorType: "readFalse")
                    }
                    DispatchQueue.main.async {
                        JzActivity.getControlInstance.closeDialLog()
                        callback(a)
                    }
                }else{
                    DispatchQueue.main.async {
                        MemeoryUploader.insertOBD(memory: ViewController.bleMemory, errorType: "loadFalse")
                        JzActivity.getControlInstance.closeDialLog()
                        callback(false)
                    }
                }
            }
        }
    }
    public enum readidResult {
        case 重複ID
        case 讀取成功
        case 讀取失敗
        case ID已滿
        case 讀取完畢
    }
    public static func getPrID(_ model:[Md_Program],_ callback:@escaping()->Void){
        let progress=Progress()
        JzActivity.getControlInstance.openDiaLog(progress, true, "Progress")
        DispatchQueue.global().async {
            if(goState(BootloaderState.Og_App)){
                var a=ogCommand.GetPr()
                sleep(5)
                a=ogCommand.GetPr()
                ogCommand.叫一下()
                DispatchQueue.main.async {
                    JzActivity.getControlInstance.closeDialLog()
                    var numbercount=0
                    for i in 0..<PublicBeans.燒錄數量{
                        if(model[i].id.isEmpty){
                            numbercount+=1
                        }
                    }
                    for i in 0..<a.count{
                        model[i].id=a[i].id
                        model[i].sensordata=a[i]
                        callback()
                    }
                    print("acount\(a.count) : numcount\(numbercount)")
                    if(a.count != numbercount){
                        JzActivity.getControlInstance.toast("讀取失敗")
                        JzActivity.getControlInstance.openDiaLog(Dia_NoSensor(), false, "Dia_NoSensor")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    JzActivity.getControlInstance.openDiaLog(Dia_NoSensor(), false, "Dia_NoSensor")
                    JzActivity.getControlInstance.closeDialLog()
                    JzActivity.getControlInstance.toast("讀取失敗")
                    callback()
                }
            }
        }
    }
    public static func getPrID(_ id:@escaping(_ a:String)->Void){
        let progress=Progress()
        JzActivity.getControlInstance.openDiaLog(progress, true, "Progress")
        DispatchQueue.global().async {
            if(goState(BootloaderState.Og_App)){
                PublicBeans.燒錄數量=1
                var a=ogCommand.GetPr()
                sleep(5)
                a=ogCommand.GetPr()
                ogCommand.叫一下()
                DispatchQueue.main.async {
                    JzActivity.getControlInstance.closeDialLog()
                    for i in 0..<a.count{
                        id(a[i].id)
                    }
                    if(a.count != PublicBeans.燒錄數量){
                        JzActivity.getControlInstance.toast("讀取失敗")
                        JzActivity.getControlInstance.openDiaLog(Dia_NoSensor(), false, "Dia_NoSensor")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    JzActivity.getControlInstance.openDiaLog(Dia_NoSensor(), false, "Dia_NoSensor")
                    JzActivity.getControlInstance.closeDialLog()
                    JzActivity.getControlInstance.toast("讀取失敗")
                }
            }
        }
    }
    public static func readid(_ callback:@escaping (_ case:readidResult,_ id:String)->Void,_ direct:Int = -1){
        let progress=Progress()
        progress.label="wait".getFix()
        JzActivity.getControlInstance.openDiaLog(progress, true, "Progress")
        DispatchQueue.global().async {
            var id=""
            var readresult=true
            if(demo){id=["11111111","22222222","33333333","44444444","55555555"].randomElement()!
                readresult=[true,false].randomElement()!
                chackIdresult(id, readresult, callback,direct)
            }else{
                DispatchQueue.global().async {
                    if(goState(BootloaderState.Og_App)){
                        let a=ogCommand.GetId()
                        ogCommand.叫一下()
                        DispatchQueue.main.async {
                            chackIdresult(a.id, a.success, callback,direct)
                        }
                    }else{
                        DispatchQueue.main.async {
                            JzActivity.getControlInstance.toast("app_read_failed".getFix())
                            JzActivity.getControlInstance.closeDialLog()
                        }
                    }
                    
                }
            }
            
        }
    }
    public static func programVehicle(_ model:[Md_Idcopy],_ callback:@escaping()->Void){
        if(demo){
            for i in model{
                if(i.readable||i.newid.count>0){i.condition=[Md_Idcopy.燒錄失敗,Md_Idcopy.燒錄成功].randomElement()!}
            }
            callback()
        }else{
            let progress=Progress()
            progress.label="jz.8".getFix()
            JzActivity.getControlInstance.openDiaLog(progress, false, "Progress")
            
            DispatchQueue.global().async {
                if(ObdCommand.laodingBootloader()){
                    let a = ObdCommand.SetireId(model)
                    if(a){
                        MemeoryUploader.insertOBD(memory: ViewController.bleMemory, errorType: "writeSuccess")
                    }else{
                        MemeoryUploader.insertOBD(memory: ViewController.bleMemory, errorType: "writeFalse")
                    }
                    DispatchQueue.main.async {
                        JzActivity.getControlInstance.closeDialLog()
                        callback()
                    }
                }else{
                    MemeoryUploader.insertOBD(memory: ViewController.bleMemory, errorType: "loadFalse")
                    DispatchQueue.main.async {
                        JzActivity.getControlInstance.closeDialLog()
                        callback()
                    }
                }
            }
        }
        
        
    }
    //0A10000E0100092B000000000300000034F5
    public static func writeId(_ model:[Md_Idcopy],_ callback:@escaping()->Void){
        if(demo){
            for i in model{
                if(i.readable||i.newid.count>0){i.condition=[Md_Idcopy.燒錄失敗,Md_Idcopy.燒錄成功].randomElement()!}
            }
            callback()
        }else{
            let progress=Progress()
            progress.label="jz.8".getFix()
            progress.program=true
            JzActivity.getControlInstance.openDiaLog(progress, false, "Progress")
            DispatchQueue.global().async {
                if(goState(BootloaderState.Og_App)){
                    var sen=[String]()
                    for i in 0..<model.count{
                        if(model[i].readable){
                            sen.add(model[i].newid)
                        }
                    }
                    var count=sen.count.toHexString()
                    while(count.count<2){
                        count="0\(count)"
                    }
                    ogCommand.Program(count: count, caller: {
                        a in
                        DispatchQueue.main.async {
                            progress.tit.text="\("jz.8".getFix())...\(a)%"
                        }
                    }, sensor: sen, programFinish: {
                        a in
                        if(a){
                            print("燒錄成功!!")
                            sleep(3)
                            let result=ogCommand.GetPrId()
                            for i in result{
                                for _ in 0..<result.count{
                                    for mod in model{
                                        if(mod.newid.length>=6){
                                            if(mod.newid.substring(mod.newid.count-4) == i.id.substring(4,8)){
                                                mod.newid=i.id
                                            }
                                        }
                                    }
                                    print("成功id\(i.id)")
                                }
                            }
                            sleep(2)
                            ogCommand.IdCopy({a in
                                DispatchQueue.main.async {
                                    JzActivity.getControlInstance.closeDialLog()
                                    if(!a){
                                        for i in model{
                                            i.condition = Md_Idcopy.燒錄失敗
                                        }
                                    }
                                    callback()
                                }
                            }, model, {
                                a,b in
                                if(a){
                                    model[b].condition=Md_Idcopy.燒錄成功
                                }else{
                                    model[b].condition=Md_Idcopy.燒錄失敗
                                }
                                DispatchQueue.main.async {
                                    progress.tit.text="\("jz.8".getFix())...100%"
                                }
                            })
                            
                            if(model.filter({ $0.condition==Md_Idcopy.燒錄成功 }).size == model.size){
                                MemeoryUploader.insertCopyResult(memory: ViewController.bleMemory, errorType: "success")
                            }else{
                                MemeoryUploader.insertCopyResult(memory: ViewController.bleMemory, errorType: "TimeOut")
                            }
                            
                            
                            ogCommand.叫一下()
                        }else{
                            MemeoryUploader.insertCopyResult(memory: ViewController.bleMemory, errorType: "ProgramFalse")
                            ogCommand.叫一下()
                            DispatchQueue.main.async {
                                JzActivity.getControlInstance.closeDialLog()
                                for i in model{
                                    i.condition = Md_Idcopy.燒錄失敗
                                }
                                callback()
                            }
                        }
                        
                    })
                }else{
                    MemeoryUploader.insertCopyResult(memory: ViewController.bleMemory, errorType: "switchFalse")
                    ogCommand.叫一下()
                    DispatchQueue.main.async {
                        JzActivity.getControlInstance.closeDialLog()
                        for i in model{
                            i.condition = Md_Idcopy.燒錄失敗
                        }
                        callback()
                    }
                }
            }
        }
        
        
    }
    public  static func GetCrcString(_ hex:String)-> String{
        var bt=[UInt8](hex.HexToByte()!)
        var c1=UInt8(bt[0])
        for i in 1...bt.count-3{
            c1 ^= bt[i]
        }
        var re=bt
        re[re.count-2]=c1
        return OgCommand.bytesToHex(re)
    }
    public static func programSensor(_ model:[Md_Program],_ callback:@escaping()->Void){
        let progress=Progress()
        progress.label="jz.8".getFix()
        progress.program=true
        JzActivity.getControlInstance.openDiaLog(progress, false, "Progress")
        if(demo){
            
            for i in 0..<PublicBeans.燒錄數量{
                model[i].result=[Md_Program.switchcase.燒錄成功,Md_Program.switchcase.燒錄失敗].randomElement()!
            }
            callback()
        }else{
            DispatchQueue.global().async {
                if(goState(BootloaderState.Og_App)){
                    Command.sendData(Command.GetCrcString("0AE100030100F5"))
                    var sen=[String]()
                    for i in 0..<PublicBeans.燒錄數量{
                        sen.add(model[i].id)
                    }
                    var count=PublicBeans.燒錄數量.toHexString()
                    while(count.count<2){
                        count="0\(count)"
                    }
                    
                    ogCommand.Program(count: count, caller: {
                        a in
                        DispatchQueue.main.async {
                            progress.tit.text="\("jz.8".getFix())...\(a)%"
                        }
                    }, sensor: sen, programFinish: {
                        a in
                        if(a){
                            print("燒錄成功!!")
                            sleep(3)
                            let result=ogCommand.GetPrId()
                            ogCommand.叫一下()
                            usleep(1000*200)
                            Command.sendData(Command.GetCrcString("0AE100030200F5"))
                            for i in model{i.result=Md_Program.switchcase.燒錄失敗}
                            for i in result{
                                for _ in 0..<result.count{
                                    for mod in model{
                                        if(mod.id.length>=6){
                                            if(mod.id.substring(mod.id.count-4) == i.id.substring(4,8)){
                                                mod.id=i.id
                                                mod.sensordata=i
                                                mod.result=Md_Program.switchcase.燒錄成功
                                            }
                                        }
                                    }
                                    print("成功id\(i.id)")
                                }
                            }
                            if(model.filter({ $0.result == Md_Program.switchcase.燒錄成功}).size == PublicBeans.燒錄數量){
                                MemeoryUploader.InsertMemory(memory: ViewController.bleMemory, errorType: "success")
                            }else{
                                MemeoryUploader.InsertMemory(memory: ViewController.bleMemory, errorType: "5")
                            }
                            DispatchQueue.main.async {
                                JzActivity.getControlInstance.closeDialLog()
                                callback()
                            }
                        }else{
                            usleep(1000*200)
                            Command.sendData(Command.GetCrcString("0AE100030200F5"))
                            DispatchQueue.main.async {
                                for i in model{i.result=Md_Program.switchcase.燒錄失敗}
                                ogCommand.叫一下()
                                JzActivity.getControlInstance.closeDialLog()
                                JzActivity.getControlInstance.toast("燒錄失敗")
                                callback()
                            }
                        }
                        
                    })
                }else{
                    MemeoryUploader.InsertMemory(memory: ViewController.bleMemory, errorType: "switchFalse")
                    DispatchQueue.main.async {
                        for i in model{i.result=Md_Program.switchcase.燒錄失敗}
                        JzActivity.getControlInstance.closeDialLog()
                        JzActivity.getControlInstance.toast("燒錄失敗")
                        callback()
                    }
                }
            }
        }
        
    }
    public static func chackIdresult(_ id:String,_ readresult:Bool,_ callback:@escaping (_ case:readidResult,_ id:String)->Void,_ direct:Int){
        DispatchQueue.main.async {
            
            JzActivity.getControlInstance.closeDialLog()
            if(readresult){
                callback(.讀取成功,id)
            }else{
                JzActivity.getControlInstance.toast("讀取失敗")
                callback(.讀取失敗,id)
            }
            
        }
    }
    public static func readSensor(_ callback:@escaping (_ content:[String])->Void ){
        let progress=Progress()
        JzActivity.getControlInstance.openDiaLog(progress, false, "Progress")
        DispatchQueue.global().async {
            if(demo){
                sleep(3)
                DispatchQueue.main.async {
                    JzActivity.getControlInstance.closeDialLog()
                    let a=["C03547D8","50","10","100%","10"]
                    callback(a)
                }
            }else{
                DispatchQueue.global().async {
                    if(goState(BootloaderState.Og_App)){
                        let a=ogCommand.GetId()
                        ogCommand.叫一下()
                        DispatchQueue.main.async {
                            JzActivity.getControlInstance.closeDialLog()
                            if(a.success){
                                var b:[String]=[a.id,"\(a.getKpa())","\(a.getC())",a.getBat(),"\(a.vol)"]
                                if(!a.有無胎溫){
                                    b[1]="NA"
                                }
                                if(!a.有無電壓){
                                    b[4]="NA"
                                }
                                if(!a.有無電池){
                                    b[3]="NA"
                                }
                                MemeoryUploader.insertTrigger(memory: ViewController.bleMemory,errorType: "success",id: b[0],tem: "\(a.c)",pre: "\(a.kpa)",bat: b[3])
                                callback(b)
                            }else{
                                MemeoryUploader.insertTrigger(memory: ViewController.bleMemory,errorType: "timeout")
                                JzActivity.getControlInstance.closeDialLog()
                                JzActivity.getControlInstance.openDiaLog(Dia_NoSensor(), false, "Dia_NoSensor")
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            MemeoryUploader.insertTrigger(memory: ViewController.bleMemory,errorType: "switchFalse")
                            JzActivity.getControlInstance.closeDialLog()
                            JzActivity.getControlInstance.openDiaLog(Dia_NoSensor(), false, "Dia_NoSensor")
                        }
                    }
                    
                }
            }
        }
        
    }
    public static func getState()->Bool{
        sendData(ObdCommand.addcheckbyte("0A0000030000F5"))
        timer.zeroing()
        while(true){
            if(timer.stop()>3){
                return false
            }
            if(rx.count>=14){
                switch rx.substring(8, 10) {
                case "01":
                    PublicBeans.BootloaderState=BootloaderState.Bootloader
                    break
                case "02":
                    PublicBeans.BootloaderState=BootloaderState.Og_App
                    break
                case "03":
                    PublicBeans.BootloaderState=BootloaderState.Obd_App
                    break
                default:
                    break
                }
                return true
            }
        }
    }
    public static func readSN()->Bool{
        if(goState(BootloaderState.Bootloader)){
            print("跳轉成功")
            sendData("0ADF00010000F5")
            timer.zeroing()
            while (true) {
                if(timer.stop()>2){
                    return false
                }
                if(rx.count>=24){
                    SharePre.sn=rx.sub(8..<20)
                    print("SN",rx.sub(8..<20))
                    return true
                }
                usleep(1000*100)
            }
        }else{
            print("跳轉失敗")
            return false
        }
        
    }
    public static func readBleVersion()->Bool{
        if(goState(BootloaderState.Bootloader)){
            print("跳轉成功")
            sendData("0AF9F5")
            timer.zeroing()
            while (true) {
                if(timer.stop()>2){
                    return false
                }
                if(rx.count>=24){
                    SharePre.bleVersion=rx.sub(6..<14)
                    print("BleVersion:",rx.sub(6..<14))
                    return true
                }
                usleep(1000*100)
            }
        }else{
            print("跳轉失敗")
            return false
        }
        
    }
    
    public static func setclose(_ a:Int)->Bool{
        if(goState(BootloaderState.Bootloader)){
            print("跳轉成功")
            var time=a.toHexString()
            while(time.count<4){
                time="0\(time)"
            }
            sendData("0AE50004\(time)00F5")
            timer.zeroing()
            while (true) {
                if(timer.stop()>2){
                    return false
                }
                if(rx.count==14){
                    return true
                }
                usleep(1000*100)
            }
        }else{
            print("跳轉失敗")
            return false
        }
    }
    
    public static func goState(_ state:Int)->Bool{
        if(demo){
            return true
        }else{
            switch state {
            case BootloaderState.Bootloader:
                sendData(ObdCommand.addcheckbyte("0A0D00030000F5"))
                break
            case BootloaderState.Obd_App:
                sendData(ObdCommand.addcheckbyte("0A0D00030200F5"))

                break
            case BootloaderState.Og_App:
                sendData(ObdCommand.addcheckbyte("0A0D00030100F5"))
                break
            default:
                break
            }
            usleep(200*1000)
            timer.zeroing()
            return true
//            getState()
//            if(PublicBeans.BootloaderState==state){
//                print("跳轉成功")
//                return true
//            }else{
//                print("跳轉失敗\(PublicBeans.BootloaderState):\(state)")
//                return false
//            }
        }
    }
    public static var cangetBattery=true
    public static func getBattery(){
        if(!cangetBattery){return}
        DispatchQueue.global().async {
            if(goState(BootloaderState.Bootloader)){
                sendData("0AEE00000000F5")
                timer.zeroing()
                while(true){
                    if(timer.stop()>2){
                        return
                    }
                    if(rx.length==14){
                        DispatchQueue.main.async {
                            ViewController.updateBattery!(rx.sub(8..<10))
                        }
                        return
                    }
                    usleep(100*1000)
                }
            }
        }
    }
    
}
