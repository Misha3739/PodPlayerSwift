//
//  Parser.swift
//  PodPlayerSwift
//
//  Created by Mikhail Udot on 29.03.2018.
//  Copyright © 2018 Mikhail Udot. All rights reserved.
//

import Foundation

class XMLParser{
    public func GetPodcastMetadata(data: Data) -> String? {
        let xml = SWXMLHash.parse(data)
        return xml["rss"]["channel"]["title"].element?.text
    }
}
