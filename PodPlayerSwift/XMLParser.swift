//
//  Parser.swift
//  PodPlayerSwift
//
//  Created by Mikhail Udot on 29.03.2018.
//  Copyright © 2018 Mikhail Udot. All rights reserved.
//

import Foundation

class XMLParser{
    public func GetPodcastMetadata(data: Data) -> (title: String?, imageUrl: String?) {
        let xml = SWXMLHash.parse(data)
        return (title: xml["rss"]["channel"]["title"].element?.text,
                imageUrl: xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
    }
    
    public func GetEpisodes(data: Data) -> [Episodes] {
        let xml = SWXMLHash.parse(data)
        print(xml)
        return []
    }
}
