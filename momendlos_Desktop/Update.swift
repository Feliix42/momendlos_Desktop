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

    
    
    // to build UI on startup
    func startUI(){
        var currImage: NSMenuItem
        if let lastImage: String = NSUserDefaults.standardUserDefaults().objectForKey("lastImage") as? String {
            if let lastFile: String = NSUserDefaults.standardUserDefaults().objectForKey("lastFile") as? String {
                
                let lastData: [String:AnyObject] = ["title" : "\(lastImage)"]
                let current = Image(JSONDecoder(lastImage))
                currImage = NSMenuItem(title: current.title!, action: Selector(), keyEquivalent: "")
                setWallpaper(current.filename!)
            } else {
                currImage = NSMenuItem(title: "Failed to load", action: Selector(), keyEquivalent: "")
            }
        } else{
            currImage = NSMenuItem(title: "No Photo yet", action: Selector(), keyEquivalent: "")
        }
        momendMenu.insertItem(currImage, atIndex: 0)
        let icon = NSImage(named: "menuBar")
        icon?.setTemplate(true)
        statusItem.image = icon
        statusItem.menu = momendMenu
            

    }
    
    func updateImage(newImage: Image){
        NSUserDefaults.standardUserDefaults().setObject(newImage.title!, forKey: "lastImage")
        NSUserDefaults.standardUserDefaults().setObject(newImage.filename!, forKey: "lastfile")
        momendMenu.removeItemAtIndex(0)
        momendMenu.insertItem(NSMenuItem(title: newImage.title!, action: Selector(), keyEquivalent: ""), atIndex: 0)
        setWallpaper(newImage.filename!)
        
    }

}

func runUpdate(){
    
    let method = (NSApplication.sharedApplication().delegate as! AppDelegate).method
    var methodVal:String
    
    switch(method){
    case 0:
        methodVal = "last"
    case 1:
        methodVal = "random"
    case 2:
        methodVal = "next"
    default:
        methodVal = "last"
    }
    
    let url = "https://download.momendlos.de/getImage.php?method=\(methodVal)"
    
    checkImage(url){
        (imageData) in
        
        if imageData.title! != "No Data" {
        
            let localImages = getLocalImages()
            
            let exists = contains(localImages, imageData.filename!)
            
            if exists {
                UI.shared().updateImage(imageData)
            } else {
                downloadImage(imageData.filename!){
                    (completed) in
                    if completed {
                        UI.shared().updateImage(imageData)
                    }
                }
            }
        }
    }
}