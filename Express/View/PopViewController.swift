//
//  PopViewController.swift
//  快递
//
//  Created by tesths on 4/1/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa
//import Kanna

class PopViewController: NSViewController {
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    let fetcher = NetWorkFetcher()
    var baseModel : TTModel?{
        didSet{
            expressNumber.stringValue = "单号:\(baseModel?.nu ?? "未知")"
            expressPhoneNumber.stringValue = "TEL:\(baseModel?.phone ?? "未知")"
            expressUsingTime.stringValue = "在途时间:\(baseModel?.timeused ?? "未知")"
            expressNameButton.title = "\(baseModel?.company ?? "快递名称")"
            let url = URL(string:"\(rootUrl)\(String(describing: baseModel?.ico))")
            expressHeadImage.sd_setImage(with: url, completed: nil)
        }
    }
    var model = [TTInfoModel]()
    let rootUrl = "http://www.kuaidi.com/"
    let selectRootUrl = "http://www.kuaidi.com/index-ajaxselectinfo-"
    let carrerRootUrl = "http://www.kuaidi.com/index-ajaxselectcourierinfo-"
    //    let webHome = "http://www.kuaidi.com/index-ajaxselectcourierinfo-50620122003428-huitongkuaidi.html"
    var webHome : NSString = ""
    var history : NSMutableArray = NSMutableArray()
    
    
    @IBOutlet weak var expressUsingTime: NSTextField!
    @IBOutlet weak var expressPhoneNumber: NSTextField!
    @IBOutlet weak var expressNumber: NSTextField!
    @IBOutlet weak var expressNameButton: TTButton!
    @IBOutlet weak var expressHeadImage: NSImageView!
    @IBOutlet weak var inputExpressNumber: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var expressNumberHistory: NSPopUpButton!{
        didSet {
            expressNumberHistory.removeAllItems()
            if history.count != 0 {
                for itemString in history {
                    expressNumberHistory.addItem(withTitle: itemString as! String)
                }
            }else{
                expressNumberHistory.addItem(withTitle: "没有历史记录")
            }
        }
    }
    
    @IBAction func toutiaoPost(_ sender: Any) {
        
        reloadData()
    }
    
    @IBAction func hotPost(_ sender: Any) {
        
        reloadData()
    }
    
    
    @IBOutlet weak var headerView: NSView! {
        didSet {
            headerView.wantsLayer = true
            headerView.layer?.backgroundColor = CGColor(red: 230, green: 255, blue: 255, alpha: 1)
        }
    }
    @IBOutlet weak var footerView: NSView! {
        didSet {
            footerView.wantsLayer = true
            footerView.layer?.backgroundColor = NSColor.init(red:0.16, green:0.69, blue:0.93, alpha:1.00).cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        NotificationCenter.default.addObserver(self, selector: #selector(PopViewController.reloadData), name:NSNotification.Name("Reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PopViewController.selectedExpress(express:)), name:NSNotification.Name("SelectExpress"), object: nil)
        history = (get() as? NSMutableArray) ?? NSMutableArray();
    }
    
    @IBAction func toggleSettingButton(_ sender: NSView) {
        let menu = SettingMenuAction()
        menu.perform(sender)
    }
    
    @objc func selectedExpress(express:String){
        let arr = NSMutableArray(array: self.history)
        arr.insert("\(carrerRootUrl)\(inputExpressNumber.stringValue)\(express)", at: 0)
        self.history = arr
        self.save(number: self.history)
        self.webHome = (history.firstObject as? NSString) ?? ""
        reloadData()
        togglePopover(inputExpressNumber)
    }
    @objc func reloadData() {
        if !((webHome.isEqual(to: ""))){
            fetcher.getReleases(url: webHome as String) {
                result in
                self.baseModel = TTModel(dict:result as! NSDictionary)
                if self.baseModel?.success == true {
                    self.model = self.baseModel!.data as! [TTInfoModel]
                    self.tableView.reloadData()
                }
            }
        }
    }
    override func awakeFromNib() {
        popover.behavior = .transient
        let v = ExpressChooseViewController(nibName: NSNib.Name("ExpressChooseViewController"), bundle: nil)
        v.didSelectExpress = {(result) ->() in
            self.selectedExpress(express: result)
        }
        popover.contentViewController = v
        popover.appearance = NSAppearance(named: NSAppearance.Name.aqua)
        popover.behavior = .transient
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [unowned self] event in
            if self.popover.isShown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
    }
    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    func showPopover(_ sender: AnyObject?) {
        if let button = inputExpressNumber {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        eventMonitor?.start()
    }
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
    
}
// MARK: - NSTableViewDataSource
extension PopViewController: NSTableViewDataSource {
    func numberOfRows(in aTableView: NSTableView) -> Int {
        return model.count
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: tableView) as! TTCell
        cellView.configureData(self.model[self.model.count - row - 1])
        return cellView
    }
}
extension PopViewController:NSTableViewDelegate{
    func tableViewSelectionIsChanging(_ notification: Notification) {
        
    }
}
extension PopViewController:NSTextFieldDelegate{
    override func controlTextDidEndEditing(_ obj: Notification) {
        print(inputExpressNumber.stringValue)
        inputExpressNumber.stringValue = String(StrToInt(str: inputExpressNumber.stringValue))
        if inputExpressNumber.stringValue.length > 4 {
            togglePopover(inputExpressNumber)
            NotificationCenter.default.post(name: Notification.Name("PopReload"), object: ("\(selectRootUrl)\(inputExpressNumber.stringValue).html"))
            self.inputExpressNumber.becomeFirstResponder()
        }
    }
    override func controlTextDidChange(_ obj: Notification) {
        
    }
}
//MARK: - ExtensionMethod
extension PopViewController{
    func save(number:NSArray!) {
        UserDefaults.standard.setValue(number, forKey: "expressNumberHistory")
        UserDefaults.standard.synchronize()
        expressNumberHistory.removeAllItems()
        if history.count != 0 {
            for itemString in history {
                expressNumberHistory.addItem(withTitle: itemString as! String)
            }
        }else{
            expressNumberHistory.addItem(withTitle: "没有历史记录")
        }
    }
    func get() -> NSArray? {
        return UserDefaults.standard.value(forKey: "expressNumberHistory") as? NSArray
    }
    func StrToInt(str:String) -> Int{
        //字符串不能为空
        guard str.isEmpty == false else {
            print("字符串不能为空~");
            return 0;
        }
        var s = 1
        var strInt:Int? = nil
        for characterInt in str.unicodeScalars {
            //只能包含数字或正负号
            let tempStrInt = characterInt.hashValue - "0".unicodeScalars.first!.hashValue
            guard (tempStrInt <= 9 && tempStrInt >= 0) || (characterInt.hashValue == 43 || characterInt.hashValue == 45) else {
                print("包含非法字符！");
                return 0;
            }
            //正负号只能存在于字符串开头
            if characterInt.hashValue == 43 || characterInt.hashValue == 45 {
                guard strInt == nil else {
                    print("正负号只能存在于字符串开头！");
                    return 0;
                }
            }
            //既然走到这一步，说明字符串合法
            //判断正负数
            if characterInt.hashValue == 43 || characterInt.hashValue == 45{
                s = s * ( 44 - characterInt.hashValue )
            }else{
                if strInt == nil {
                    strInt = characterInt.hashValue - "0".unicodeScalars.first!.hashValue
                }else{
                    //使用溢出运算符&*和&+避免数值过大导致溢出崩溃
                    strInt = strInt! &* 10 &+ ( characterInt.hashValue - "0".unicodeScalars.first!.hashValue )
                }
            }
        }
        var result:Int? = 0
        if strInt != nil {
            result = s * strInt!
        }
        return result!;
    }
}
