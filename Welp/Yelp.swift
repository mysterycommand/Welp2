//
//  YelpSearch.swift
//  Welp
//
//  Created by Matt Hayes on 9/9/15.
//  Copyright (c) 2015 Mystery Command. All rights reserved.
//

import Foundation

let yelpConsumerKey: String		 = "iRX6ITAc-klJde2CMF7IKg"
let yelpConsumerSecret: String	 = "96I24leo9MhskanVE1J4ky4OG10"
let yelpToken: String			 = "kNCwQIyvuM7gF7Es1deAcK6_5k0XfEhQ"
let yelpTokenSecret: String		 = "cXJ6J-pvZMdLMFmyapt2jXoblGg"

enum YelpSort: Int {
    case BestMatched = 0,
         Distance,
         HighestRated
}

class Yelp: BDBOAuth1RequestOperationManager {
    
    var token: String!
    var tokenSecret: String!
    
    class var instance: Yelp {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : Yelp? = nil
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Yelp(
                consumerKey: yelpConsumerKey,
                consumerSecret: yelpConsumerSecret,
                token: yelpToken,
                tokenSecret: yelpTokenSecret
            )
        }

        return Static.instance!
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String, consumerSecret secret: String, token: String, tokenSecret: String) {
        self.token = token
        self.tokenSecret = tokenSecret

        let baseURL = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseURL, consumerKey: key, consumerSecret: secret)
        
        var accessToken = BDBOAuth1Credential(token: token, secret: tokenSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(accessToken)
    }
    
    func search(term: String, completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
        return search(term, sort: nil, categories: nil, deals: nil, completion: completion)
    }

    func search(term: String, sort: YelpSort?, categories: [String]?, deals: Bool?, completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        // Default the location to San Francisco
        var params: [String: AnyObject] = [
            "ll": "37.785771,-122.406165",
            "term": term
        ]
        
        if let sort = sort {
            params["sort"] = sort.rawValue
        }
        
        if let categories = categories {
            if categories.count > 0 {
                params["category_filter"] = ",".join(categories)
            }
        }
        
        if let deals = deals {
            params["deals_filter"] = deals
        }
        
        return self.GET("search", parameters: params, success: {
            (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            var dictionaries = response["businesses"] as? [NSDictionary]
            if let dictionaries = dictionaries {
                completion(dictionaries.map({dictionary in Business(dict: dictionary)}), nil)
            }
        }, failure: {
            (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            
            completion(nil, error)
        })
    }

}