//
//  ViewController.swift
//  Marvel App
//
//  Created by MohamedSh on 12/22/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import UIKit
import Kingfisher
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var viewModel:ViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createObserverForReloadData()
        viewModel = ViewModel()
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

        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.marvelItemCount())!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelCell", for: indexPath) as! MarvelTableViewCell
        cell.lbltitle.text = viewModel?.marvelTite(indexPath: indexPath)
        cell.marvelImg.kf.setImage(with: viewModel?.marvelURL(indexPath: indexPath))
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelecteMarvel"{
            if let vC = segue.destination as? MarvelDetailesTableViewController {
                vC.marvelPassedData = viewModel?.getSelecctedMarvelData(indexPath: (tableView.indexPathForSelectedRow)!)
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = (viewModel?.numberOfRows())! - 1
        if indexPath.row == lastItem && ( lastItem + 1 ) % 10 == 0{
            viewModel?.loadMoreData()
            
        }
    }

}

