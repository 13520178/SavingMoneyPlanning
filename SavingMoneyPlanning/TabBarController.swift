//
//  TabBarController.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 9/12/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarItems = self.tabBar.items! as [UITabBarItem]
        tabBarItems[0].title = nil
        tabBarItems[0].imageInsets = UIEdgeInsets(top: 6,left: 0,bottom: -6,right: 0)
        
        tabBarItems[1].title = nil
        tabBarItems[1].imageInsets = UIEdgeInsets(top: 6,left: 0,bottom: -6,right: 0)
        
        
        
    }
    

}
