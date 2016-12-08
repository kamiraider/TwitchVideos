//
//  StreamDataService.swift
//  TwitchVideos
//
//  Created by Administrator on 08.12.16.
//  Copyright © 2016 Loginov Anton. All rights reserved.
//

import Foundation
import Alamofire

class StreamDataService {
    
    static let instanse = StreamDataService()
    
    var streams: [Stream] = [Stream]()

    func downloadStreamsForGame(_ game: Game, complited: @escaping downloadComplete) {
        
        var viewerCountDouble: Double!
        var imageURLString, nameString, titleString: String!
        
        //GET /streams
        let gameName = game.gameName.replacingOccurrences(of: " ", with: "+")
        let url = baseStreamsURL + gameName + clientID
        
        request(url).responseJSON { (response) in
            if let json = response.result.value as? [String : Any] {
                if let streamsArray = json["streams"] as? [Dictionary<String,Any>], streamsArray.count > 0 {
                    for i in 0..<streamsArray.count {
                        if let viewersCount = streamsArray[i]["viewers"] as? Double {
                            viewerCountDouble = viewersCount
                        }
                        
                        if let previewDict = streamsArray[i]["preview"] as? [String : Any] {
                            if let imageURL = previewDict["large"] as? String {
                                imageURLString = imageURL
                            }
                        }
                        if let channelDict = streamsArray[i]["channel"] as? [String : Any] {
                            if let channelName = channelDict["display_name"] as? String {
                                nameString = channelName
                            }
                            
                            if let title = channelDict["status"] as? String {
                                titleString = title
                            }
                        }
                        
                        let stream = Stream(name: nameString, title: titleString, viewersCount: viewerCountDouble, imageURL: imageURLString)
                        self.streams.append(stream)
                    }
                }
            }
            complited()
        }
    }
    
    func removeAllStreams() {
        streams.removeAll()
    }
}
