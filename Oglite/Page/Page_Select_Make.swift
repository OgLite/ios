//
//  Page_Select_Make.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsSqlHelper
import JzOsAdapter
import JzOsFrameWork
class Page_Select_Make: UIViewController {
    lazy var item=PublicBeans.getMake()
    @IBOutlet var maketit: UILabel!
    @IBOutlet weak var tb: UITableView!
    lazy var adapter=GridAdapter(tb: tb, width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3, count: {return self.item.make.count}, spilt: 3, nib: "Cell_Make", getcell: {
        a,b,c in
        let cell=a.dequeueReusableCell(withReuseIdentifier: "Cell_Make", for: b) as! Cell_Make
        cell.selectmake=self.item.make[c]
        cell.carbt.setImage(UIImage(named: self.item.makeing[c]), for: .normal)
        return cell
    })
    override func viewDidLoad() {
        super.viewDidLoad()
        print("init")
        tb.separatorStyle = .none
        adapter.notifyDataSetChange()
    }
    override func viewWillAppear(_ animated: Bool) {
        maketit.text="jz.123".getFix()
    }
    @IBAction func goMenu(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
    
}
