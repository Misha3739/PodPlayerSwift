//
//  PodcastsViewController.swift
//  PodPlayerSwift
//
//  Created by Mikhail Udot on 29.03.2018.
//  Copyright © 2018 Mikhail Udot. All rights reserved.
//

import Cocoa

class PodcastsViewController: NSViewController, NSTableViewDataSource,NSTableViewDelegate {
    @IBOutlet weak var PodcastTextField: NSTextField!
    @IBOutlet weak var AddPodcastButton: NSButton!

    @IBAction func AddPodcastButtonClick(_ sender: NSButton) {
        if let url = URL(string: PodcastTextField.stringValue) {
            URLSession.shared.dataTask(with: url) {
            (data: Data?,response: URLResponse?, error: Error?) in
               if error != nil {
                    print(error)
               }
               else{
                    if data != nil
                    {
                        let parser = XMLParser()
                        let info = parser.GetPodcastMetadata(data: data!)
                        
                        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                            let podcast = Podcast(context: context)
                            podcast.rssUrl = self.PodcastTextField.stringValue
                            podcast.imageUrl = info.imageUrl;
                            podcast.title = info.title
                            
                            (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil);
                        }
                        
                    }
                    self.PodcastTextField.stringValue = ""
               }
            }.resume()
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        PodcastTextField.stringValue = "http://feeds.feedburner.com/abcradio/starthere";
    }
    
    
}
