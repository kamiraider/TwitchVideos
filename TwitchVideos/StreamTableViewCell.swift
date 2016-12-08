//
//  StreamTableViewCell.swift
//  TwitchVideos
//
//  Created by Administrator on 08.12.16.
//  Copyright © 2016 Loginov Anton. All rights reserved.
//

import UIKit

class StreamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var streamImageView: UIImageView!
    @IBOutlet weak var broadcasterName: UILabel!
    @IBOutlet weak var streamTitle: UILabel!
    @IBOutlet weak var streamViewers: UILabel!
    
    func configureCell(stream: Stream) {
        broadcasterName.text = stream.broadcasterName
        streamTitle.text = stream.streamTitle
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        streamViewers.text = "\(formatter.string(from: NSNumber(value: stream.viewersCount))!) viewers"
        if stream.streamImage != nil {
            streamImageView.image = stream.streamImage
        }
    }
}
