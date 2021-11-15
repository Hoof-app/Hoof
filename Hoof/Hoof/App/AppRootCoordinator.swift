//
//  AppRootCoordinator.swift
//  Hoof
//
//  Created by Sameh Mabrouk on 10/11/2021.
//

import UIKit
import Core
import RxSwift
import Home
import Map

class AppRootCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    private let tabBarController: UITabBarController
    private var homeCoordinator: BaseCoordinator<Void>!
    private var mapCoordinator: BaseCoordinator<Void>!
    private let homeModuleBuilder: HomeModuleBuildable
    private let mapModuleBuilder: MapModuleBuildable

    init(window: UIWindow, homeModuleBuilder: HomeModuleBuildable, mapModuleBuilder: MapModuleBuildable) {
        self.window = window
        self.homeModuleBuilder = homeModuleBuilder
        self.mapModuleBuilder = mapModuleBuilder
        tabBarController = UITabBarController()
    }
    
    override func start() -> Observable<Void> {
        let navController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        guard let homeCoordinator: BaseCoordinator<Void> = homeModuleBuilder.buildModule(with: navController)?.coordinator else {
            preconditionFailure("[AppCoordinator] Cannot get homeModuleBuilder from module builder")
        }
                
        // tab bar images
        let homeTabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "Home"), selectedImage: #imageLiteral(resourceName: "Home-selected"))
        navController.tabBarItem = homeTabBarItem
        
        self.homeCoordinator = homeCoordinator
        _ = homeCoordinator.start()
        
        
        let mapNavController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        guard let mapCoordinator: BaseCoordinator<Void> = mapModuleBuilder.buildModule(with: mapNavController)?.coordinator else {
            preconditionFailure("[AppCoordinator] Cannot get mapModuleBuilder from module builder")
        }
        
        let mapTabBarItem = UITabBarItem(title: "Map", image: #imageLiteral(resourceName: "Map"), selectedImage: #imageLiteral(resourceName: "Map"))
        mapNavController.tabBarItem = mapTabBarItem
        
        self.mapCoordinator = mapCoordinator
        _ = mapCoordinator.start()
        
        let navController2 = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        navController2.setViewControllers([UIViewController()], animated: true)
        
        let navController3 = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        navController3.setViewControllers([UIViewController()], animated: true)
        
        let navController4 = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        navController4.setViewControllers([UIViewController()], animated: true)

        // TabBar Appearance
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 1.0)], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)], for: .selected)
        
        tabBarController.setViewControllers([navController, mapNavController], animated: false)
        window.rootViewController = tabBarController
        
        return .never()
    }
}