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

    private let descriptionList = ["Name:", "Description:", "Instruction:", "Level of Complexity:"]
    
    var recipe: Recipe! {
        didSet {
            collectionView?.reloadData()
        }
    }
    
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

        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: DetailsCellIdentifies.headerCell)
    
        collectionView?.alwaysBounceVertical = true
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
    }
    
}

extension DetailsViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return descriptionList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCellIdentifies.descriptionCell, for: indexPath) as! DescriptionCell
        
        switch indexPath.item {
        case 0:
            cell.textlbl.text = descriptionList[indexPath.row]
            cell.descriptionLbl.text = recipe.name
        case 1:
            cell.textlbl.text = descriptionList[indexPath.row]
            cell.recipeText = recipe.description
        case 2:
            cell.textlbl.text = descriptionList[indexPath.row]
            cell.recipeText = recipe.instructions
        case 3:
            cell.textlbl.text = descriptionList[indexPath.row]
            cell.descriptionLbl.text = "\(recipe.difficulty)"
        default:
            cell.textlbl.text = ""
            cell.descriptionLbl.text = ""
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailsCellIdentifies.headerCell, for: indexPath) as! Header
     
        return header
    }
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1 {
            let rect = descriptionAttributedText(recipe.description).boundingRect(with: CGSize(width: view.frame.width - 32, height: 1000), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
            return CGSize(width: view.frame.width, height: rect.height + 40)
        }
        
        if indexPath.item == 2 {
            let rect = descriptionAttributedText(recipe.instructions).boundingRect(with: CGSize(width: view.frame.width - 32, height: 1000), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
            return CGSize(width: view.frame.width, height: rect.height + 40)
        }
        
        return CGSize(width: view.frame.width, height: 60)
    }
    
    fileprivate func descriptionAttributedText(_ text: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text,
                                                       attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)])
        
        return attributedText
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.width - 52)
    }
}






















