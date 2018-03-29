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
               }
            }.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        PodcastTextField.stringValue = "https://itunes.apple.com/ru/podcast/tms-1458-milk-money/id414564832?i=1000407762960&mt=2";
    }
    
}
