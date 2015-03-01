//
//  AnimatedTabBarController.swift
//  ThinMe
//
//  Created by ZhangMing on 12/13/14.
//  Copyright (c) 2014 ZhangMing. All rights reserved.
//

import UIKit

/*****************************************
 *
 * TabBarItem
 *
 *****************************************/

class AnimatedTabBarItem: UITabBarItem {
    
    @IBOutlet weak var animation: TabBarItemAnimation!
    @IBInspectable var textColor: UIColor = UIColor.blackColor()
    
    func playAnimation(icon: UIImageView, textLabel: UILabel) {
        assert(animation != nil, "add animation in UITabBarItem")
        if animation != nil {
            animation.playAnimation(icon, textLabel: textLabel)
        }
    }
    
    func deselectAnimation(icon: UIImageView, textLabel: UILabel) {
        if animation != nil {
            animation.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor)
        }
    }
    
    func selectedState(icon: UIImageView, textLabel: UILabel) {
        if animation != nil {
            animation.selectedState(icon, textLabel: textLabel)
        }
    }
}

/*****************************************
*
* TabBarController
*
*****************************************/

class AnimatedTabBarController: UITabBarController {
    
    var iconsView: [(icon: UIImageView, textLabel: UILabel)] = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containers = createViewContainers()
        
        createCustomIcons(containers)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createViewContainer() -> UIView {
        var viewContainer = UIView()
        viewContainer.backgroundColor = UIColor.clearColor()
        viewContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(viewContainer)
        
        // gesture
        var tapGesture = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
        tapGesture.numberOfTouchesRequired = 1
        viewContainer.addGestureRecognizer(tapGesture)
        
        // constraints
        var constY = NSLayoutConstraint(item: viewContainer,
                                        attribute: .Bottom,
                                        relatedBy: .Equal,
                                        toItem: view,
                                        attribute: .Bottom,
                                        multiplier: 1,
                                        constant: 0)
        
        view.addConstraint(constY)
        
        var constH = NSLayoutConstraint(item: viewContainer,
                                        attribute: .Height,
                                        relatedBy: .Equal,
                                        toItem: nil,
                                        attribute: .NotAnAttribute,
                                        multiplier: 1,
                                        constant: CGRectGetHeight(tabBar.frame))
        viewContainer.addConstraint(constH)
        
        return viewContainer
    }
    
    func createViewContainers() -> NSDictionary {
        var containersDict = NSMutableDictionary()
        let itemsCount: Int = tabBar.items!.count - 1
        
        for index in 0...itemsCount {
            var viewContainer = createViewContainer()
            containersDict.setValue(viewContainer, forKey: "container\(index)")
        }
        
        var keys = containersDict.allKeys
        
        var formatString = "H:|-(0)-[container0]"
        for index in 1...itemsCount {
            formatString += "-(0)-[container\(index)(==container0)]"
        }
        formatString += "-(0)-|"
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat(formatString, options: NSLayoutFormatOptions.DirectionRightToLeft, metrics: nil, views: containersDict)
        
        view.addConstraints(constraints)
        
        return containersDict
    }
    
    func createConstraints(view: UIView, container: UIView, size: CGSize, yOffset: CGFloat) {
        
        var constX = NSLayoutConstraint(item: view,
                                        attribute: NSLayoutAttribute.CenterX,
                                        relatedBy: NSLayoutRelation.Equal,
                                        toItem: container,
                                        attribute: NSLayoutAttribute.CenterX,
                                        multiplier: 1,
                                        constant: 0)
        container.addConstraint(constX)
        
        var constY = NSLayoutConstraint(item: view,
                                        attribute: .CenterY,
                                        relatedBy: .Equal,
                                        toItem: container,
                                        attribute: .CenterY,
                                        multiplier: 1,
                                        constant: yOffset)
        container.addConstraint(constY)
        
        var constW = NSLayoutConstraint(item: view,
                                        attribute: .Width,
                                        relatedBy: .Equal,
                                        toItem: nil,
                                        attribute: .NotAnAttribute,
                                        multiplier: 1,
                                        constant: size.width)
        view.addConstraint(constW)
        
        var constH = NSLayoutConstraint(item: view,
                                        attribute: .Height,
                                        relatedBy: .Equal,
                                        toItem: nil,
                                        attribute: .NotAnAttribute,
                                        multiplier: 1,
                                        constant: size.height)
        
        view.addConstraint(constW)
        
    }
    
    func createCustomIcons(containers: NSDictionary) {
        if let items = tabBar.items {
            let itemCount = tabBar.items!.count - 1
            
            var index = 0
            
            for item in self.tabBar.items as [AnimatedTabBarItem] {
                
                assert(item.image != nil, "add image icon in UITabBarItem")
                
                var container: UIView = containers["container\(itemCount - index)"] as UIView
                container.tag = index
                var icon = UIImageView(image: item.image)
                
                icon.setTranslatesAutoresizingMaskIntoConstraints(false)
                icon.tintColor = UIColor.clearColor()
                
                var textLabel = UILabel()
                textLabel.text = item.title
                textLabel.backgroundColor = UIColor.clearColor()
                textLabel.textColor = item.textColor
                textLabel.font = UIFont.systemFontOfSize(10.0)
                textLabel.textAlignment = .Center
                textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
                
                container.addSubview(icon)
                createConstraints(icon, container: container, size: item.image!.size, yOffset: -5)
                
                container.addSubview(textLabel)
                let textLabelWidth = CGRectGetWidth(tabBar.frame) / CGFloat(tabBar.items!.count) - 5.0
                createConstraints(textLabel, container: container, size: CGSize(width: textLabelWidth, height: 10), yOffset: 16)
                
                let iconsAndLabels = (icon: icon, textLabel: textLabel)
                iconsView.append(iconsAndLabels)
                
                if index == 0 {
                    item.selectedState(icon, textLabel: textLabel)
                }
                
                item.image = nil
                item.title = ""
                index++
            }
        }
    }
    
    func handleTapGesture(gesture: UITapGestureRecognizer) {
        let items = tabBar.items as [AnimatedTabBarItem]
        
        let currentIndex = gesture.view!.tag
        if selectedIndex != currentIndex {
            var animationItem: AnimatedTabBarItem = items[currentIndex]
            var icon = iconsView[currentIndex].icon
            var textLabel = iconsView[currentIndex].textLabel
            
            animationItem.playAnimation(icon, textLabel: textLabel)
            
            let deselelectIcon = iconsView[selectedIndex].icon
            let deselelectTextLabel = iconsView[selectedIndex].textLabel
            let deselectItem = items[selectedIndex]
            deselectItem.deselectAnimation(deselelectIcon, textLabel: deselelectTextLabel)
            
            selectedIndex = gesture.view!.tag
        }
    }
}



/*****************************************
 *
 * Animation
 *
 *****************************************/
protocol TabBarItemAnimationProtocol {
    
    func playAnimation(icon: UIImageView, textLabel: UILabel)
    func deselectAnimation(icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor)
    func selectedState(icon: UIImageView, textLabel: UILabel)
    
}

class TabBarItemAnimation: NSObject, TabBarItemAnimationProtocol {
    
    @IBInspectable var duration: CGFloat = 0.5
    @IBInspectable var textSelectedColor: UIColor = UIColor.blackColor()
    
    func playAnimation(icon: UIImageView, textLabel: UILabel) {
        // subclass implement
    }
    
    func deselectAnimation(icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
        // subclass implement
    }
    
    func selectedState(icon: UIImageView, textLabel: UILabel) {
        // subclass implement
    }
}

/*****************************************
*
* Animation Implementation
*
*****************************************/
class DefaultAnimation: TabBarItemAnimation {
    
    @IBInspectable var iconSelectedColor: UIColor!
    @IBInspectable var image: UIImage!
    @IBInspectable var selectedImage: UIImage?
    
    override func playAnimation(icon : UIImageView, textLabel : UILabel) {
        selectedColor(icon, textLabel: textLabel)
    }
    
    override func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor) {
        
        if (iconSelectedColor != nil) {
            var renderImage = icon.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            icon.image = renderImage
        } else {
            icon.image = self.image
        }
        
        textLabel.textColor = defaultTextColor
    }
    
    override func selectedState(icon : UIImageView, textLabel : UILabel) {
        selectedColor(icon, textLabel: textLabel)
    }
    
    func selectedColor(icon: UIImageView, textLabel : UILabel) {
        
        if iconSelectedColor != nil {
            var renderImage = icon.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        } else if selectedImage != nil {
            icon.image = self.selectedImage!
        }
        
        textLabel.textColor = textSelectedColor
    }
}


