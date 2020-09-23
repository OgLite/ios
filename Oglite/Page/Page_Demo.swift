//
//  Page_Demo.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/15.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import AVFoundation
import JzOsFrameWork
class Page_Demo: UIViewController {
    
    @IBOutlet var container: UIView!
    var player : AVPlayer?
       private lazy var layer : AVPlayerLayer = {
           self.player = AVPlayer(url: Bundle.main.url(forResource: "demopro", withExtension: "mov")!)
           let layer = AVPlayerLayer(player: self.player)
           return layer
       }()
    
    override func viewDidAppear(_ animated: Bool) {
        container.layer.addSublayer(self.layer)
        layer.frame = container.bounds
        player?.play()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    @IBAction func close(_ sender: Any) {
        JzActivity.getControlInstance.closeDialLog("Page_Demo")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}
