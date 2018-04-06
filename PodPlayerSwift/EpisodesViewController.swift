//
//  EpisodesViewController.swift
//  PodPlayerSwift
//
//  Created by Mikhail Udot on 31.03.2018.
//  Copyright © 2018 Mikhail Udot. All rights reserved.
//

import Cocoa
import AVFoundation

class EpisodesViewController: NSViewController , NSTableViewDataSource, NSTableViewDelegate {

    var podcast : Podcast? = nil
    var podcastsVC : PodcastsViewController? = nil
    var episodes: [Episode] = []
    var player : AVPlayer? = nil
    
    @IBOutlet weak var TitleLabel: NSTextField!
    @IBOutlet weak var ImageView: NSImageView!
    @IBOutlet weak var PausePlayButton: NSButton!
    @IBOutlet weak var DeleteButton: NSButton!
    
    @IBAction func PlayPauseButtonClick(_ sender: NSButton) {
        if PausePlayButton.title == "Pause" {
            player?.pause()
            PausePlayButton.title = "Play"
        }  else{
            player?.play()
            PausePlayButton.title = "Pause"
       }
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
        
        DeleteButton.isHidden = true;
        PausePlayButton.isHidden = true;
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
       
        DeleteButton.isHidden = podcast == nil
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
                            self.episodes = parser.GetEpisodes(data: data!)
                            DispatchQueue.main.async {
                                 self.TableView.reloadData()
                            }
                           
                        }
                    }
                }.resume()
            }
        }
        else
        {
             episodes = []
             self.TableView.reloadData()
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let episode = episodes[row]
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("episodeCell"), owner: self) as? EpisodeCell
        cell?.TitleLabel?.stringValue = episode.title
        cell?.PubdateLabel?.stringValue = episode.publishDate?.description ?? ""
        cell?.DescriptionWebView.loadHTMLString(episode.htmlDescription, baseURL: nil)
        return cell
    }
    
    func  tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100;
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if(TableView.selectedRow >= 0){
            let episode = episodes[TableView.selectedRow]
            if let url = URL(string: episode.audioUrl) {
               PausePlayButton.isHidden = false;
               PausePlayButton.title = "Pause"
                
               player = nil
               player = AVPlayer(url: url)
               player?.play()
            }
            else{
                PausePlayButton.isHidden = true
                PausePlayButton.title = "Play"
            }
        }
    }
    
}
