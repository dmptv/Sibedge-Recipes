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
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var recipe: Recipe? {
        didSet {
            guard let recipe = recipe else { return }
            let attributesText = NSMutableAttributedString(string: recipe.instructions, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)])

            
            descriptionLbl.attributedText = attributesText
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    public func configure() {
        textlbl.text = "Description"
    }
    

}
