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
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    var comicsList:[String:String]?
    var seriessList:[String:String]?
    var eventsList:[String:String]?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// case if its comics CollectionView
        if collectionView == comicsCollectionView {
            return comicsList?.count ?? 0
        }/// case if its events CollectionView
        else if collectionView == EventsCollectionView{
            return eventsList?.count ?? 0
        }
        /// case if its series CollectionView
        return seriessList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! MarvelCollectionViewCell
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
