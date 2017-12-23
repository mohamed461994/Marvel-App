//
//  MarvelDetailesTableViewController.swift
//  Marvel App
//
//  Created by MohamedSh on 12/22/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import UIKit

class MarvelDetailesTableViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var EventsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// case if its comics CollectionView
        if collectionView == comicsCollectionView {
            return 3
        }/// case if its events CollectionView
        else if collectionView == EventsCollectionView{
            return 2
        }
        /// case if its series CollectionView
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! MarvelCollectionViewCell
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
