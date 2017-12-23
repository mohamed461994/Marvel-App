//
//  MarvelDetailesTableViewController.swift
//  Marvel App
//
//  Created by MohamedSh on 12/22/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import UIKit
import Kingfisher
class MarvelDetailesTableViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var EventsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgMainCharchter: UIImageView!
    var marvelPassedData:MarvelItem?{
        didSet{
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updatUI()
    }
    func updatUI(){
        lblTitle.text = marvelPassedData?.title!
        lblDescription.text = marvelPassedData?.description
        imgMainCharchter.kf.setImage(with: URL(string: (marvelPassedData?.img_URL!)!)!)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! MarvelCollectionViewCell
        if collectionView == comicsCollectionView{
            cell.colectionCellLabaTitle.text = marvelPassedData?.comics[indexPath.row].name!
        }else if collectionView == EventsCollectionView{
            cell.colectionCellLabaTitle.text = marvelPassedData?.events[indexPath.row].name!
        }else if collectionView == storiesCollectionView{
            cell.colectionCellLabaTitle.text = marvelPassedData?.stories[indexPath.row].name!
        }else {
            cell.colectionCellLabaTitle.text = marvelPassedData?.series[indexPath.row].name!
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// case if its comics CollectionView
        if collectionView == comicsCollectionView {
            return marvelPassedData?.comics.count ?? 0
        }/// case if its events CollectionView
        else if collectionView == EventsCollectionView{
            return marvelPassedData?.events.count ?? 0
        }///case if its series collection
        else if collectionView == storiesCollectionView{
            return marvelPassedData?.series.count ?? 0
        }
        /// case if its series CollectionView
        return marvelPassedData?.stories.count ?? 0
    }
}
