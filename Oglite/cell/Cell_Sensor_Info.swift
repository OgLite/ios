//
//  Cell_Sensor_Info.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/4/7.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit

class Cell_Sensor_Info: UITableViewCell {
    @IBOutlet var position: UILabel!
    @IBOutlet var bat: UILabel!
    @IBOutlet var c: UILabel!
    @IBOutlet var psi: UILabel!
    @IBOutlet var id: UILabel!
    @IBOutlet var stack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
