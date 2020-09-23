//
//  Cell_Vehicle_Detail.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsTool
class Cell_Vehicle_Detail: UITableViewCell,UITextFieldDelegate{
    var scan1={}
    var scan2={}
    var thisPosition = -1
    var pa=Page_Idcopy_obd()
    public static var lastClick:UITextField?=nil
    @IBOutlet var scanb2: UIButton!
    @IBOutlet var scanb: UIButton!
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
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection")
    }
     func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        if(textField == t2){
            pa.clickPosition=thisPosition
        }else{
            pa.clickPosition=thisPosition+1
        }
        if(Cell_Vehicle_Detail.lastClick != textField){pa.adapter.notifyDataSetChange()
             }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    public static func loadtit(_ table:UITableView)->Cell_Vehicle_Detail{
        let cell=table.dequeueReusableCell(withIdentifier: "Cell_Vehicle_Detail") as! Cell_Vehicle_Detail
        cell.t1.text=""
        cell.t2.text="jz.417".getFix()
        cell.t3.text="jz.418".getFix()
        cell.t4.text="jz.303".getFix()
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
    public static func obd(_ table:UITableView,_ model:[Md_Idcopy],_ c:Int,_ pa:Page_Idcopy_obd)->Cell_Vehicle_Detail{
        let cell=table.dequeueReusableCell(withIdentifier: "Cell_Vehicle_Detail") as! Cell_Vehicle_Detail
        cell.pa=pa
        cell.thisPosition=(c-2)*2
        cell.t2.textColor=UIColor.black
        cell.t3.textColor=UIColor.black
        cell.t2.backgroundColor=UIColor.white
        cell.t3.backgroundColor=UIColor.white
        cell.t2.delegate=cell
        cell.t3.delegate=cell
        if(PublicBeans.selectway==PublicBeans.Scan&&c>=2){
            cell.scanb.isHidden=false
            cell.scanb2.isHidden=false
            cell.scan1={
                PublicBeans.getId({
                    a in
                    model[c-2].vid=a
                    table.reloadData()
                })
            }
            cell.scan2={
                PublicBeans.getId({
                    a in
                    model[c-2].vid=a
                    table.reloadData()
                })
            }
            
        }else if(PublicBeans.selectway==PublicBeans.Trigger&&c>=2){
            cell.scanb.isHidden=false
            cell.scanb2.isHidden=false
            cell.scan1={
                if(pa.clickPosition==(c-2)*2){
                    pa.clickPosition = -1
                    pa.adapter.notifyDataSetChange()
                    return
                }
                pa.clickPosition=(c-2)*2
                pa.adapter.notifyDataSetChange()
            }
            cell.scan2={
                if(pa.clickPosition==(c-2)*2+1){
                    pa.clickPosition = -1
                    pa.adapter.notifyDataSetChange()
                    return
                }
                pa.clickPosition=(c-2)*2+1
                pa.adapter.notifyDataSetChange()
            }
        }else{
            cell.scanb.isHidden=true
            cell.scanb2.isHidden=true
            
        }
        if(model[c-2].condition==Md_Idcopy.燒錄成功){
            cell.t3.textColor = .black
            cell.t2.textColor = .black
        }else{
            if(PublicBeans.選擇按鈕 == "jz.15".getFix()){
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
        
        if( !model[c-2].readable){
            if(model[c-2].newid.isEmpty){cell.nonewid.isHidden=false}else{
                cell.nonewid.isHidden=true
            }
            if(model[c-2].vid.isEmpty){cell.novid.isHidden=false}else{
                cell.novid.isHidden=true
            }
        }else{
            cell.nonewid.isHidden=true
            cell.novid.isHidden=true
            cell.v3.backgroundColor = .white
        }
        if(PublicBeans.選擇按鈕 == "jz.15".getFix()){
            if(model[c-2].vid.isEmpty){
                cell.novid.isHidden=false
            }else{
                cell.novid.isHidden=true
            }  
        }
        cell.v4.backgroundColor = .white
        if(PublicBeans.selectway==PublicBeans.KetIn||PublicBeans.selectway==PublicBeans.Trigger){
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
        if(!model[c-2].readable){
            cell.im.isHidden=true
        }
        if(PublicBeans.選擇按鈕 == "jz.15".getFix() && !model[c-2].readable){
            cell.nonewid.isHidden=false
            cell.t3.text=""
        }
        if(pa.clickPosition==(c-2)*2){
            cell.t2.textColor=UIColor.white
            cell.t2.backgroundColor=UIColor(named: "boldgreen")
        }
        if(pa.clickPosition==(c-2)*2+1){
            cell.t3.textColor=UIColor.white
            cell.t3.backgroundColor=UIColor(named: "boldgreen")
        }
        return cell
    }
    
    @IBAction func scan1(_ sender: Any) {
        scan1()
    }
    
    @IBAction func scan2(_ sender: Any) {
        scan2()
    }
}
