//
//  DescriptionCell.swift
//  Sibedge-Recipes
//
//  Created by 123 on 18.06.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class DescriptionCell: UICollectionViewCell {
    
    @IBOutlet weak var textlbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    public func configure() {
        textlbl.text = "Description"
    }
    

}
