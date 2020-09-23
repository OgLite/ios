//
//  Page_Select_Wheel.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/4/8.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
class Page_Select_Wheel: UIViewController {
    
    @IBOutlet var allb: UIButton!
    @IBOutlet var tit: UILabel!
    @IBOutlet var allsp: UIStackView!
    @IBOutlet var car: UIImageView!
    @IBOutlet var spareb: UIButton!
    @IBOutlet var lrb: UIButton!
    @IBOutlet var rrb: UIButton!
    @IBOutlet var rfb: UIButton!
    @IBOutlet var lfb: UIButton!
    
    @IBOutlet var sp: UIView!
    @IBOutlet var spt: UIButton!
    var click=[Bool]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if(PublicBeans.getWheelCount() == 4){
            sp.isHidden=false
            allsp.isHidden=true
            car.image=UIImage(named: "img_car+4 tire")
        }else{
            car.image=UIImage(named: "img_car+5 tire")
            sp.isHidden=true
            allsp.isHidden=false
        }
        tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)/\(PublicBeans.Year)"
        for i in 0..<PublicBeans.getWheelCount(){
            click.append(true)
        }
        updateUi()
    }
    
    @IBAction func lfc(_ sender: Any) {
        click[0] = !click[0]
        updateUi()
    }
    var lastMax=false
    func updateUi(){
        if((click.filter({$0==true}).count == click.size) && lastMax){
            click=click.map({$0&&false})
        }
        if(click[0] && click[1] && click[2] && click[3] && ((PublicBeans.getWheelCount()==5) ? click[4]:true)){
            lastMax=true
            lfb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
            spareb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
            rfb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
            lrb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
            rrb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
        }else{
            lastMax=false
            if(click[0]){
                lfb.setBackgroundImage(UIImage(named: "icon_tire_normal"), for: .normal)
            }else{
                lfb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
            }
            if(click.size==5){
                if(click[4]){
                    spareb.setBackgroundImage(UIImage(named: "icon_tire_normal"), for: .normal)
                }else{
                    spareb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
                }
            }
            
            if(click[1]){
                rfb.setBackgroundImage(UIImage(named: "icon_tire_normal"), for: .normal)
            }else{
                rfb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
            }
            if(click[2]){
                rrb.setBackgroundImage(UIImage(named: "icon_tire_normal"), for: .normal)
            }else{
                rrb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
            }
            if(click[3]){
                lrb.setBackgroundImage(UIImage(named: "icon_tire_normal"), for: .normal)
            }else{
                lrb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
            }
            allb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
        }
        if((click.filter({$0==true}).count == click.size)){
            allb.setBackgroundImage(UIImage(named: "icon_tire_normal"), for: .normal)
        }else{
            allb.setBackgroundImage(UIImage(named: "icon_tire_cancel"), for: .normal)
        }
    }
    
    @IBAction func spc(_ sender: Any) {
        click[4] = !click[4]
        updateUi()
    }
    @IBAction func rfc(_ sender: Any) {
        click[1] = !click[1]
        updateUi()
    }
    
    @IBAction func rrc(_ sender: Any) {
        click[2] = !click[2]
        updateUi()
    }
    @IBAction func lrc(_ sender: Any) {
        click[3] = !click[3]
        updateUi()
    }
    @IBAction func selectall(_ sender: Any) {
        if(!click.contains(false)){
            for i in 0..<PublicBeans.getWheelCount(){
                click[i]=false
            }
        }else{
            for i in 0..<PublicBeans.getWheelCount(){
                click[i]=true
            }
        }
        updateUi()
    }
    
    @IBAction func gomenu(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
    @IBAction func next(_ sender: Any) {
        if(!click.contains(true)){
            JzActivity.getControlInstance.toast("jz.413".getFix())
            return
        }
        PublicBeans.copyPosition=click
        switch PublicBeans.選擇按鈕 {
        case "jz.401".getFix():
            let page=Page_Idcopy_obd()
            JzActivity.getControlInstance.changePage(page, "idcopyobd", true)
            break
        case "jz.15".getFix():
            let page=Page_Idcopy_obd()
            JzActivity.getControlInstance.changePage(page, "app_home_obdii_relearn", true)
            break
        case "jz.117".getFix():
            let page=Page_Idcopy_obd()
            JzActivity.getControlInstance.changePage(page, "ID_COPY", true)
            break
        case "jz.28".getFix():
            JzActivity.getControlInstance.changePage(Page_Program(), "Program", true)
            break
        default:
            break
        }
    }
    
}
