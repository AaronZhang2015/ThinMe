//
//  TMUserWireframe.swift
//  ThinMe
//
//  Created by ZhangMing on 12/12/14.
//  Copyright (c) 2014 ZhangMing. All rights reserved.
//

import UIKit

let ProfileViewControllerIdentifier = "ProfileViewController"

class TMProfileWireframe: BaseWireframe {
    
    func profileViewControllerWithNavigationController() -> BaseNavigationController? {
        let profileViewController = profileViewControllerFromStoryboard()
        var navigationController = BaseNavigationController(rootViewController: profileViewController)
        return navigationController
    }
    
    func configureDependencies(viewController: UIViewController) {
        self.viewController = viewController
        let navigationController = self.viewController.navigationController as BaseNavigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func profileViewControllerFromStoryboard() -> TMProfileViewController {
        let storyboard = mainStoryboard()
        let profileViewController = storyboard.instantiateViewControllerWithIdentifier(ProfileViewControllerIdentifier) as TMProfileViewController
        
        return profileViewController
    }
    
}
