//
//  Page_Setting_Favorite.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/4.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import JzAdapter
import JzIos_Framework
public class Page_Setting_Favorite: UIViewController {
    
    @IBOutlet weak var tb: UITableView!
    lazy var item=Cell_Favorite.getFavorite()
    public lazy var adapter = GridAdapter(tb: tb, width: UIScreen.main.bounds.width, height: 80, count: {
        return self.item.count
    }, spilt: 1, nib: "Cell_Favorite", getcell: {
        a,b,c in
        let cell=a.dequeueReusableCell(withReuseIdentifier: "Cell_Favorite", for: b) as! Cell_Favorite
        var it=self.item[c]
        cell.tit.text="\(it.make)/\(it.model)/\(it.year)"
        cell.delbt.isHidden=false
        cell.make=it.make
        cell.model=it.model
        cell.year=it.year
        cell.delfunction={
            self.refresh()
        }
        return cell
    })
    override public func viewDidLoad() {
        super.viewDidLoad()
            
    }
    override public func viewDidAppear(_ animated: Bool) {
        refresh()
    }
    func refresh(){
        print("sas")
        item=Cell_Favorite.getFavorite()
        if(item.count==0){
            tb.separatorStyle = .none
        }else{
            tb.separatorStyle = .singleLine
        }
        adapter.notifyDataSetChange()
    }
    @IBAction func addvehicle(_ sender: Any) {
        JzActivity.getControlInstance.changePage(Page_Add_Favorite(), "Page_Add_Favorite", true)
    }
    
    
    
}
