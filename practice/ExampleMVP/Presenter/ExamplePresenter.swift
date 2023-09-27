//
//  ExamplePresenter.swift
//  practice
//
//  Created by aycan duskun on 22.09.2023.
//

import Foundation

class ExamplePresenter {
    
    private var view: ExampleViewController
    var recipeModel: Recipe?
    
    init(view: ExampleViewController) {
        self.view = view
    }
    
    //Actions
    
    func requestWebService() {
        //request web service here
        //after of request the webservice the presente can create the Model
        recipeModel = Recipe()
        //Afte of create the model is necessary update the View
        
        view.update()
    }
    
    
}
