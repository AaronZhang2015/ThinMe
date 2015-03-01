//
//  TMRootWireframe.swift
//  ThinMe
//
//  Created by ZhangMing on 12/12/14.
//  Copyright (c) 2014 ZhangMing. All rights reserved.
//

import UIKit

let TabBarControllerIdentifier = "TabBarController"

class TMRootWireframe: BaseWireframe {
    
    var homeWireframe: TMHomeWireframe!
    var messageListWireframe: TMMessageListWireframe!
    var followListWireframe: TMFollowListWireframe!
    var profileWireframe: TMProfileWireframe!
    
    func presentTabbarControllerFromWindow(window: UIWindow) {
        var homeNavigationController = homeWireframe.homeViewControllerWithNavigationController()
        homeWireframe.viewController = homeNavigationController?.viewControllers[0] as UIViewController
        
        var messageListNavigationController = messageListWireframe.messageListViewControllerWithNavigationController()
        messageListWireframe.viewController = messageListNavigationController?.viewControllers[0] as UIViewController
        
        var followListNavigationController = followListWireframe.followListViewControllerWithNavigationController()
        followListWireframe.viewController = followListNavigationController?.viewControllers[0] as UIViewController
        
        var profileListNavigationController = profileWireframe.profileViewControllerWithNavigationController()
        profileWireframe.viewController = profileListNavigationController?.viewControllers[0] as UIViewController
        
        var tabbarController = tabbarControllerFromWindow(window)
        
        let viewControllers = [homeNavigationController!, messageListNavigationController!, followListNavigationController!, profileListNavigationController!]
        
        tabbarController.viewControllers = viewControllers
    }
    
    func configureDependencies(window: UIWindow) {
        let viewControllers = tabbarControllerFromWindow(window).viewControllers as [BaseNavigationController]
        var homeNavigationController = viewControllers[0] as BaseNavigationController
        var messageListNavigationController = viewControllers[1] as BaseNavigationController
        var followListNavigationController = viewControllers[2] as BaseNavigationController
        var profileListNavigationController = viewControllers[3] as BaseNavigationController
        
        homeWireframe.configureDependencies(homeNavigationController.viewControllers[0] as UIViewController)
        messageListWireframe.configureDependencies(messageListNavigationController.viewControllers[0] as UIViewController)
        followListWireframe.configureDependencies(followListNavigationController.viewControllers[0] as UIViewController)
        profileWireframe.configureDependencies(profileListNavigationController.viewControllers[0] as UIViewController)
    }
    
    func tabbarControllerFromWindow(window: UIWindow) -> UITabBarController {
        var navigationController = window.rootViewController as UITabBarController
        
        return navigationController
    }
    
}
