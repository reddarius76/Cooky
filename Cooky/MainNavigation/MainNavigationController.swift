//
//  MainNavigationController.swift
//  Cooky
//
//  Created by Oleg Krikun on 01.03.2021.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        URLCache.shared.diskCapacity = 52428800
        //URLCache.shared.removeAllCachedResponses()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func setupUI() {
        navigationBar.topItem?.title = "Cooky"
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Chalkboard SE Light", size: 24.0)!
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Chalkboard SE Light", size: 24.0)!
        ]
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .black
        navigationBar.tintColor = .orange
    }
}
