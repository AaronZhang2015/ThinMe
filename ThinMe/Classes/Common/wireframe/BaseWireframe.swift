//
//  TMBaseWireframe.swift
//  ThinMe
//
//  Created by ZhangMing on 12/12/14.
//  Copyright (c) 2014 ZhangMing. All rights reserved.
//

import UIKit

let StoryboardName = "Main"

class BaseWireframe: NSObject {
    
    weak var viewController: UIViewController!
    
    func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: StoryboardName, bundle: NSBundle.mainBundle())
    }
}
