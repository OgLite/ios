//
//  DataLoading.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/30.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import Lottie
import JzIos_Framework
class DataLoading: UIViewController {
    var 沒有網路="nointer".Mt()
    var 檢查更新="Check for updates".Mt()
    var 傳送信件="Go_email".Mt()
    
    var label=""
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var tit: UILabel!
    let animationView = AnimationView(name: "simple-loader2")
    override func viewDidLoad() {
        super.viewDidLoad()
        if(label==沒有網路){
            animationView.isHidden=true
            img.image=UIImage(named: "img_connection_failed")
            let pan=UITapGestureRecognizer(target: self, action: #selector(tap))
                       view.addGestureRecognizer(pan)
        }else if(label==檢查更新){
            animationView.isHidden=false
            img.image=UIImage(named: "img_data_upload_and_loading")
        }else if(label == 傳送信件){
            animationView.isHidden=true
            img.image=UIImage(named: "img_email")
            let pan=UITapGestureRecognizer(target: self, action: #selector(tap))
            view.addGestureRecognizer(pan)
        }
        tit.text=label
        
    }
    @objc func tap(){
          JzActivity.getControlInstance.closeDialLog()
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
