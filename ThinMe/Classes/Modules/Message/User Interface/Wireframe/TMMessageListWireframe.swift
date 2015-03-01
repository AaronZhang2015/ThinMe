//
//  TMMessageWireframe.swift
//  ThinMe
//
//  Created by ZhangMing on 12/12/14.
//  Copyright (c) 2014 ZhangMing. All rights reserved.
//

import UIKit

let MessageListViewControllerIdentifier = "MessageListViewController"

class TMMessageListWireframe: BaseWireframe {
    
    func messageListViewControllerWithNavigationController() -> BaseNavigationController? {
        let messageListViewController = messageListViewControllerFromStoryboard()
        var navigationController = BaseNavigationController(rootViewController: messageListViewController)
        return navigationController
    }
    
    func configureDependencies(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func messageListViewControllerFromStoryboard() -> TMMessageListViewController {
        let storyboard = mainStoryboard()
        let messageListViewController = storyboard.instantiateViewControllerWithIdentifier(MessageListViewControllerIdentifier) as TMMessageListViewController
        
        return messageListViewController
    }
   
}
