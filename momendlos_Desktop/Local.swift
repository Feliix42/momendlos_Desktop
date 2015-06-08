//
//  Image.swift
//  momendlos_Desktop
//
//  Created by Felix Döring on 03/06/15.
//  Copyright (c) 2015 Felix Döring. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

func setWallpaper(image: String){
    
    let path = NSSearchPathForDirectoriesInDomains(.PicturesDirectory, .UserDomainMask, true).first as? String
    let imgurl : NSURL = NSURL.fileURLWithPath("\(path)/.momendlos/\(image)")!
    var error : NSError?
    let workspace = NSWorkspace.sharedWorkspace()
    let screentest = NSScreen.mainScreen()
    let screens = NSScreen.screens()!
    
    for screen in screens{
        workspace.setDesktopImageURL(imgurl, forScreen: screen as! NSScreen, options: nil, error: &error)
    }
    
}

