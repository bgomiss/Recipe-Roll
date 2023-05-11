//
//  CoordinatorProtocol.swift
//  practice
//
//  Created by aycan duskun on 11.05.2023.
//
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func childDidFinish(_ child: Coordinator)
}

