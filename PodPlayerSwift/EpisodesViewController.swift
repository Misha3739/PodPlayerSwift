//
//  EpisodesViewController.swift
//  PodPlayerSwift
//
//  Created by Mikhail Udot on 31.03.2018.
//  Copyright © 2018 Mikhail Udot. All rights reserved.
//

import Cocoa

class EpisodesViewController: NSViewController {

    var podcast : Podcast? = nil
    var podcastsVC : PodcastsViewController? = nil
    
    @IBOutlet weak var TitleLabel: NSTextField!
    @IBOutlet weak var ImageView: NSImageView!
    @IBOutlet weak var PausePlayButton: NSButton!
    @IBOutlet weak var DeleteButton: NSButton!
    
    @IBAction func PlayPauseButtonClick(_ sender: NSButton) {
    }
    @IBAction func DeleteButtonClick(_ sender: NSButton) {
        if(podcast != nil) {
            if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                do {
                    context.delete(podcast!)
                    try context.save()
                } catch{}
            
            }
            podcastsVC?.getPodcasts()
            podcast = nil
            updateView()
        }
    }
    
    @IBOutlet weak var TableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func updateView() {
        if(podcast?.title != nil){
           TitleLabel.stringValue = podcast!.title!
        }else{
            TitleLabel.stringValue = ""
        }
        if(podcast?.imageUrl != nil) {
            let image = NSImage(byReferencing : URL(string : podcast!.imageUrl!)!)
            ImageView.image = image
        }else{
            ImageView.image = nil
        }
        
        PausePlayButton.isHidden = true
        getEpisodes()
    }
    
    func getEpisodes()
    {
        if podcast?.rssUrl != nil {
            if let url = URL(string: podcast!.rssUrl!){
                URLSession.shared.dataTask(with: url) {
                    (data: Data?,response: URLResponse?, error: Error?) in
                    if error != nil {
                        print(error)
                    }
                    else{
                        if data != nil
                        {
                            let parser = XMLParser()
                            let episodes = parser.GetEpisodes(data: data!)
                        }
                    }
                }.resume()
            }
        }
    }
}
