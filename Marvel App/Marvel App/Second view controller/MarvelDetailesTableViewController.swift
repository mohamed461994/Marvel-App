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
    /// story collection view outlet that display stories images and title for charchter
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    /// comic collection view outlet that display comics images and title for charchter
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    /// event collection view outlet that display events images and title for charchter
    @IBOutlet weak var EventsCollectionView: UICollectionView!
    /// serie collection view outlet that display series images and title for charchter
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    /// this is lable outlet for the main Title of a charchter
    @IBOutlet weak var lblTitle: UILabel!
    /// this is lable outlet for charchter description
    @IBOutlet weak var lblDescription: UILabel!
    /// this is the main imageView outlet for the charchter
    @IBOutlet weak var imgMainCharchter: UIImageView!
    var viewModel:ViewModelSingleMarvel?
    /// this variable will be set while segue by true value in case if no internet
    var noInternt:Bool=false
    /// this is sette by the main view controller in prepare for segue
    var marvelPassedData:MarvelItem?{
        didSet{
            viewModel=ViewModelSingleMarvel(comics: getComicsURI() ,
                                      series: getSeriesURI(),
                                      stores: getStoriesURI(),
                                      events: getEventsURI())
        }
    }
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var indicatorII: UIActivityIndicatorView!
    @IBOutlet weak var indicatorIII: UIActivityIndicatorView!
    @IBOutlet weak var indicatorIIII: UIActivityIndicatorView!
    func startIndicator(){
        indicator.startAnimating()
        indicatorII.startAnimating()
        indicatorIII.startAnimating()
        indicatorIIII.startAnimating()
    }
    func stopIndicator(){
        indicator.stopAnimating()
        indicatorII.stopAnimating()
        indicatorIII.stopAnimating()
        indicatorIIII.stopAnimating()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updatUI()
        createObserverForReloadData()
    }
    /// this function used to set INFO that came from segue to the UI
    func updatUI(){
        if let marvel = marvelPassedData{
            lblTitle.text = marvel.title!
            lblDescription.text = marvel.description
            imgMainCharchter.kf.setImage(with: URL(string: (marvel.img_URL!))!)
            hideCollectionViews()
            startIndicator()
        }
    }
    /** this function is used to add add observer when images is ready to load in collection view */
    func createObserverForReloadData(){
        let notifiReload = Notification.Name(notificationForSingleDataLoad)
        NotificationCenter.default.addObserver(self, selector: #selector(MarvelDetailesTableViewController.reloadData), name: notifiReload, object: nil)
    }
    /// this function will be called by notification selector
    @objc func reloadData(notification:NSNotification){
        DispatchQueue.main.async {[weak self] in
            self?.stopIndicator()
            self?.comicsCollectionView.reloadData()
            self?.seriesCollectionView.reloadData()
            self?.EventsCollectionView.reloadData()
            self?.storiesCollectionView.reloadData()
            self?.showAllCollectionViews()
        }
    }
    func hideCollectionViews(){
        comicsCollectionView.isHidden = true
        seriesCollectionView.isHidden = true
        EventsCollectionView.isHidden = true
        storiesCollectionView.isHidden = true
    }
    func showAllCollectionViews(){
        comicsCollectionView.isHidden = false
        seriesCollectionView.isHidden = false
        EventsCollectionView.isHidden = false
        storiesCollectionView.isHidden = false
    }
    /**
     this function will be called 4 times when loaded each time will fill one of the
     collection view (series comics storei etc...)
     */
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
        // case if its comics CollectionView
        if collectionView == comicsCollectionView {
            return (marvelPassedData?.comics.count)!
        }// case if its events CollectionView
        else if collectionView == EventsCollectionView{
            return (marvelPassedData?.events.count)!
        }//case if its series collection
        else if collectionView == storiesCollectionView{
            return (marvelPassedData?.stories.count)!
        }
        // case if its series CollectionView
        return (marvelPassedData?.series.count)!
    }
    /// this function return comics URI to get its images
    func getComicsURI()->[String]{
        return (marvelPassedData?.comics.map{$0.resourceURI!})!
    }
    /// this function return series URI to get its images
    func getSeriesURI()->[String]{
        return (marvelPassedData?.series.map{$0.resourceURI!})!
    }
    /// this function return stories URI to get its images
    func getStoriesURI()->[String]{
        return (marvelPassedData?.stories.map{$0.resourceURI!})!
    }
    /// this function return events URI to get its images
    func getEventsURI()->[String]{
        return (marvelPassedData?.events.map{$0.resourceURI!})!
    }
}
