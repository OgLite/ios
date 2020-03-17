//
//  Page_Area.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/29.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
class Page_Area: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet var info: UILabel!
    @IBOutlet var lan: UILabel!
    @IBOutlet  var togive: UILabel!
    @IBOutlet  var areabt: UIButton!
    @IBOutlet  var languagebt: UIButton!
    @IBOutlet  var area: UILabel!
    @IBOutlet  var setupbt: UIButton!
    var place=0
    var Setting=false
    var item=["EU","North America","台灣","中國大陸"]
    var picker=UIPickerView()
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return item.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("data")
        return item[row]
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerView.selectedRow(inComponent: 0))
        if(place==0){
            areabt.setTitle(item[pickerView.selectedRow(inComponent: 0)], for: .normal)
            JzActivity.getControlInstance.setPro("Area",item[pickerView.selectedRow(inComponent: 0)])
            viewDidLoad()
            if(Setting){DonloadFile.dataloading()}
        }else{
            languagebt.setTitle(item[pickerView.selectedRow(inComponent: 0)], for: .normal)
            JzActivity.getControlInstance.setPro("lan",item[pickerView.selectedRow(inComponent: 0)])
            viewDidLoad()
        }
        picker.removeFromSuperview()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pan = UITapGestureRecognizer(target:self,action:#selector(tap))
        view.addGestureRecognizer(pan)
        area.text="Area".Mt()
        togive.text="to_give".Mt()
        lan.text="Languages".Mt()
        info.text="Languages_info".Mt()
        setupbt.setTitle("Set_up".Mt(), for: .normal)
        languagebt.setTitle(JzActivity.getControlInstance.getPro("lan","English"), for: .normal)
        areabt.setTitle(JzActivity.getControlInstance.getPro("Area","EU"), for: .normal)
    }
    @objc func tap(){
        print("click")
        picker.removeFromSuperview()
    }
    @IBAction func selectarea(_ sender: Any) {
        item=["EU","North America","台灣","中國大陸"]
        place=0
        picker.backgroundColor = UIColor(named: "gray")
        picker.frame=CGRect(x: 0,y: view.frame.maxY-200,width: view.frame.width,height: 200)
        view.addSubview(picker)
        picker.didMoveToSuperview()
        picker.delegate = self as UIPickerViewDelegate
        picker.dataSource = self as UIPickerViewDataSource
        picker.reloadAllComponents()
    }
    
    @IBAction func selectlan(_ sender: Any) {
        item=["繁體中文","简体中文","Deutsch","English","Italiano","Dansk"]
        place=1
        picker.backgroundColor = UIColor(named: "gray")
        picker.frame=CGRect(x: 0,y: view.frame.maxY-200,width: view.frame.width,height: 200)
        view.addSubview(picker)
        picker.didMoveToSuperview()
        picker.delegate = self as UIPickerViewDelegate
        picker.dataSource = self as UIPickerViewDataSource
        picker.reloadAllComponents()
    }
    
    @IBAction func next(_ sender: Any) {
        if(Setting){
            JzActivity.getControlInstance.goMenu()
        }else{
            let a=JzActivity.getControlInstance.getNewController("Main", "Page_Policy")
            JzActivity.getControlInstance.changePage(a, "Page_Policy", true)
        }
       
    }
}
