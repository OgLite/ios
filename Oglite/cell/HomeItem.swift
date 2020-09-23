//
//  HomeItem.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/2.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class HomeItem: UICollectionViewCell {
  var pageswitch=[UIViewController]()
    var index=0
    
    @IBOutlet weak var tit: UILabel!
    @IBOutlet weak var ima: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    @IBAction func swit(_ sender: Any) {
        PublicBeans.選擇按鈕=Page_Home.tit[index]
JzActivity.getControlInstance.changePage(pageswitch[index],String(describing: type(of: pageswitch[index])), true)
        
    }
}
