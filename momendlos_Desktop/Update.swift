//
//  Update.swift
//  momendlos_Desktop
//
//  Created by Felix Döring on 03/06/15.
//  Copyright (c) 2015 Felix Döring. All rights reserved.
//

import Foundation
import Cocoa
import JSONJoy
import IYLoginItem

private let _SharedUI = UI()

class UI{
    
    static func shared() -> UI {
        return _SharedUI
    }
    
    let momendMenu = (NSApplication.sharedApplication().delegate as! AppDelegate).momendMenu
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var method: Int
    
    init(){
        method = NSUserDefaults.standardUserDefaults().integerForKey("method")
    }
    
    
    // to build UI on startup
    func startUI(){
        var currImage: NSMenuItem
        if let lastImage: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("lastImage") {
            let current = Image(JSONDecoder(lastImage))
            currImage = NSMenuItem(title: current.title!, action: Selector(), keyEquivalent: "")
            setWallpaper(current.filename!)
        } else{
            currImage = NSMenuItem(title: "No Photo yet", action: Selector(), keyEquivalent: "")
        }
        momendMenu.insertItem(currImage, atIndex: 0)
        statusItem.title = "momendlos"
        statusItem.title = "momendlos"
        statusItem.menu = momendMenu
            

    }
    
    func updateImageName(newImage: Image){
        NSUserDefaults.standardUserDefaults().setValue(newImage, forKey: "lastImage")
        momendMenu.removeItemAtIndex(0)
        momendMenu.insertItem(NSMenuItem(title: newImage.title!, action: Selector(), keyEquivalent: ""), atIndex: 0)
        
    }

}