//
//  GameDataService.swift
//  TwitchVideos
//
//  Created by Administrator on 05.12.16.
//  Copyright © 2016 Loginov Anton. All rights reserved.
//

import Foundation
import Alamofire

class GameDataService {
    
    static let instanse = GameDataService()
    var games = [Game]()
    
    func downloadTopGames(completed: @escaping downloadComplete) -> () {
        let url = topGamesURL
        var nameString: String!
        var imageURLString: String!
        request(url).responseJSON { (response) in
            print(response)
            if let json = response.result.value as? [String : Any] {
                if let topGamesArray = json["top"] as? [[String : Any]], topGamesArray.count > 0 {
                    for i in 0..<topGamesArray.count {
                        if let gameDict = topGamesArray[i]["game"] as? [String : Any] {
                                if let gameName = gameDict["name"] as? String {
                                   nameString = gameName
                                }
                            
                                if let boxArt = gameDict["box"] as? [String : Any] {
                                    if let imageURL = boxArt["large"] as? String {
                                        imageURLString = imageURL
                                    }
                                }
                            }
                        let game = Game(name: nameString, imageURL: imageURLString)
                        self.games.append(game)
                    }
                    
                }
            }
            completed()
        }
    }
}
