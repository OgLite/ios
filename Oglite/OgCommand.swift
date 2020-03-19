//
//  OgCommand.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/3/18.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import Foundation
import JzOsTool
import JzIos_Framework
class OgCommand {
    var Program_Progress:((_ a:Int)->Void)?=nil
    
    var cancel=false
    var ScanCount = 0
    var Rx:String{
        get{
            return Command.rx
        }
    }
    func StringHexToByte(_ a:String)->Data{
        return a.HexToByte()!
    }
    public  func GetCrcString(_ hex:String)-> String{
        var bt=[UInt8](hex.HexToByte()!)
        var c1=UInt8(bt[0])
        for i in 1...bt.count-3{
            c1 ^= bt[i]
        }
        var re=bt
        re[re.count-2]=c1
        return bytesToHex(re)
    }
    
    public  func bytesToHex(_ bt:[UInt8])->String{
        var re=""
        for i in 0..<bt.count{
            re=re.appending(String(format:"%02X",bt[i]))
        }
        return re
    }
    func getBit(_ by:UInt8)->String{
        var a=""
        a.append(String((by>>7)&0x1))
        a.append(String((by>>6)&0x1))
        a.append(String((by>>5)&0x1))
        a.append(String((by>>4)&0x1))
        a.append(String((by>>3)&0x1))
        a.append(String((by>>2)&0x1))
        a.append(String((by>>1)&0x1))
        a.append(String((by>>0)&0x1))
        return a
    }
    func ReOpen() {
        print("遇時")
        
    }
    func byte2Int(_ array:[UInt8]) -> Int {
        var letue : UInt32 = 0
        let data = NSData(bytes: array, length: array.count)
        data.getBytes(&letue, length: array.count)
        letue = UInt32(bigEndian: letue)
        return Int(letue)
    }
    func  GetPrId()->[SensorData] {
        var array = [SensorData]()
        let replace =
            "0A 10 000E 01 02 LF HEX 00 00 00 00 00 00 00 00 39 F5".replace("HEX", PublicBeans.getHEX())
                .replace(" ", "").replace("LF", PublicBeans.getLfPower())
        Command.sendData(replace)
        let a=Command.timer.zeroing()
        var fal = 1
        while (true) {
            if (Command.rx == GetCrcString("F51C000301000A") ||  Command.rx == GetCrcString("F51C000302000A")) {
                if (fal == 3) {
                    return array
                }
                Command.sendData(replace)
                fal += 1
                JzActivity.getControlInstance.toast("第幾次\(fal)")
            }
            if (Command.timer.stop() > 20 || cancel) {
                if (Command.timer.stop() > 20) {
                    ReOpen()
                }
                return array
            }
            if ( Command.rx.count >= 36) {
                let data = SensorData()
                let idcount = Int( Command.rx.sub(17..<18))
                data.id=( Command.rx.sub(8..<16))
                data.idcount=(idcount!)
                data.bat=getBit( Command.rx.sub(28..<30).HexToByte()![0]).sub(3..<4)
                data.kpa=Float(byte2Int([UInt8](Command.rx.sub(22..<26).HexToByte()!)))
                let bytes = Command.rx.substring(18, 22).HexToByte()
                data.c=Float((Int(bytes![1]) - Int(bytes![0])))
                data.vol=Int((22 + ( Command.rx.substring(26, 28).HexToByte()![0] & 0x0F)))
                data.success=(true)
                array.add(data)
                if (array.size == ScanCount) {
                    return array
                } else {
                    if ( Command.rx.length > 36) {
                        Command.rx =  Command.rx.substring(36)
                    } else {
                        Command.rx = ""
                    }
                }
            }
            usleep(100*1000)
        }
    }
    
    func GetPr(Lf: String, count: Int, hex: String)-> [SensorData] {
        var response = [SensorData]()
        var co = count.toHexString()
        while (co.length < 2) {
            co = "0$co"
        }
        Command.sendData(
            "0A 10 000E 01 00 LF hex 00 00 00 00 count 00 00 00 39 F5".replace(
                " ",
                ""
            ).replace("LF", Lf).replace("count", co).replace("hex", hex)
        )
        Command.timer.zeroing()
        while (true) {
            
            if (Command.timer.stop() > 20 || Command.rx == GetCrcString("F51C000301000A") ||  Command.rx == GetCrcString("F51C000302000A") ) {
                if (Command.timer.stop() > 20) {
                    ReOpen()
                }
                return response
            }
            if (Command.rx.length >= 36) {
                let data = SensorData()
                let idcount = Int(Command.rx.substring(17, 18))
                data.idcount=(idcount!)
                data.id=(Command.rx.substring(8, 16))
                data.bat=(getBit(Rx.substring(28, 30).HexToByte()![0]).substring(3, 4))
                
                data.kpa = Float(byte2Int([UInt8](Rx.substring(22, 26).HexToByte()!)))
                let bytes = StringHexToByte(Rx.substring(18, 22))
                data.c=Float((bytes[1] - bytes[0]))
                data.vol=Int((22 + (StringHexToByte(Rx.substring(26, 28))[0] & 0x0F)))
                data.success=(true)
                response.add(data)
                Command.rx = Command.rx.substring(36)
                if (response.size == count) {
                    return response
                }
            }
            usleep(1000*100)
        }
    }
    //    public static Read
    func GetId()-> SensorData {
        let data = SensorData()
        Command.sendData(
            "0A 10 000E 01 00 LF HEX 00 00 00 00 00 00 00 00 39 F5".replace(
                "HEX",
                PublicBeans.getHEX()
            ).replace(" ", "").replace("LF", PublicBeans.getLfPower())
        )
        Command.timer.zeroing()
        while (true) {
            
            if (Command.timer.stop() > 15 || Rx == GetCrcString("F51C000301000A") || Rx == GetCrcString("F51C000302000A") ) {
                data.success=(false)
                if (Command.timer.stop() > 15) {
                    ReOpen()
                }
                return data
            }
            if (Rx.length >= 36) {
                let idcount = Int(Rx.substring(17, 18))
                data.idcount=(idcount!)
                data.id=(Rx.substring(16 - idcount!, 16))
                //                    data.id=Rx.substring(8, 16);
                data.bat=(getBit(StringHexToByte(Rx.substring(28, 30))[0]).substring(3, 4))
                data.kpa=Float(byte2Int([UInt8](StringHexToByte(Rx.substring(22, 26)))))
                let bytess = Command.rx.substring(18, 22).HexToByte()
                data.c=Float((bytess![1] - bytess![0]))
                data.vol=Int((22 + (StringHexToByte(Rx.substring(26, 28))[0] & 0x0F)))
                data.有無胎溫=(
                    getBit(StringHexToByte(Rx.substring(28, 30))[0]).substring(
                        0,
                        1
                        ) == "1"
                )
                data.有無電壓=(
                    getBit(StringHexToByte(Rx.substring(28, 30))[0]).substring(
                        1,
                        2
                        ) == "1"
                )
                data.有無電池=(
                    getBit(StringHexToByte(Rx.substring(28, 30))[0]).substring(
                        2,
                        3
                        ) == "1"
                )
                data.success=(true)
                return data
            }
            usleep(100*1000)
        }
    }
    
    func SendTrigerInfo(sensor: [String])->Bool {
        for i in 0..<sensor.count {
            var position = (i + 1).toHexString()
            while (position.length < 2) {
                position = "0$position"
            }
            var id = sensor[i]
            while (id.length < 8) {
                id = "0$id"
            }
            Command.sendData(
                "0A 15 00 0E position ID 00 00 00 00 00 00 00 18 F5".replace(
                    "position",
                    position
                ).replace("ID", id).replace(" ", "")
            )
            Command.timer.zeroing()
            while (Rx.length != 36) {
                
                if (Command.timer.stop() > 20 || Rx == GetCrcString("F51C000301000A") || Rx == GetCrcString("F51C000302000A") ) {
                    if (Command.timer.stop() > 20) {
                        ReOpen()
                    }
                    return false
                }
            }
        }
        return true
    }
     var spilt: String=""
    func ProgramFirst(Lf: String, Hex: String, count: String, data: String) -> Bool {
           var Hex = Hex
           var count = count

               while (count.length < 2) {
                   count = "0$count"
               }
               while (Hex.length < 2) {
                   Hex = "0$Hex"
               }
               let B8 = data.substring(14, 16)
               let B9 = data.substring(16, 18)
               let B12 = data.substring(22, 24)
               let B13 = data.substring(24, 26)
               let Data =
                   "0A 10 00 0E  02 CT  Lf Hex 8b 9b 12b 13b 00 00 00 00 ff f5".replace("CT", count)
                       .replace("Lf", Lf).replace("Hex", Hex)
                       .replace("8b", B8).replace("9b", B9).replace("12b", B12).replace("13b", B13)
                       .replace(" ", "")
        Command.sendData(Data)
        Command.timer.zeroing()
               var fal = 1
               while (true) {
                   if (Rx == GetCrcString("F51C000301000A") || Rx == GetCrcString("F51C000302000A")) {
                       if (fal == 3) {
                           return false
                       }
                      Command.sendData(Data)
                       Command.timer.zeroing()
                       fal += 1
                       JzActivity.getControlInstance.toast("第幾次\(fal)")
                   }
                if (Command.timer.stop() > 20 ) {
                           ReOpen()
                       return false
                   }
                   if (Rx.length >= 36) {
                    ScanCount = Int(Rx.substring(9, 10))!
                    if (Rx.substring(10, 12) == "04"){
                        spilt=data.substring(
                        0,
                        2048 * 2)
                    }else{
                        spilt=data.substring(0, 6144 * 2)
                    }
                       
                       return WriteFlash(spilt)
                   }
                   usleep(100*1000)
               }

       }
    
    func WriteFlash(_ data: String)-> Bool {
        var count=0
        if (data.length % 400 == 0) {
            count=data.length / 400
        }else{
            count=data.length / 400 + 1
        }
        for i in 0..<count {
                if (i == count - 1) {
                    Program_Progress!(100)
                    if (!CheckData(data.substring(400 * i), Int(i + 1))) {
                        return false
                    }
                } else {
                    Program_Progress!(i * 100 / count)
                    if (!CheckData(
                            data.substring(400 * i, 400 * i + 400),
                            (i + 1).toHexString()
                        )
                    ) {
                        return false
                    }
                }
            }
            return true

    }
    func CheckData(_ data: String,_ place: String)-> Bool {
        var place = place
            while (place.length < 2) {
                place = "0$place"
            }
        var Long :String{
            get{
                if (data.length == 400) {return "00CB"} else {
                    return  "00" + (data.length / 2 + 3).toHexString()
                }
            }
        }
                
            let command = "0A 13 LONG DATA PLACE FF F5".replace(" ", "").replace("LONG", Long)
                .replace("DATA", data).replace("PLACE", place)
        Command.sendData(command)
        Command.timer.zeroing()
            let fal = 0
            while (true) {
                if (Command.timer.stop() > 6 || Rx == GetCrcString("F51C000301000A") || Rx == GetCrcString("F51C000302000A") ) {
                    if (Command.timer.stop() > 6) {
                       
                        ReOpen()
                    }
                    return false
                }
                if (Rx.length >= 36) {
                    return true
                }
                usleep(100*1000)
            }
    }
    func ProgramCheck(data: String)->Bool {
        Command.sendData("0A 14 00 0E 00 00 00 00 00 00 00 00 00 00 00 00 ff f5".replace(" ", ""))
              var fal = 0
        Command.timer.zeroing()
              while (true) {
                if (Command.timer.stop() > 15 || Rx == GetCrcString("F51C000301000A") || Rx == GetCrcString("F51C000302000A") || fal == 10 ) {
                    if (Command.timer.stop() > 15) {
                          ReOpen()
                      }
                      return false
                  }
                  if (Rx.length >= 36 && Rx.contains("F513000E00")) {
                      val check = Rx.substring(12, 20)
                      if (check == "7FFFFFFF" || check == "000007FF") {
                          return true
                      } else {
                          if (!RePr(getBit(check).substring(1), data)) {
                              return false
                          }
                          past = sdf.parse(sdf.format(Date()))
                          fal++
                      }
                  }
                  usleep(100*1000)
              }
      }

}
