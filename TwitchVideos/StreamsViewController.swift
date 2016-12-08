//
//  StreamsViewController.swift
//  TwitchVideos
//
//  Created by Administrator on 08.12.16.
//  Copyright © 2016 Loginov Anton. All rights reserved.
//

import UIKit

class StreamsViewController: UIViewController {

    @IBOutlet weak var streamsTableView: UITableView!
    
    var game: Game!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(game.gameName)"
        streamsTableView.delegate = self
        streamsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        StreamDataService.instanse.downloadStreamsForGame(game) {
            for stream in StreamDataService.instanse.streams {
                stream.downloadStreamImage {
                    self.streamsTableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        StreamDataService.instanse.removeAllStreams()
        
    }
}

extension StreamsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StreamDataService.instanse.streams.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = streamsTableView.dequeueReusableCell(withIdentifier: "streamCell", for: indexPath) as? StreamTableViewCell {
            let stream = StreamDataService.instanse.streams[indexPath.row]
            cell.configureCell(stream: stream)
            
            return cell
        } else {
            return StreamTableViewCell()
        }
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (streamsTableView.bounds.width / 16) * 9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stream = StreamDataService.instanse.streams[indexPath.row]
        
        openStream(stream: stream)
    }
    
    //Handler function to open stream in chosen app
    func openStream(stream: Stream) {
        let alert = UIAlertController(title: "Open stream in TwitchVideo or in official TwitchApp", message: "Official TwitchApp must be installed for latter option.", preferredStyle: .alert)
        
        let openInTwitchVideoAction = UIAlertAction(title: "TwitchVideo", style: .default) { (action) in
            self.performSegue(withIdentifier: "channelShowVC", sender: stream)
        }
        
        let openInTwitchAppAction = UIAlertAction(title: "TwitchApp", style: .default) { (action) in
            self.openStreamInTwitchApp(stream: stream)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(openInTwitchAppAction)
        alert.addAction(openInTwitchVideoAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "channelShowVC" {
            if let channelVC = segue.destination as? ChannelViewController {
                if let stream = sender as? Stream {
                    channelVC.stream = stream
                }
            }
        }
    }
    
    //MARK: Mobile Deep Link
    func openStreamInTwitchApp(stream: Stream) {
        let streamString = streamDeepLinkURL + stream.broadcasterName
        if let streamURL = URL(string: streamString) {
            if UIApplication.shared.canOpenURL(streamURL) {
                UIApplication.shared.open(streamURL, options: [:], completionHandler: nil)
            }
        }
    }
}
