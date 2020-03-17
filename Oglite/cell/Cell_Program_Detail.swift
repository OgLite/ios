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
    
    @IBOutlet var checktext: UILabel!
    @IBOutlet var position: UILabel!
    @IBOutlet var checkicon: UIImageView!
    @IBOutlet var checkview: UIView!
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
                cell.idnumber.text="Sensor ID number"
                cell.idnumber.isUserInteractionEnabled=false
                cell.checkview.backgroundColor = UIColor(named: "vhcolor")
                cell.checkicon.isHidden=true
                cell.position.text="WH"
                cell.checktext.isHidden=false
             }else{
                  cell.contentview.heightAnchor.constraint(equalToConstant: 72).isActive=true
                cell.idnumber.backgroundColor = UIColor.white
                cell.idnumber.textColor = UIColor.black
                cell.idnumber.isUserInteractionEnabled=true
                cell.idnumber.digits="1234567890abcdefABCDEF"
                cell.idnumber.textCount=8
                cell.idnumber.text=model[c-1].id
                cell.checkview.backgroundColor = UIColor.white
                switch model[c-1].result {
                case .尚未燒錄:
                    cell.checkicon.isHidden=true
                    cell.idnumber.textColor = .orange
                    break
                case .燒錄失敗:
                    cell.checkicon.isHidden=false
                    cell.checkicon.image=UIImage(named: "icon_check sensor_fail")
                    cell.idnumber.textColor = .orange
                    break
                case .燒錄成功:
                    cell.checkicon.isHidden=false
                    cell.checkicon.image=UIImage(named: "icon_check sensor_OK")
                    cell.idnumber.textColor = .black
                    break
                default:
                    break
                }
                cell.position.text="\(c)"
                cell.checktext.isHidden=true
               
             }
        if(PublicBeans.selectway==PublicBeans.KetIn){
            cell.idnumber.isUserInteractionEnabled=true
        }else{
            cell.idnumber.isUserInteractionEnabled=false
        }
            return cell
    }
    
}
