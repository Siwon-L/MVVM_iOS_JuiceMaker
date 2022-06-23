//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

// 과일 저장소 타입
struct FruitStore {
    var strawberryStock: Int
    var bananaStock: Int
    var pineappleStock: Int
    var kiwiStock: Int
    var mangoStock: Int
    
    init(allFruitStock: Int = 10) {
        self.strawberryStock = allFruitStock
        self.bananaStock = allFruitStock
        self.pineappleStock = allFruitStock
        self.kiwiStock = allFruitStock
        self.mangoStock = allFruitStock
    }
}
