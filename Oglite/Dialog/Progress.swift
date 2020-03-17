//
//  Progress.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/30.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import Lottie
class Progress: UIViewController {
    var 登入中="Sign_in".Mt()
    var 資料載入="Data_Loading".Mt()
    var 連線BLE="paired with your device".Mt()
    var label=""
    @IBOutlet weak var tit: UILabel!
    let animationView = AnimationView(name: "simple-loader2")
    override func viewDidLoad() {
        super.viewDidLoad()
        print("label\(label)")
        tit.text=label
    }
    override func viewDidAppear(_ animated: Bool) {
        animationView.frame.size = CGSize(width: 200, height: 200)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode=LottieLoopMode.loop
        view.addSubview(animationView)
        animationView.play()
    }
    
    
    
}
