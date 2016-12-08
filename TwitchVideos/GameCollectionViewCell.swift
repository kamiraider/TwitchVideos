//
//  GameCollectionViewCell.swift
//  TwitchVideos
//
//  Created by Administrator on 05.12.16.
//  Copyright © 2016 Loginov Anton. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gameImageView: UIImageView!
    
    func configureCell(_ game: Game) {
        if game.gameImage != nil {
            gameImageView.image = game.gameImage
            gameImageView.layer.cornerRadius = 10
            gameImageView.layer.masksToBounds = true
        }
    }
}
