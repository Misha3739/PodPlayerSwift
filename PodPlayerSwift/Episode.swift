//
//  Episodes.swift
//  PodPlayerSwift
//
//  Created by Mikhail Udot on 01.04.2018.
//  Copyright © 2018 Mikhail Udot. All rights reserved.
//

import Foundation

public class Episode{
    var title = ""
    var publishDate = Date()
    var htmlDescription = ""
    var audioUrl = ""
    
    public static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        return formatter
    } ()
}
