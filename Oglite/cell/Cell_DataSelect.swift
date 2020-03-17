//
//  Cell_DataSelect.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
class Cell_DataSelect: UITableViewCell {
    @IBOutlet weak var cont: UIView!
    @IBOutlet weak var tit: UILabel!
    @IBOutlet weak var ima: UIImageView!
    var actionpage = UIViewController()
    var act=JzActivity.getControlInstance.getActivity() as! ViewController
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func change(_ sender: Any) {
        if(act.helper.isPaired()||JzActivity.getControlInstance.getNowPageTag() != "Page_Vehicle_Select"){
            JzActivity.getControlInstance.changePage(actionpage, String(describing: type(of: actionpage)), true)
        }else{
            if(act.helper.isOpen()){
                act.helper.startScan()
                           JzActivity.getControlInstance.openDiaLog(Select_Ble(), false, "Select_Ble")
            }else{
                JzActivity.getControlInstance.toast("openble".Mt())
            }
           
        }

    }
    
}
