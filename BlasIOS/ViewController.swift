//
//  ViewController.swift
//  BlasIOS
//
//  Created by Andi Gibson on 4/27/20.
//  Copyright © 2020 Andi Gibson. All rights reserved.
//

import UIKit
import MaterialComponents
import Kingfisher

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let CELL_IDENTIFIER = "GalleryCell"
    
    var assests:[String] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "GalleryCollectionViewCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: CELL_IDENTIFIER)
        //APIHelper.getAssets()
        APIHelper.getAssets { (assest, error) in
            if let error = error {
                print("There was an error: \(error)")
                return
            }
            
            guard let assest = assest else {
                print("Assets were nil")
                return
            }
            
            self.assests = assest.assest
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath) as! GalleryCollectionViewCell
        let endpoint = assests[indexPath.row]
        let url = APIHelper.getImageEndpointURL(endpoint: endpoint)
        cell.galleryImageView.kf.indicatorType = .activity
        cell.galleryImageView.kf.setImage(with: url)
        
        
        
       // cell.cornerRadius = 4
       //cell.isSelectable = true
       
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0;
    }
    
    
    
}
