//
//  NSDate+Extension.swift
//  快递
//
//  Created by 文兵 on 2017/9/24.
//  Copyright © 2017年 文兵. All rights reserved.
//

import Cocoa

extension Date
{
    func hour() -> Int
    {
        //Get Hour
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.hour, from: self)
        let hour = components.hour
        
        //Return Hour
        return hour!
    }
    
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.minute, from: self)
        let minute = components.minute
        
        //Return Minute
        return minute!
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let timeString = formatter.string(from: self)
        //Return Short Time String
        return timeString
    }
    func hourFromTimeStamp(timeStamp : String) -> String {
        let timeInterval:TimeInterval? = TimeInterval(timeStamp)
        let date = NSDate(timeIntervalSince1970: timeInterval!)
        
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let result = gregorian!.components(NSCalendar.Unit.hour, from: date as Date, to: NSDate() as Date, options: NSCalendar.Options(rawValue: 0))
        return String(describing: result)
    }
}
