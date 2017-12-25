//
//  ViewController.swift
//  Marvel App
//
//  Created by MohamedSh on 12/22/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import UIKit
import Kingfisher
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    var viewModel:ViewModel?
    // table view outlet
    @IBOutlet weak var tableView: UITableView!
    /**
     this searching text variable is used for searchin when it set using opserver operator didSet
     */
    var searchingText:String = ""{
        didSet{
            tableView.isHidden = true
            viewModel = ViewModel(searchText: searchingText)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createObserverForReloadData()
        viewModel = ViewModel(searchText: searchingText)
        creatingNaveBarLogo()
        creatRightBarButtonForSearch()
    }
    /// this function is used to creat Marvel logo in midel of navigation item
    func creatingNaveBarLogo(){
        let navController = navigationController!
        let img = #imageLiteral(resourceName: "icn-nav-marvel")
        let imgView = UIImageView(image: img)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - 50
        let bannerY = bannerHeight / 2 - 25
        imgView.frame = CGRect(x: bannerX, y: bannerY, width: 100, height: 50)
        imgView.contentMode = .scaleAspectFit
        navigationItem.titleView = imgView
    }
    /// this function is used to creat search icon
    func creatRightBarButtonForSearch(){
        let btn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(ViewController.searchingIconAction))
        navigationItem.setRightBarButton(btn, animated: true)
    }
    /// this function will called when search cancel button is pressed
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        creatingNaveBarLogo()
        creatRightBarButtonForSearch()
        viewModel = ViewModel(searchText: "")
    }
    /**
     This function used to creat observer to get notified when data is ready
     */
    func createObserverForReloadData(){
        let notifiReload = Notification.Name(notificationForReloadTable)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reload) , name: notifiReload, object: nil)
    }
    /**
     This function called when data is ready to be presented
     */
    @objc func reload(notification:NSNotification){
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
        }
    }
    /// number of rows function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.marvelItemCount())!
    }
    /// this function will be called when search icon pressed
    @IBAction func searchingIconAction(_ sender: UIBarButtonItem) {
        navigationItem.setRightBarButton(nil, animated: false)
        creatSearchBar()
    }
    /// this function used to creat search bar
    func creatSearchBar(){
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = " Search..."
        searchBar.backgroundColor = .black
        navigationItem.titleView = searchBar
        searchBar.delegate=self
    }
    /// searching function when text changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingText = searchText
    }
    /// cell for row at function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelCell", for: indexPath) as! MarvelTableViewCell
        cell.lbltitle.text = viewModel?.marvelTite(indexPath: indexPath)
        cell.marvelImg.kf.setImage(with: viewModel?.marvelURL(indexPath: indexPath))
        return cell
    }
    /**
     this function will called when user chose cell to segue  to the second view controller
     if there is no internet it wont set URI on the prepare for segues
     but it will just set the variable of noInternet
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelecteMarvel"{
            if let vC = segue.destination as? MarvelDetailesTableViewController {
                if (MarvelData.conectionIsNotAvailable()){
                    vC.noInternt = true
                }
                vC.marvelPassedData = viewModel?.getSelecctedMarvelData(indexPath: (tableView.indexPathForSelectedRow)!)
            }
        }
    }
    /**
     this function will called when user scroll to the last cell to load more data
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = (viewModel?.numberOfRows())! - 1
        if indexPath.row == lastItem && ( lastItem + 1 ) % 6 == 0{
            viewModel?.loadMoreData()
        }
    }

}
