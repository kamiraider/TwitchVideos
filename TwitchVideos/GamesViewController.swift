//
//  GamesViewController.swift
//  
//
//  Created by Administrator on 05.12.16.
//
//

import UIKit

class GamesViewController: UIViewController {

    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Games"
        
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(GamesViewController.reloadData), for: UIControlEvents.valueChanged)
        gamesCollectionView.insertSubview(refreshControl, at: 0)
        
        reloadData()
    }
    
    
}

extension GamesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return GameDataService.instanse.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "gameCell"
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? GameCollectionViewCell {
       
            let game = GameDataService.instanse.games[indexPath.row]
            cell.configureCell(game)
        return cell
            
        } else {
            
            return GameCollectionViewCell()
            
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = GameDataService.instanse.games[indexPath.row]
        performSegue(withIdentifier: "streamShowVC", sender: game)
    }

    //MARK: UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (gamesCollectionView.bounds.width / 2) - 15
        let height = width * (4 / 3)
        
        return CGSize(width: width, height: height)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "streamShowVC" {
            if let streamVC = segue.destination as? StreamsViewController {
                if let game = sender as? Game {
                    streamVC.game = game
                }
            }
            
        }
        
    }
    
    func reloadData() {
        GameDataService.instanse.downloadTopGames {
            for game in GameDataService.instanse.games {
                game.downloadGameImage(completed: {
                    self.gamesCollectionView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                })
            }
        }
    }

}
