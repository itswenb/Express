//
//  AppDelegate.swift
//  Express
//
//  Created by 文兵 on 2017/9/24.
//  Copyright © 2017年 文兵. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    let launcherAppIdentifier = "com.tesths.TouTiaoLauncher"
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        startAtLogin()
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func startAtLogin() {
        
        //you should move this next line to somewhere else this is for testing purposes only!!!
        SMLoginItemSetEnabled(launcherAppIdentifier as CFString, true)
        
        var startedAtLogin = false
        for app in NSWorkspace.shared.runningApplications {
            
            if app.bundleIdentifier == launcherAppIdentifier {
                startedAtLogin = true
            }
        }
        
        if startedAtLogin {
            DistributedNotificationCenter.default().post(name: .killme, object: Bundle.main.bundleIdentifier!)
            print("i killed the launcher app!")
        }
    }
}

extension Notification.Name {
    static let killme = Notification.Name("killme")
}

