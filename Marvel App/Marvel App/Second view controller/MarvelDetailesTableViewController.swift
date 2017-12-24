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
    var viewModel:ViewModelSingleMarvel?
    var marvelPassedData:MarvelItem?{
        didSet{
            viewModel=ViewModelSingleMarvel(comics: getComicsURI() , series: getSeriesURI(), stores: getStoriesURI(), events: getEventsURI())
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updatUI()
        createObserverForReloadData()
    }
    func updatUI(){
        lblTitle.text = marvelPassedData?.title!
        lblDescription.text = marvelPassedData?.description
        imgMainCharchter.kf.setImage(with: URL(string: (marvelPassedData?.img_URL!)!)!)
        
    }
    func createObserverForReloadData(){
        let notifiReload = Notification.Name(notificationForSingleDataLoad)
        NotificationCenter.default.addObserver(self, selector: #selector(MarvelDetailesTableViewController.reloadData), name: notifiReload, object: nil)
    }
    @objc func reloadData(notification:NSNotification){
        DispatchQueue.main.async {[weak self] in
            self?.comicsCollectionView.reloadData()
            self?.seriesCollectionView.reloadData()
            self?.EventsCollectionView.reloadData()
            self?.storiesCollectionView.reloadData()
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! MarvelCollectionViewCell
        // in case if its commics collection view
        if collectionView == comicsCollectionView && (marvelPassedData?.comics.count)! > 0{
            cell.colectionCellLabaTitle.text = marvelPassedData?.comics[indexPath.row].name!
            // in case if comics list url is ready to load
            if (viewModel?.comicsListIsReady(size: (marvelPassedData?.comics.count)!))!{
                cell.colectionCellImage.kf.setImage(with: viewModel?.getComicImgUrl(indexPath: indexPath))
            }
        }// case if its event collection view
        else if collectionView == EventsCollectionView && (marvelPassedData?.events.count)! > 0{
            cell.colectionCellLabaTitle.text = marvelPassedData?.events[indexPath.row].name!
            if (viewModel?.eventsListIsReady(size: (marvelPassedData?.events.count)!))!{
                cell.colectionCellImage.kf.setImage(with: viewModel?.getEventImgUrl(indexPath: indexPath))
            }
        }// case if its stories collection view
        else if collectionView == storiesCollectionView && (marvelPassedData?.stories.count)! > 0{
            cell.colectionCellLabaTitle.text = marvelPassedData?.stories[indexPath.row].name!
            if (viewModel?.storesListIsReady(size: (marvelPassedData?.stories.count)!))!{
                cell.colectionCellImage.kf.setImage(with: viewModel?.getStoryImgUrl(indexPath: indexPath))
            }
        }// case if its series  collection view
        else if collectionView == seriesCollectionView && (marvelPassedData?.series.count)! > 0 {
            if (viewModel?.seriesListIsReady(size: (marvelPassedData?.series.count)!))!{
                cell.colectionCellImage.kf.setImage(with: viewModel?.getSerieImgUrl(indexPath: indexPath))
            }
            cell.colectionCellLabaTitle.text = marvelPassedData?.series[indexPath.row].name!
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// case if its comics CollectionView
        if collectionView == comicsCollectionView {
            return (marvelPassedData?.comics.count)!
        }/// case if its events CollectionView
        else if collectionView == EventsCollectionView{
            return (marvelPassedData?.events.count)!
        }///case if its series collection
        else if collectionView == storiesCollectionView{
            return (marvelPassedData?.stories.count)!
        }
        /// case if its series CollectionView
        return (marvelPassedData?.series.count)!
    }
    func getComicsURI()->[String]{
        return (marvelPassedData?.comics.map{$0.resourceURI!})!
    }
    func getSeriesURI()->[String]{
        return (marvelPassedData?.series.map{$0.resourceURI!})!
    }
    func getStoriesURI()->[String]{
        return (marvelPassedData?.stories.map{$0.resourceURI!})!
    }
    func getEventsURI()->[String]{
        return (marvelPassedData?.events.map{$0.resourceURI!})!
    }
}
