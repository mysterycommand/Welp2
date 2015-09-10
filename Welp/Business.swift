//
//  Business.swift
//  Welp
//
//  Created by Matt Hayes on 9/9/15.
//  Copyright (c) 2015 Mystery Command. All rights reserved.
//

import Foundation

class Business {
    var id: String?
    var name: String?
    var address: String?

    var imageURL: NSURL?
    
    var categories: String?
    var distance: String?
    
    var ratingImageURL: NSURL?
    var reviewCount: Int?
    
    init(dict: NSDictionary) {
        id = dict["id"] as? String
        name = dict["name"] as? String
        if let addressParts = dict.valueForKeyPath("location.display_address") as? [String] {
            address = "\n".join(addressParts)
        }
        
        if let imageURLString = dict["image_url"] as? String {
            imageURL = NSURL(string: imageURLString)
        }
        
        if let categoriesArray = dict["categories"] as? [[String]] {
            categories = ", ".join(categoriesArray.map({category in category[0]}))
        }
        if let distanceString = dict["distance"] as? String {
            let milesPerMeter: Float = 0.000621371
            let distanceFloat = (distanceString as NSString).floatValue

            distance = String(format: "%.2f mi", distanceFloat * milesPerMeter)
        }
        
        if let ratingImageURLString = dict["rating_img_url_large"] as? String {
            ratingImageURL = NSURL(string: ratingImageURLString)
        }
        reviewCount = dict["review_count"] as? Int
    }
}
