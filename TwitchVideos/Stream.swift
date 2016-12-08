//
//  Stream.swift
//  TwitchVideos
//
//  Created by Administrator on 08.12.16.
//  Copyright © 2016 Loginov Anton. All rights reserved.
//

import Foundation
import Alamofire

class Stream {
    var broadcasterName: String
    var streamTitle: String
    var viewersCount: Double
    var streamImage: UIImage?
    var streamImageURL: String
    
    init(name:String, title: String, viewersCount: Double, imageURL: String) {
        self.broadcasterName = name
        self.streamTitle = title
        self.viewersCount = viewersCount
        self.streamImageURL = imageURL
    }
    
    func downloadStreamImage(completed: @escaping downloadComplete) {
        
        request(self.streamImageURL).responseData { (response) in
            
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self.streamImage = image
                }
            }
            completed()
        }
    }

}
