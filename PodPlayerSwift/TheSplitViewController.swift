//
//  TheSplitViewController.swift
//  PodPlayerSwift
//
//  Created by Mikhail Udot on 31.03.2018.
//  Copyright © 2018 Mikhail Udot. All rights reserved.
//

import Cocoa

class TheSplitViewController: NSSplitViewController {

    @IBOutlet weak var PodcastsItem: NSSplitViewItem!
    @IBOutlet weak var EpisodesItem: NSSplitViewItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
