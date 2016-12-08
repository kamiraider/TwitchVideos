//
//  Constants.swift
//  TwitchVideos
//
//  Created by Administrator on 05.12.16.
//  Copyright © 2016 Loginov Anton. All rights reserved.
//

import Foundation

//https://api.twitch.tv/kraken

let clientID = "&client_id=hvqxvwv815sjuteuq32m6wmrry2mpfi"
let topGamesURL = "https://api.twitch.tv/kraken/games/top?limit=50&client_id=hvqxvwv815sjuteuq32m6wmrry2mpfi"
let baseStreamsURL = "https://api.twitch.tv/kraken/streams?game="
let baseEmbedURL = "https://twitch.tv/"
let embedURL = "/embed"
let streamDeepLinkURL = "twitch://open?stream="
typealias downloadComplete = () -> () 
