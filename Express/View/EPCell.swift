//
//  EPCell.swift
//  快递
//
//  Created by 文兵 on 2017/9/24.
//  Copyright © 2017年 文兵. All rights reserved.
//

import Cocoa
import SDWebImage

class EPCell: NSTableCellView {
    let webHome = "http://www.kuaidi.com/"
    
    @IBOutlet weak var headImage: NSImageView!
    @IBOutlet weak var name: NSTextField!
    @IBOutlet weak var phone: NSTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.white.cgColor
    }
    
    
    func setData(_ model: EPModel) {
        headImage.sd_setImage(with: URL(string: "\(webHome)\(model.ico)"), placeholderImage: NSImage(named: NSImage.Name("TouTiao")), options: SDWebImageOptions.highPriority, completed: nil)
        name.stringValue = model.name
        phone.stringValue = model.phone
//        headImage.image = NSImage(named: NSImage.Name("\(webHome)\(model.ico)"))
//        titleTextView.stringValue = model.tim
//        statusTextView.stringValue = model.script
        
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
    }
    
}
