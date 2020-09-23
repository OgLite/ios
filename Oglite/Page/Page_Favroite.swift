//
//  Page_Favroite.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/4.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzOsAdapter
class Page_Favroite: UIViewController {
    lazy var item=Cell_Favorite.getFavorite()
    lazy var adapter = GridAdapter(tb: tb , width: UIScreen.main.bounds.width, height: 80, count: {
        return self.item.count
    }, spilt: 1, nib: "Cell_Favorite", getcell: {
        a,b,c in
        let cell=a.dequeueReusableCell(withReuseIdentifier: "Cell_Favorite", for: b) as! Cell_Favorite
        var it=self.item[c]
        cell.tit.text="\(it.make)/\(it.model)/\(it.year)"
        cell.delbt.isHidden=true
        cell.make=it.make
        cell.model=it.model
        cell.year=it.year
        return cell
    })
    @IBOutlet weak var tb: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        item=Cell_Favorite.getFavorite()
       adapter.notifyDataSetChange()
    }

}
