//
//  ViewController.swift
//  Welp
//
//  Created by Matt Hayes on 9/9/15.
//  Copyright (c) 2015 Mystery Command. All rights reserved.
//

import UIKit

extension NSLayoutFormatOptions {
    static var None: NSLayoutFormatOptions {
        return NSLayoutFormatOptions(0)
    }
}

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var businesses: [Business]!
    
    var tableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Welp"
        
        tableView = UITableView()
        tableView.frame = UIScreen.mainScreen().bounds
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.randomColor()
        tableView.registerClass(BusinessTableViewCell.self, forCellReuseIdentifier: "BusinessTableViewCell")
        
        tableView.estimatedRowHeight = 116
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.frame = UIScreen.mainScreen().bounds
        view.backgroundColor = UIColor.randomColor()
        view.addSubview(tableView)

        let views = ["tableView": tableView]
        
        let VFLH = "H:|-8-[tableView]-8-|"
        let VFLV = "V:|-8-[tableView]-8-|"
        
        let tableViewContraintsH = NSLayoutConstraint.constraintsWithVisualFormat(VFLH, options: .None, metrics: nil, views: views)
        let tableViewContraintsV = NSLayoutConstraint.constraintsWithVisualFormat(VFLV, options: .None, metrics: nil, views: views)
        
        view.addConstraints(tableViewContraintsH)
        view.addConstraints(tableViewContraintsV)
        
        Yelp.instance.search("Restaurants", completion: {
            (businesses: [Business]!, error: NSError!) -> Void in
            
//            if let businesses = businesses {
//                businesses.map({business in println(business.name!)})
//            }
            
            self.businesses = businesses
            self.tableView.reloadData()
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = self.businesses {
            return businesses.count
        }
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessTableViewCell", forIndexPath: indexPath) as! BusinessTableViewCell

        cell.business = self.businesses![indexPath.row]

        return cell
    }

}

