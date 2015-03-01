//
//  TMFollowWireframe.swift
//  ThinMe
//
//  Created by ZhangMing on 12/12/14.
//  Copyright (c) 2014 ZhangMing. All rights reserved.
//

import UIKit

let FollowListViewControllerIdentifier = "FollowListViewController"

class TMFollowListWireframe: BaseWireframe {
    
    func followListViewControllerWithNavigationController() -> BaseNavigationController? {
        let followListViewController = followListViewControllerFromStoryboard()
        var navigationController = BaseNavigationController(rootViewController: followListViewController)
        return navigationController
    }
    
    func configureDependencies(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func followListViewControllerFromStoryboard() -> TMFollowListViewController {
        let storyboard = mainStoryboard()
        let followListViewController = storyboard.instantiateViewControllerWithIdentifier(FollowListViewControllerIdentifier) as TMFollowListViewController
        
        return followListViewController
    }
   
}
