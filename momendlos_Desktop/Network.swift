//
//  Network.swift
//  momendlos_Desktop
//
//  Created by Felix Döring on 08/06/15.
//  Copyright (c) 2015 Felix Döring. All rights reserved.
//

import Foundation
import SwiftHTTP
import JSONJoy


func checkImage(urlToRequest: String, completed: (image:Image) -> ()) {
    var request = HTTPTask()
    request.GET(urlToRequest, parameters: nil, success: {(response: HTTPResponse) in
        if let data = response.responseObject as? NSData {
            var resp = Image(JSONDecoder(data))
            completed(image: resp)
        }
        },failure: {(error: NSError, response: HTTPResponse?) in
            
            let errorData: [String:AnyObject] = ["title" : "No Data"]
            let resp = Image(JSONDecoder(errorData))
            completed(image: resp)
    })
}

func downloadImage(image: String, completed: (result:Bool) -> ()){
    var request = HTTPTask()
    print(image)
    let downloadTask = request.download("https://download.momendlos.de/\(image)", parameters: nil, progress: {(complete: Double) in
        }, success: {(response: HTTPResponse) in
            println("\ndownload finished!")
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
                            completed(result: true)
                        }
                    }
                }
            }
            
        },failure: {(error: NSError, response: HTTPResponse?) in
            completed(result: false)})
}