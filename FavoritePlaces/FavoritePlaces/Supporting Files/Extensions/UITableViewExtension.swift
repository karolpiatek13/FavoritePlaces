//
//  TableViewExtension.swift
//  FavoritePlaces
//
//  Created by Karol on 02.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

extension UITableView {
    
    func getReusableCellSafe(cellType: AnyClass) -> UITableViewCell {
        var cell = self.dequeueReusableCell(withIdentifier: String(describing: cellType))
        if(cell == nil){
            let className = String(describing:cellType)
            self.register(UINib(nibName:  className, bundle: nil),
                          forCellReuseIdentifier:  className)
            cell = self.dequeueReusableCell(withIdentifier: String(describing: cellType))
        }
        return cell!
    }
}
