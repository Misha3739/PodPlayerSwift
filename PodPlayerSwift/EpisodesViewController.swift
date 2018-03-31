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
    
    @IBOutlet weak var TitleLabel: NSTextField!
    @IBOutlet weak var ImageView: NSImageView!
    @IBOutlet weak var PausePlayButton: NSButton!
    @IBOutlet weak var DeleteButton: NSButton!
    @IBAction func PlayPauseButtonClick(_ sender: NSButton) {
    }
    @IBAction func DeleteButtonClick(_ sender: NSButton) {
    }
    @IBOutlet weak var TableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func updateView() {
            if(podcast?.title != nil){
            TitleLabel.stringValue = podcast!.title!
        }
    }
}
