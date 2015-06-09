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
    let imgPath = "\(path!)/.momendlos/\(image)"
    let imgurl : NSURL = NSURL.fileURLWithPath(imgPath)!
    var error : NSError?
    let workspace = NSWorkspace.sharedWorkspace()
    let screentest = NSScreen.mainScreen()
    let screens = NSScreen.screens()!
    
    for screen in screens{
        workspace.setDesktopImageURL(imgurl, forScreen: screen as! NSScreen, options: nil, error: &error)
    }
    
}

func getLocalImages() -> Array<String>
{
    var fileManger = NSFileManager()
    var keys = [NSURLIsDirectoryKey]
    let path = NSSearchPathForDirectoriesInDomains(.PicturesDirectory, .UserDomainMask, true).first as? String
    let filePath = NSURL(fileURLWithPath: "\(path!)/.momendlos/")!
    
    var handler = {
        (url:NSURL!,error:NSError!) -> Bool in
        println(error.localizedDescription)
        //println(url.absoluteString)
        return true
    }
    
    var fileEnum = fileManger.enumeratorAtURL(filePath, includingPropertiesForKeys:
        keys, options: NSDirectoryEnumerationOptions(), errorHandler:handler)!
    
    var files = [String]()
    while let imagePath = fileEnum.nextObject() as? NSURL
    {
        let imageFull: String = imagePath.absoluteString!
        let image = imagePath.absoluteString!.substringWithRange(Range<String.Index>(start: filePath.absoluteString!.endIndex, end: imageFull.endIndex))
        files.append(image)
    }
    
    return files
}