//
//  TMHomeWireframe.swift
//  ThinMe
//
//  Created by ZhangMing on 12/12/14.
//  Copyright (c) 2014 ZhangMing. All rights reserved.
//

import UIKit

let HomeViewControllerIdentifier = "HomeViewController"

class TMHomeWireframe: BaseWireframe {
    
    func homeViewControllerWithNavigationController() -> BaseNavigationController? {
        let homeViewController = homeViewControllerFromStoryboard()
        var navigationController = BaseNavigationController(rootViewController: homeViewController)
        return navigationController
    }
    
    func configureDependencies(viewController: UIViewController) {
        self.viewController = viewController
        let navigationController = self.viewController.navigationController as BaseNavigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func homeViewControllerFromStoryboard() -> TMHomeViewController {
        let storyboard = mainStoryboard()
        let homeViewController = storyboard.instantiateViewControllerWithIdentifier(HomeViewControllerIdentifier) as TMHomeViewController
        
        return homeViewController
    }
   
}
