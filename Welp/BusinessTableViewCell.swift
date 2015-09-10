//
//  BusinessTableViewCell.swift
//  Welp
//
//  Created by Matt Hayes on 9/9/15.
//  Copyright (c) 2015 Mystery Command. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    
    var business: Business? {
        didSet {
            update()
        }
    }
    
    var addressLabel: UILabel!
    var categoriesLabel: UILabel!
    var distanceLabel: UILabel!
    var ratingImageView: UIImageView!
    var reviewCountLabel: UILabel!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func update() {
        if let name = business?.name {
            textLabel?.text = name
        }
        
        if let address = business?.address {
            
        }
        
        if let imageURL = business?.imageURL {
            imageView?.setImageWithURL(imageURL)
        }
        
        if let categories = business?.categories {
            
        }
        
        if let distance = business?.distance {
            
        }
        
        if let ratingImageURL = business?.ratingImageURL {
            
        }
        
        if let reviewCount = business?.reviewCount {
            
        }
    }

}
