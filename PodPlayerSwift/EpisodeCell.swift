//
//  EpisodeCell.swift
//  PodPlayerSwift
//
//  Created by Mikhail Udot on 06.04.2018.
//  Copyright © 2018 Mikhail Udot. All rights reserved.
//

import Cocoa
import WebKit

class EpisodeCell: NSTableCellView {

    @IBOutlet weak var TitleLabel: NSTextField!
    @IBOutlet weak var PubdateLabel: NSTextField!
    @IBOutlet weak var DescriptionWebView: WKWebView!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
