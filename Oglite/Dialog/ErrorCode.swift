//
//  Error.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/4.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class ErrorCode: UIViewController {

    @IBOutlet weak var lab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    lab.text="jz.122".getFix()
        let tapa = UITapGestureRecognizer(target: self, action: #selector(tap))
                  view.addGestureRecognizer(tapa)
    }
    @objc func tap(){
        JzActivity.getControlInstance.removeController(self)
    }

}
