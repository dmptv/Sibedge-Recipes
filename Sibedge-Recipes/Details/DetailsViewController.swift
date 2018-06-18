//
//  DetailsViewController.swift
//  Sibedge-Recipes
//
//  Created by 123 on 18.06.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

internal struct DetailsCellIdentifies {
    static var loadingCell = "LoadingCell"
    static var descriptionCell = "DescriptionCell"
    static var nothingFoundCell = "NothingFoundCell"
    static var headerCell = "headerId"
}

class DetailsViewController: UICollectionViewController {
    
    
    fileprivate let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recipe"
        collectionView?.backgroundColor = .white
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 4
            flowLayout.minimumInteritemSpacing = 0
        }
        
        let cellNib = UINib(nibName: DetailsCellIdentifies.descriptionCell, bundle: nil)
        collectionView?.register(cellNib, forCellWithReuseIdentifier: DetailsCellIdentifies.descriptionCell)

        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCellIdentifies.headerCell, for: indexPath) as! DescriptionCell
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        
        
        return header
    }
    
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width - 52)
    }
}















































