//
//  ExpressChooseViewController.swift
//  快递
//
//  Created by 文兵 on 2017/9/24.
//  Copyright © 2017年 文兵. All rights reserved.
//

import Cocoa

class ExpressChooseViewController: NSViewController {
    var model = [EPModel]()
    let fetcher = NetWorkFetcher()
    //闭包的两种定义方法
    //1.
    typealias blockClosure = (String) ->Void
    var didSelectExpress:blockClosure?
    //2.
    //var itemDidClickBlock:((Int,Bool) ->Void)?
    @IBOutlet weak var tableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        NotificationCenter.default.addObserver(self, selector: #selector(ExpressChooseViewController.reloadData(info:)), name:NSNotification.Name("PopReload"), object: nil)
    }
    @objc func reloadData(info:NSNotification){
        if !(info.isEqual(nil)) {
            fetcher.getReleases(url: info.object as! String){ result in
                if result != nil {
                    if ((result as AnyObject).className as NSString).contains("Dictionary") {
                        let dict = result as! NSDictionary
                        let mdict = NSMutableArray(array: dict.allKeys)
                        for (key,value) in dict {
                            let value = EPModel(dict :value as! NSDictionary)
                            let index = Int(key as! String)
                            mdict.replaceObject(at: index!, with: value)
                        }
                        self.model = mdict as! Array
                        self.tableView.reloadData()
                    }else{
                        let mdict = NSMutableArray()
                        let r = result as! Array<Any>
                        for dict in r{
                            mdict.add(EPModel(dict:dict as! NSDictionary))
                        }
                        self.model = mdict as! Array
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
        // MARK: - NSTableViewDataSource
        extension ExpressChooseViewController: NSTableViewDataSource {
            func numberOfRows(in aTableView: NSTableView) -> Int {
                return model.count
            }
            
            func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
                let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "EPCell"), owner: tableView) as! EPCell
                cellView.setData(self.model[row])
                return cellView
            }
            
        }
        extension ExpressChooseViewController:NSTableViewDelegate{
            
            func tableViewSelectionDidChange(_ notification: Notification) {
                let table = notification.object as! NSTableView
                let mo :EPModel = model[table.selectedRow]
                let o = String("-\(mo.exname).html")
                didSelectExpress!(o)
            }
}

