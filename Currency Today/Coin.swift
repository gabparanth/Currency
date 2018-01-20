//
//  Coin.swift
//  Currency Today
//
//  Created by Gabriel Paranthoen on 16/01/2018.
//  Copyright © 2018 Gabriel Paranthoen. All rights reserved.
//

import Foundation
// Query service creates Track objects
class Coin : NSObject{
    
    let id: String
    let name: String
    let symbol: String
    let rank: String
    var viewController: CustomView?
    
    init(id: String, name: String, symbol: String, rank: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.rank = rank
    }
    
}
