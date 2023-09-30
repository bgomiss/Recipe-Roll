//
//  Presenter.swift
//  practice
//
//  Created by aycan duskun on 26.09.2023.
//

import UIKit

//protocol AuthPresenterDelegate: AnyObject {
//    
//}

//typealias PresenterDelegate = AuthPresenterDelegate & UIViewController

class AuthPresenter {
    
    private var view: AuthenticationVC
//    weak var delegate: AuthPresenterDelegate?
    
    init(view: AuthenticationVC) {
        self.view = view
    }
//    public func setViewDelegate(delegate: PresenterDelegate) {
//        self.delegate = delegate
//    }
}
