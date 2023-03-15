//
//  Tableview+Ext.swift
//  practice
//
//  Created by aycan duskun on 15.03.2023.
//

import UIKit

extension UITableView {
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
