//
//  TTCell.swift
//  快递
//
//  Created by 文兵 on 2017/9/24.
//  Copyright © 2017年 文兵. All rights reserved.
//

import Cocoa

class TTCell: NSTableCellView {
    
    @IBOutlet weak var titleTextView: NSTextField!
    @IBOutlet weak var statusTextView: NSTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.white.cgColor
    }
    
    
    func configureData(_ model: TTInfoModel) {
        titleTextView.stringValue = model.time
        statusTextView.stringValue = model.context

    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    }
    
}
