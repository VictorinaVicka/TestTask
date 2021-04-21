//
//  TabBarController.swift
//  LMTest
//
//  Created by Виктория Воробьева on 19.04.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .systemGreen
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        
        addTabBar()
    }
    
    private func addTabBar() {
        let mainVC = MainViewController(provider: .init())
        let navigator = UINavigationController(rootViewController: mainVC)
        navigator.navigationBar.prefersLargeTitles = true
        navigator.tabBarItem = .init(title: "Главная", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let list = UIViewController()
        list.tabBarItem = .init(title: "Мой список", image: UIImage(systemName: "bookmark"), tag: 1)
        
        let store = UIViewController()
        store.tabBarItem = .init(title: "Магазины", image: UIImage(systemName: "building.columns"), tag: 2)
        
        let profile = UIViewController()
        profile.tabBarItem = .init(title: "Профиль", image: UIImage(systemName: "person"), tag: 3)
        
        let basket = UIViewController()
        basket.tabBarItem = .init(title: "Корзина", image: UIImage(systemName: "cart"), tag: 4)
        viewControllers = [navigator, list, store, profile, basket]
    }
}
