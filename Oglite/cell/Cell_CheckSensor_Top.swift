//
//  Cell_CheckSensor_Top.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/4/7.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit

class Cell_CheckSensor_Top: UITableViewCell {

    @IBOutlet var bat: UILabel!
    @IBOutlet var tem: UILabel!
    @IBOutlet var pre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        tem.text=SensorData.getTem()
        pre.text=SensorData.getPre()
        bat.text="jz.250".getFix().replace(":", "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
