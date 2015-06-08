//
//  Network.swift
//  momendlos_Desktop
//
//  Created by Felix Döring on 08/06/15.
//  Copyright (c) 2015 Felix Döring. All rights reserved.
//

import Foundation
import SwiftHTTP


func checkJSON(requestMethod: String){
    
    
    
}

func downloadImage(image: String){
    var request = HTTPTask()
    let downloadTask = request.download("https://download.momendlos.de/\(image)", parameters: nil, progress: {(complete: Double) in
        println("percent complete: \(complete)")
        }, completionHandler: {(response: HTTPResponse) in
            println("download finished!")
            if let err = response.error {
                println("error: \(err.localizedDescription)")
                return //also notify app of failure as needed
            }
            if let url = response.responseObject as? NSURL {
                //we MUST copy the file from its temp location to a permanent location.
                if let path = NSSearchPathForDirectoriesInDomains(.PicturesDirectory, .UserDomainMask, true).first as? String {
                    if let fileName = response.suggestedFilename {
                        if let newPath = NSURL(fileURLWithPath: "\(path)/.momendlos/") {
                            let fileManager = NSFileManager.defaultManager()
                            fileManager.createDirectoryAtURL(newPath, withIntermediateDirectories: true, attributes: nil, error: nil)
                            let filePath = NSURL(fileURLWithPath: "\(path)/.momendlos/\(fileName)")!
                            fileManager.removeItemAtURL(filePath, error: nil)
                            fileManager.moveItemAtURL(url, toURL: filePath, error:nil)
                        }
                    }
                }
            }
            
    })
}