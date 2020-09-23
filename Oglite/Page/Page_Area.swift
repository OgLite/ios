//
//  Page_Area.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/29.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsFrameWork
import JzOsMultiLanugage
class Page_Area: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet var lan: UILabel!
    @IBOutlet  var areabt: UIButton!
    @IBOutlet  var languagebt: UIButton!
    @IBOutlet  var area: UILabel!
    @IBOutlet  var setupbt: UIButton!
    var lastArea = JzActivity.getControlInstance.getPro("Area","EU")
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
            let area=["EU","US","TW","TW"][pickerView.selectedRow(inComponent: 0)]
            if(JzActivity.getControlInstance.getPro("Area", "nodata") != area){
                SharePre.mmyVersion = "nodata"
                JzActivity.getControlInstance.setPro("Area",area)
            }
            viewDidLoad()
        }else{
            languagebt.setTitle(item[pickerView.selectedRow(inComponent: 0)], for: .normal)
            switch item[pickerView.selectedRow(inComponent: 0)] {
            case "English":
                SharePre.setLan="en"
            case "繁體中文":
                SharePre.setLan="tw"
            case "简体中文":
                SharePre.setLan="zh-rcn"
            case "Deutsch":
                SharePre.setLan="de"
            case "Italiano":
                SharePre.setLan="it"
            case "Dansk":
                SharePre.setLan="da"
            case "Slovinčina":
                SharePre.setLan="sk"
            default:
                break
            }
            viewDidLoad()
        }
        picker.removeFromSuperview()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pan = UITapGestureRecognizer(target:self,action:#selector(tap))
        view.addGestureRecognizer(pan)
        area.text="jz.66".getFix()
        lan.text="jz.69".getFix()
        setupbt.setTitle("jz.192".getFix(), for: .normal)
        areabt.setTitle(JzActivity.getControlInstance.getPro("Area","EU"), for: .normal)
        switch SharePre.setLan {
        case "en":
            languagebt.setTitle("English", for: .normal)
        case "tw":
            languagebt.setTitle("繁體中文", for: .normal)
        case "zh-rcn":
            languagebt.setTitle("简体中文", for: .normal)
        case "de":
            languagebt.setTitle("Deutsch", for: .normal)
        case "it":
            languagebt.setTitle("Italiano", for: .normal)
        case "da":
            languagebt.setTitle("Dansk", for: .normal)
        case "sk":
            languagebt.setTitle("Slovinčina", for: .normal)
        default:
            break
        }
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
    
    @IBAction func selectlan(_ sender: Any) {item=["繁體中文","简体中文","Deutsch","English","Italiano","Dansk","Slovinčina"]
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
            if(JzActivity.getControlInstance.getPro("Area","EU") != lastArea){
                FileJsonVersion().storeLocal()
            }
            JzActivity.getControlInstance.goMenu()
        }else{
            let a=JzActivity.getControlInstance.getNewController("Main", "Page_Policy")
            JzActivity.getControlInstance.changePage(a, "Page_Policy", true)
        }
        
    }
}
