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
    
    var categories:[Category] = []
    var assests:[String] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "GalleryCollectionViewCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: CELL_IDENTIFIER)
        
        let headerXib = UINib(nibName: "HeaderView", bundle: nil)
        collectionView.register(headerXib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        //collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        //APIHelper.getAssets()
        getData()
    }
    
    func getData(){
        APIHelper.getCategories { (categories, error) in
             if let error = error {
                print("There was an error: \(error)")
                return
            }
            
            guard let categories = categories else {
                return
            }
            
            for category in categories.categories {
                APIHelper.getAssets(categoryName: category) { (assest, error) in
                   if let error = error {
                        print("There was an error: \(error)")
                        return
                   }
                       
                   guard let assest = assest else {
                       print("Assets were nil")
                       return
                   }
                   
                    let newCategory = Category(categoryName: category, assets: assest.assest)
                    self.categories.append(newCategory)
                    self.collectionView.reloadData()
                }
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[section].assets.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath) as! GalleryCollectionViewCell
        let endpoint = categories[indexPath.section].assets[indexPath.row]
        let categoryName = categories[indexPath.section].categoryName
        let url = APIHelper.getImageEndpointURL(categoryName: categoryName, endpoint: endpoint)
        cell.galleryImageView.kf.indicatorType = .activity
        cell.galleryImageView.kf.setImage(with: url)
        cell.galleryImageView.clipsToBounds = true
        //cell.setNeedsLayout()
        
       // cell.cornerRadius = 4
       //cell.isSelectable = true
       
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      // 1
      switch kind {
      // 2
      case UICollectionView.elementKindSectionHeader:
        // 3
        guard
          let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "HeaderView",
            for: indexPath) as? HeaderView
          else {
            fatalError("Invalid view type")
        }

        print(categories[indexPath.section].categoryName)
        let categoryName = categories[indexPath.section].categoryName
        headerView.HeaderLabel.text = categoryName
        headerView.frame.size.height = 100
        return headerView
      default:
        // 4
        assert(false, "Invalid element type")
      }
    }
}
