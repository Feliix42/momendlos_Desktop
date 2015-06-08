//
//  ImageList.swift
//  momendlos_Desktop
//
//  Created by Felix Döring on 08/06/15.
//  Copyright (c) 2015 Felix Döring. All rights reserved.
//

import Foundation
import JSONJoy

class Image : JSONJoy {
    var title: String?
    var filename: String?
    init() {
        
    }
    required init(_ decoder: JSONDecoder) {
        title = decoder["title"].string
        filename = decoder["filename"].string
        
    }
}

