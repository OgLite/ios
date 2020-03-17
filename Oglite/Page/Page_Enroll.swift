//
//  Page_Enroll.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/1/30.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzIos_Framework
class Page_Enroll: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var run=false
    var place=0
    @IBOutlet var picker: UIPickerView!
    var item=["EU","North America","台灣","中國大陸"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return item.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return item[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(place==0){
            country.setTitle(item[pickerView.selectedRow(inComponent: 0)], for: .normal)
            picker.isHidden=true
        }else{
            Distribut.setTitle(item[pickerView.selectedRow(inComponent: 0)], for: .normal)
            picker.isHidden=true
        }
        print(pickerView.selectedRow(inComponent: 0))
        
        
    }
    
    @IBOutlet var StoreL: UILabel!
    @IBOutlet var Distribut: UIButton!
    @IBOutlet var admin: UITextField!
    @IBOutlet var content: UIView!
    @IBOutlet var zpcode: UITextField!
    @IBOutlet var state: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var streat: UITextField!
    @IBOutlet var country: UIButton!
    @IBOutlet var phonenumber: UITextField!
    @IBOutlet var company: UITextField!
    @IBOutlet var lastname: UITextField!
    @IBOutlet var firstname: UITextField!
    @IBOutlet var SN: UITextField!
    @IBOutlet var repeatpassword: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var l2: UILabel!
    @IBOutlet var l17: UILabel!
    @IBOutlet var l16: UILabel!
    @IBOutlet var l15: UILabel!
    @IBOutlet var l14: UILabel!
    @IBOutlet var l13: UILabel!
    @IBOutlet var l12: UILabel!
    @IBOutlet var l11: UILabel!
    @IBOutlet var l10: UILabel!
    @IBOutlet var l9: UILabel!
    @IBOutlet var l8: UILabel!
    @IBOutlet var l7: UILabel!
    @IBOutlet var l6: UILabel!
    @IBOutlet var l5: UILabel!
    @IBOutlet var l4: UILabel!
    @IBOutlet var l3: UILabel!
    @IBOutlet var l1: UILabel!
    @IBOutlet var sin: UIButton!
    @IBOutlet var can: UIButton!
    
    @IBAction func back(_ sender: Any) {
        JzActivity.getControlInstance.goBack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate=self
        picker.dataSource=self
        StoreL.text=("Store_type").Mt()
        l1.text=("Create_your_email_account").Mt()
        l2.text=("E_mail").Mt()
        l3.text=("Password").Mt()
        l4.text=("Choose_a_password").Mt()
        l5.text=("Repeat_password").Mt()
        l6.text=("Product_serial_number").Mt()
        l7.text=("personal_details").Mt()
        l8.text=("First_Name").Mt()
        l9.text=("Last_Name").Mt()
        l10.text=("Company").Mt()
        l11.text=("Contact_Phone_Number").Mt()
        l12.text=("Physical_address_Mailing_address").Mt()
        l13.text=("Country").Mt()
        l14.text=("Street").Mt()
        l15.text=("City").Mt()
        l16.text=("State").Mt()
        l17.text=("ZP_Code").Mt()
        let pan = UITapGestureRecognizer(
            target:self,
            action:#selector(tap))
        view.addGestureRecognizer(pan)
    }
    @objc func tap(){
        picker.isHidden=true
    }
    override func viewDidAppear(_ animated: Bool) {
        can.setTitle(("cancel".Mt()), for: .normal)
        sin.setTitle(("Sign_in".Mt()), for: .normal)
    }
    
    @IBAction func selectcon(_ sender: Any) {
        place=0
        item=["EU","North America","台灣","中國大陸"]
        picker.reloadAllComponents()
        picker.isHidden=false
    }
    
    
    @IBAction func next(_ sender: Any) {
        if(run){return}
        let email=admin.text!
        let pass=password.text!
        let repeatpass=repeatpassword.text!
        let sn=SN.text!
        let fname=firstname.text!
        let lname=lastname.text!
        let com=company.text!
        let ph=phonenumber.text!
        let str=streat.text!
        let ct=city.text!
        let state=country.titleLabel!.text!
        let zpcod=zpcode.text!
        if(email.count==0||sn.count==0||fname.count==0||lname.count==0||com.count==0||ph.count==0||str.count==0||ct.count==0||state.count==0||zpcod.count==0){JzActivity.getControlInstance.openDiaLog(Register_error(),false,"Register_error")
            return
        }
        if(pass.count<8){
            view.showToast(text: ("Password".Mt())+("At_least_8_characters").Mt())
            return
        }
        if(pass != repeatpass){
            view.showToast(text: "confirm_password".Mt())
            return
        }
        run=true
        let a=Progress()
        a.label=a.資料載入
        JzActivity.getControlInstance.openDiaLog(a,true,"Progress")
        if(Distribut.titleLabel!.text==("Distributor")){
            Cloud.Register(email,pass,sn,"Distributor",com,fname,lname,ph,state,ct,str,zpcod, {
                a in
                self.run=false
                switch(a){
                case 0:
                    JzActivity.getControlInstance.setPro("admin", email)
                    JzActivity.getControlInstance.setPro("password", pass)
                    JzActivity.getControlInstance.setHome(Page_Home(), "Page_Home")
                    break
                case 1:
                JzActivity.getControlInstance.toast("be_register".Mt())
                    break
                case -1:
                    JzActivity.getControlInstance.toast("nointer".Mt())
                    break
                default:
                    break
                }
                JzActivity.getControlInstance.closeDialLog()
            })
        }else{
            Cloud.Register(email,pass,sn,"Retailer",com,fname,lname,ph,state,ct,str,zpcod, {
                a in
                self.run=false
                  switch(a){
                             case 0:
                                 JzActivity.getControlInstance.setPro("admin", email)
                                 JzActivity.getControlInstance.setPro("password", pass)
                             JzActivity.getControlInstance.setHome(Page_Home(), "Page_Home")
                                 break
                             case 1:
                             JzActivity.getControlInstance.toast("be_register".Mt())
                                 break
                             case -1:
                             JzActivity.getControlInstance.toast("nointer".Mt())
                                 break
                             default:
                                 break
                             }
                JzActivity.getControlInstance.closeDialLog()
            })
        }
        
    }
    
    @IBAction func SelectStore(_ sender: Any) {
        place=1
        item=[("Distributor"),("Retailer")]
        picker.reloadAllComponents()
        picker.isHidden=false
    }
    
}
