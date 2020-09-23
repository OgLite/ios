//
//  Page_Select_Year.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsAdapter
import JzOsFrameWork
class Page_Select_Year: UIViewController {
let item=PublicBeans.getYear()
    @IBOutlet weak var tit: UILabel!
    @IBOutlet weak var tb: UITableView!
    lazy var adapter=GridAdapter(tb: tb, width: UIScreen.main.bounds.width, height: 80, count: {
        return self.item.year.count
    }, spilt: 1, nib: "Cell_Year", getcell: {
        a,b,c in
        let cell=a.dequeueReusableCell(withReuseIdentifier: "Cell_Year", for: b) as! Cell_Year
        cell.tit.text=self.item.year[c]
        cell.selectyear=self.item.year[c]
        return cell
    })
    override func viewDidLoad() {
        super.viewDidLoad()
        tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)"
        adapter.notifyDataSetChange()
    }
    override func viewWillAppear(_ animated: Bool) {
        tit.text="\(PublicBeans.Make)/\(PublicBeans.Model)"
    }
    @IBAction func goMenu(_ sender: Any) {
        JzActivity.getControlInstance.goMenu()
    }
    
}
