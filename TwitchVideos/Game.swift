//
//  Game.swift
//  TwitchVideos
//
//  Created by Administrator on 05.12.16.
//  Copyright © 2016 Loginov Anton. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Game  {
    
    var gameName: String
    var gameImageURL: String
    var gameImage: UIImage?
    
    init(name: String, imageURL: String) {
        self.gameName = name
        self.gameImageURL = imageURL
    }
    
    func downloadGameImage(completed: @escaping downloadComplete) {
        
        request(self.gameImageURL).responseData { (response) in
            
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self.gameImage = image
                }
            }
            completed()
        }
    }
}
