//
//  Coordinator.swift
//  NewsAPI
//
//  Created by Kareem Ahmed on 21/05/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
