//
//  Cell_Select_VC_TOP.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/4/7.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit

class Cell_Select_VC_TOP: UITableViewCell {

    @IBOutlet var tit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tit.text="jz.121".getFix()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
