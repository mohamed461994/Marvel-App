//
//  MarvelDetailesTableViewController.swift
//  Marvel App
//
//  Created by MohamedSh on 12/22/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import UIKit

class MarvelDetailesTableViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
