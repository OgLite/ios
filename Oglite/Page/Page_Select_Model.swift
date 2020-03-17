//
//  Page_Select_Model.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzAdapter
class Page_Select_Model: UIViewController {

    @IBOutlet weak var tit: UILabel!
    @IBOutlet weak var tb: UITableView!
    let item=PublicBeans.getModel()
    lazy var adapter=GridAdapter(tb: tb, width: UIScreen.main.bounds.width, height: 80, count: {
        return self.item.model.count
    }, spilt: 1, nib: "Cell_Model", getcell: {
        a,b,c in
         let cell=a.dequeueReusableCell(withReuseIdentifier: "Cell_Model", for: b) as! Cell_Model
        cell.tit.text=self.item.model[c]
        cell.selectmodel=self.item.model[c]
        return cell
    })
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.notifyDataSetChange()
        tit.text=PublicBeans.Make
    }


    
}
