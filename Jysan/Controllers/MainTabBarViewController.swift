//
//  MainTabBarViewController.swift
//  Jysan
//
//  Created by ryan on 6/21/21.
//

import UIKit
import SnapKit

class MainTabBarViewController: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate = self
        setupTabBar()
        view.backgroundColor = #colorLiteral(red: 0.7890606523, green: 0.7528427243, blue: 0.7524210811, alpha: 1)
    }

    private func setupTabBar() {
        tabBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.tintColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        tabBar.layer.borderWidth = 0.50
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.clipsToBounds = true
        let mvVC = UINavigationController(rootViewController:MoviesViewController())
        mvVC.tabBarItem.title = "Фильмы"

        let genresVC = UINavigationController(rootViewController:GenresViewController())
        genresVC.tabBarItem.title = "Жанры"

        viewControllers = [mvVC, genresVC]

        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        }

    }
}
