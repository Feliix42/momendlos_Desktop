//
//  AppDelegate.swift
//  momendlos_Desktop
//
//  Created by Felix Döring on 03/06/15.
//  Copyright (c) 2015 Felix Döring. All rights reserved.
//

import Cocoa
import SwiftyTimer
import Fabric
import Crashlytics



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var momendMenu: NSMenu!
    @IBOutlet weak var lastImage: NSMenuItem!
    @IBOutlet weak var startAtLoginCheckbox: NSButton!
    @IBOutlet weak var selectedMethod: NSComboBoxCell!
    @IBOutlet weak var quitButton: NSMenuItem!
    
    let version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    var method = NSUserDefaults.standardUserDefaults().integerForKey("method")


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        Fabric.with([Crashlytics()])
        
        UI.shared().startUI()
        runUpdate()
        
        NSTimer.every(10.minutes, runUpdate)
        


    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func startAtLogin(sender: AnyObject) {
        if (sender.state == NSOffState)
        {
            NSBundle.mainBundle().removeFromLoginItems()
            startAtLoginCheckbox.state = NSOffState
        }
        else
        {
            NSBundle.mainBundle().addToLoginItems()
            startAtLoginCheckbox.state = NSOnState
        }
    }

    @IBAction func openSettings(sender: AnyObject) {
        if NSBundle.mainBundle().isLoginItem()
        {
            startAtLoginCheckbox.state = NSOnState
        }
        else
        {
            startAtLoginCheckbox.state = NSOffState
        }
        selectedMethod.selectItemAtIndex(NSUserDefaults.standardUserDefaults().integerForKey("method"))
        window.makeKeyAndOrderFront(sender)
        NSApp.activateIgnoringOtherApps(true)
    }
    
    @IBAction func selectMethod(sender: NSComboBoxCell) {
        method = sender.indexOfSelectedItem
        NSUserDefaults.standardUserDefaults().setInteger(method, forKey: "method")
        runUpdate()
    }
    
    @IBAction func clickQuit(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
}


