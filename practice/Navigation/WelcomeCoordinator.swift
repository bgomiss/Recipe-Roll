//
//  WelcomeCoordinator.swift
//  practice
//
//  Created by aycan duskun on 11.05.2023.
//

import UIKit

class WelcomeCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = WelcomeVC()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func didFinishWelcome() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func navigateToSignIn() {
        let signinVC = SignInVC()
        signinVC.coordinator = self
        navigationController.pushViewController(signinVC, animated: true)
    }
    
    func navigateToSignUp() {
        let signupVC = SignInVC()
        signupVC.coordinator = self
        navigationController.pushViewController(signupVC, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator) {
            for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
}
