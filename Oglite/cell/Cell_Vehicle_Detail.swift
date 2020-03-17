//
//  Cell_Vehicle_Detail.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsTool
class Cell_Vehicle_Detail: UITableViewCell {
    
    @IBOutlet var nonewid: UIImageView!
    @IBOutlet var novid: UIImageView!
    @IBOutlet var im: UIImageView!
    @IBOutlet var container: UIView!
    @IBOutlet var t4: UILabel!
    @IBOutlet var t3: JzTextField!
    @IBOutlet var t2: JzTextField!
    @IBOutlet var t1: UILabel!
    @IBOutlet var v4: UIView!
    @IBOutlet var v3: UIView!
    @IBOutlet var v2: UIView!
    @IBOutlet var v1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    public static func loadtit(_ table:UITableView)->Cell_Vehicle_Detail{
        let cell=table.dequeueReusableCell(withIdentifier: "Cell_Vehicle_Detail") as! Cell_Vehicle_Detail
        cell.t1.text="WH"
        cell.t2.text="Vehice ID"
        cell.t3.text="New ID"
        cell.t4.text="Check"
        cell.v1.backgroundColor=UIColor(named: "vhcolor")
        cell.v2.backgroundColor=UIColor(named: "vhcolor")
        cell.v3.backgroundColor=UIColor(named: "vhcolor")
        cell.v4.backgroundColor=UIColor(named: "vhcolor")
        cell.container.heightAnchor.constraint(equalToConstant: 40).isActive=true
        cell.im.isHidden=true
        cell.novid.isHidden=true
        cell.nonewid.isHidden=true
        cell.t3.isUserInteractionEnabled=false
        cell.t2.isUserInteractionEnabled=false
        return cell
    }
    public static func obd(_ table:UITableView,_ model:[Md_Idcopy],_ c:Int,_ needposition:Bool)->Cell_Vehicle_Detail{
        let cell=table.dequeueReusableCell(withIdentifier: "Cell_Vehicle_Detail") as! Cell_Vehicle_Detail
        cell.t3.isEnabled=model[c-2].readable && !needposition
        cell.t2.isEnabled=model[c-2].readable && !needposition
        if(!needposition && !model[c-2].readable && PublicBeans.選擇按鈕==Page_Home.tit[1]){
            model[c-2].newid=model[c-2].vid
        }
        if(model[c-2].condition==Md_Idcopy.燒錄成功){
            cell.t3.textColor = .black
            cell.t2.textColor = .black
        }else{
            if(PublicBeans.選擇按鈕==Page_Home.tit[1]){
                cell.t2.textColor = .orange
                cell.t3.textColor = .black
            }else{
                cell.t2.textColor = .black
                cell.t3.textColor = .orange
            }
        }
        cell.t1.text=model[c-2].wh
        cell.t2.text=model[c-2].vid.uppercased()
        cell.t3.text=model[c-2].newid.uppercased()
        cell.t4.text=""
        cell.t1.textColor=UIColor.white
        cell.t4.textColor=UIColor.black
        cell.v1.backgroundColor=UIColor(named: "vhcolor")
        cell.novid.isHidden=true
        cell.nonewid.isHidden=true
        cell.t3.textCount=8
        cell.t3.digits="abcdefABCDEF0123456789"
        cell.t2.textCount=8
        cell.t2.digits="abcdefABCDEF0123456789"
        
        if(!needposition && !model[c-2].readable && PublicBeans.選擇按鈕==Page_Home.tit[0]){
            cell.nonewid.isHidden=false
            if(PublicBeans.選擇按鈕==Page_Home.tit[3]){cell.novid.isHidden=false}
        }else{
            if(model[c-2].readable&&model[c-2].newid.isEmpty){
                cell.v3.backgroundColor = UIColor(named: "boldgreen")
            }else{
                cell.v3.backgroundColor = .white
            }
        }
        if(PublicBeans.選擇按鈕==Page_Home.tit[3]){
            if(model[c-2].readable&&model[c-2].vid.isEmpty){
                cell.v2.backgroundColor = UIColor(named: "boldgreen")
            }else{cell.v2.backgroundColor = .white}
            if(!model[c-2].readable && !needposition){
                cell.novid.isHidden=false
                cell.nonewid.isHidden=false
            }
        }
        cell.v4.backgroundColor = .white
        if(PublicBeans.selectway==PublicBeans.KetIn){
            cell.t3.isUserInteractionEnabled=true
            cell.t2.isUserInteractionEnabled=true
        }else{
            cell.t3.isUserInteractionEnabled=false
            cell.t2.isUserInteractionEnabled=false
        }
        cell.container.heightAnchor.constraint(equalToConstant: 56).isActive=true
        switch model[c-2].condition {
        case Md_Idcopy.尚未燒錄:
            cell.im.isHidden=true
            break
        case Md_Idcopy.燒錄成功:
            cell.im.isHidden=false
            cell.im.image=UIImage(named: "icon_check sensor_OK")
            break
        case Md_Idcopy.燒錄失敗:
            cell.im.isHidden=false
            cell.im.image=UIImage(named: "icon_check sensor_fail")
            break
        default:
            break
        }
        
        return cell
    }
}
