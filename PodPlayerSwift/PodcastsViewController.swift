//
//  PodcastsViewController.swift
//  PodPlayerSwift
//
//  Created by Mikhail Udot on 29.03.2018.
//  Copyright © 2018 Mikhail Udot. All rights reserved.
//

import Cocoa

class PodcastsViewController: NSViewController, NSTableViewDataSource,NSTableViewDelegate {
    
    var Podcasts : [Podcast] = []
    
    @IBOutlet weak var PodcastTextField: NSTextField!
    @IBOutlet weak var AddPodcastButton: NSButton!

    @IBOutlet weak var podcastTableView: NSTableView!
    
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
                            
                            self.getPodcasts()
                        }
                        
                    }
                    self.PodcastTextField.stringValue = ""
               }
            }.resume()
        }
        
        
    }
    
    func getPodcasts()
    {
         if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let fetchRequest = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            do {
                Podcasts = try context.fetch(fetchRequest)
                print(Podcasts)
            } catch {}
            
            podcastTableView.reloadData()
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return Podcasts.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("podcastcell"), owner: self) as? NSTableCellView
        let podcast = Podcasts[row]
        cell?.textField?.alignment = NSTextAlignment.center
        if podcast.title != nil {
            cell?.textField?.stringValue = podcast.title!
        }
        else{
            cell?.textField?.stringValue = "UNKNOWN TITLE"
        }
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        PodcastTextField.stringValue = "http://feeds.feedburner.com/abcradio/starthere";
        getPodcasts()
    }
    
    
}
