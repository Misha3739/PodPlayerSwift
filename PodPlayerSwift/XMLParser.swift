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
    
    public func GetEpisodes(data: Data) -> [Episode] {
        let xml = SWXMLHash.parse(data)
        var episodes : [Episode] = []
        
        for item in xml["rss"]["channel"]["item"].all {
            let episode = Episode()
            if let title = item["title"].element?.text as? String {
                episode.title = title
            }
            
            if let htmldescription = item["description"].element?.text as? String {
                episode.htmlDescription = htmldescription
            }
            
            if let audioUrl = item["link"].element?.text as? String {
                episode.audioUrl = audioUrl
            }
            
            if let pubDate = item["pubDate"].element?.text {
                if let date = Episode.formatter.date(from: pubDate) {
                    episode.publishDate = date
                }
            }
            
            episodes.append(episode)
        }
        print(xml)
        return episodes
    }
}
