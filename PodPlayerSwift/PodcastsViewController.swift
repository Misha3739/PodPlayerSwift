//
//  PodcastsViewController.swift
//  PodPlayerSwift
//
//  Created by Mikhail Udot on 29.03.2018.
//  Copyright © 2018 Mikhail Udot. All rights reserved.
//

import Cocoa

class PodcastsViewController: NSViewController {
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
                        parser.GetPodcastMetadata(data: data!)
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
