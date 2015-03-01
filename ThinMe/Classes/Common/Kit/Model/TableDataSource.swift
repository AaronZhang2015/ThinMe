//
//  TableDataSource.swift
//  ThinMe
//
//  Created by ZhangMing on 12/21/14.
//  Copyright (c) 2014 ZhangMing. All rights reserved.
//

import UIKit

class TableDataSource: NSObject, UITableViewDataSource {
    
    var dataSource: NSArray?
    var identifier: String!
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject? {
        return dataSource?.objectAtIndex(indexPath.row)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell
//        let item = itemAtIndexPath(indexPath)
        return cell
    }
}
