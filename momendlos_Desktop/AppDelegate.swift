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


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        Fabric.with([Crashlytics()])

    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}
