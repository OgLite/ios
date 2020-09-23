//
//  Cell_Program_Detail.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/24.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//
import JzOsTool
import UIKit
class Cell_Program_Detail: UITableViewCell {
    @IBOutlet var contentview: UIView!
    @IBOutlet var bat: UILabel!
    @IBOutlet var c: UILabel!
    @IBOutlet var kpa: UILabel!
    @IBOutlet var ckview: UIView!
    @IBOutlet var position: UILabel!
    @IBOutlet var checkicon: UIImageView!
    @IBOutlet var idnumber: JzTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func getcell(_ a:UITableView,_ c:Int,_ model:[Md_Program])->Cell_Program_Detail{
        let cell=a.dequeueReusableCell(withIdentifier: "Cell_Program_Detail") as! Cell_Program_Detail
        if(c==0){
            cell.contentview.heightAnchor.constraint(equalToConstant: 48).isActive=true
            cell.idnumber.backgroundColor = UIColor(named: "vhcolor")
            cell.idnumber.textColor = UIColor.white
            cell.idnumber.text=" ID "
            cell.idnumber.isUserInteractionEnabled=false
            cell.checkicon.isHidden=true
            cell.position.text=""
            cell.ckview.isHidden=true
            cell.kpa.text="jz.379".getFix()
            cell.c.text="jz.375".getFix()
            cell.bat.text="jz.318".getFix()
            cell.kpa.backgroundColor = UIColor(named: "vhcolor")
            cell.c.backgroundColor = UIColor(named: "vhcolor")
            cell.bat.backgroundColor = UIColor(named: "vhcolor")
        }else{
            cell.kpa.backgroundColor = UIColor.white
            cell.c.backgroundColor = UIColor.white
            cell.bat.backgroundColor = UIColor.white
            cell.kpa.textColor=UIColor.black
            cell.bat.textColor=UIColor.black
            cell.c.textColor=UIColor.black
            if(!model[c-1].id.isEmpty && model[c-1].result == .燒錄成功){
                cell.kpa.text=model[c-1].sensordata.getKpa()
                cell.c.text=model[c-1].sensordata.getC()
                cell.bat.text=model[c-1].sensordata.getBat()
            }else{
                cell.kpa.text=""
                cell.c.text=""
                cell.bat.text=""
            }
            cell.contentview.heightAnchor.constraint(equalToConstant: 60).isActive=true
            cell.idnumber.backgroundColor = UIColor.white
            cell.idnumber.textColor = UIColor.black
            cell.idnumber.isUserInteractionEnabled=true
            cell.idnumber.digits="1234567890abcdefABCDEF"
            cell.idnumber.textCount=8
            cell.idnumber.text=model[c-1].id
            switch model[c-1].result {
            case .尚未燒錄:
                cell.ckview.isHidden=true
                cell.idnumber.textColor = .orange
                break
            case .燒錄失敗:
                cell.ckview.isHidden=false
                cell.checkicon.image=UIImage(named: "icon_check sensor_fail")
                cell.idnumber.textColor = .orange
                break
            case .燒錄成功:
                cell.ckview.isHidden=false
                cell.checkicon.image=UIImage(named: "icon_check sensor_OK")
                cell.idnumber.textColor = .black
                break
            default:
                break
            }
            cell.position.text="\(c)"
        }
        if(PublicBeans.selectway==PublicBeans.KetIn){
            cell.idnumber.isUserInteractionEnabled=true
        }else{
            cell.idnumber.isUserInteractionEnabled=false
        }
        return cell
    }
    
}
