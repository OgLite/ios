//
//  Cell_DataSelect.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
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
            if(actionpage is Dia_Reset){
                JzActivity.getControlInstance.openDiaLog(Dia_Reset(), false, "Dia_Reset")
            }else if(actionpage is Dia_Logout){
                 JzActivity.getControlInstance.openDiaLog(Dia_Logout(), false, "Dia_Logout")
            }else{
                JzActivity.getControlInstance.changePage(actionpage, String(describing: type(of: actionpage)), true)
            }

    }
    
}
