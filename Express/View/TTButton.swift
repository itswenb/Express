//
//  TTButton.swift
//  快递
//
//  Created by 文兵 on 2017/9/24.
//  Copyright © 2017年 文兵. All rights reserved.
//

import Cocoa

@IBDesignable
class TTButton: NSButton
{
    @IBInspectable var bgColor: NSColor?
    @IBInspectable var textColor: NSColor?
    
    override func awakeFromNib()
    {
        if let textColor = textColor, let font = font
        {
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            
            var attributes = [NSAttributedStringKey : Any]()
            attributes[NSAttributedStringKey.foregroundColor] = textColor
            attributes[NSAttributedStringKey.font] = font
            attributes[NSAttributedStringKey.paragraphStyle] = style
            
            let attributedTitle = NSAttributedString(string: title, attributes: attributes)
            self.attributedTitle = attributedTitle
        }
    }
    
    override func draw(_ dirtyRect: NSRect)
    {
        if let bgColor = bgColor
        {
            bgColor.setFill()
            __NSRectFill(dirtyRect)
        }
        
        super.draw(dirtyRect)
    }
    
}
