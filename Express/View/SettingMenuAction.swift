//
//  SettingMenuAction.swift
//  快递
//
//  Created by 文兵 on 2017/9/24.
//  Copyright © 2017年 文兵. All rights reserved.
//

import Cocoa
import ServiceManagement

class SettingMenuAction {
    
    let launcherAppIdentifier = "com.tesths.TouTiaoLauncher"


    var autoLaunch: Bool = true
    let startMenu = NSMenuItem(title: "开机启动", action: #selector(startLogin), keyEquivalent: "")

    func perform(_ sender: NSView) {
        let delegate = NSApplication.shared.delegate as! MainViewController

        let menu = NSMenu()

        menu.addItem(NSMenuItem(title: "退出", action: #selector(delegate.quit), keyEquivalent: "q"))
        NSMenu.popUpContextMenu(menu, with: NSApp.currentEvent!, for: sender)
    }
    
    @objc func startLogin() {
        autoLaunch = !autoLaunch
        if autoLaunch == true {
            startMenu.title = "开机启动"
        } else {
            startMenu.title = "开机不启动"
        }
        SMLoginItemSetEnabled(launcherAppIdentifier as CFString, autoLaunch)
    }
    
}
