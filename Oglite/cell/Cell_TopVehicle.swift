//
//  Cell_TopVehicle.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/12.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit

class Cell_TopVehicle: UITableViewCell {

    @IBOutlet var LR: UIButton!
    @IBOutlet var RR: UIButton!
    @IBOutlet var RF: UIButton!
    @IBOutlet var LF: UIButton!
    var model=[Md_Idcopy]()
    var needposition=true
    var readable=[false,false,false,false,false]
    @IBOutlet var contentview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func updaueUI(){
      let btarray=[LF,RF,RR,LR]
        for i in 0..<model.count{
            switch model[i].condition {
            case Md_Idcopy.尚未燒錄:
                if(model[i].readable){
                   btarray[i]!.setBackgroundImage(UIImage(named: "icon_tire_normal"), for: .normal)
                }else{
                    btarray[i]!.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
                }
                break
            case Md_Idcopy.燒錄失敗:
                 btarray[i]!.setBackgroundImage(UIImage(named: "icon_tire_fail"), for: .normal)
                break
            case Md_Idcopy.燒錄成功:
                 btarray[i]!.setBackgroundImage(UIImage(named: "icon_tire_ok"), for: .normal)
                break
            default:
                break
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
      
    }
    
}
