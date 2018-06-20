//
//  PhotoCell.swift
//  Sibedge-Recipes
//
//  Created by 123 on 18.06.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var urlStr: (String, indexPath: Int, imageCount: Int)? {
        didSet {
            guard let urlStr = urlStr else { return }
            if urlStr.0 == "noImage" {
                imageView.image = UIImage(named: "img")
            } else {
                imageView.loadImage(urlString: urlStr.0)
            }
            pageCountLbl.text = urlStr.imageCount == 1 ? "✦" : "✦\(urlStr.1 + 1)✦"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.image = UIImage(named: "img")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let pageCountLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    
    private func setupViews() {
        addSubview(imageView)
        addSubview(pageCountLbl)
        
        imageView.frame = CGRect(x: 0, y: 0,
                                 width: frame.width, height: frame.width - 72)
        
        pageCountLbl.frame = CGRect(x: 0, y: frame.width - 72,
                                    width: frame.width, height: 20)
    }
}
















