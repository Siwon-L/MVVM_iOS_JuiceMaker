//
//  ViewModel.swift
//  JuiceMaker
//
//  Created by 이시원 on 2022/06/23.
//

import Foundation
import RxSwift

class ViewModel {
    let juiceMaker = JuiceMaker()
    
    var orderObservable = BehaviorSubject<JuiceMaker.Juice?>(value: nil)
    
    lazy var fruitStock = orderObservable
        .map { [weak self] _ in
            self?.juiceMaker.fruitStore
        }
    
    lazy var orderMenu = orderObservable
        .map { [weak self] juice -> JuiceMaker.Juice? in
            guard let juice = juice else { return nil }
            return self?.juiceMaker.makeJuice(menu: juice)
        }
        .map { juice -> String? in
            guard let juice = juice else { return nil }
            switch juice {
            case .strawberryJuice:
                return "딸기 주스"
            case .bananaJuice:
                return  "바나나 주스"
            case .pineappleJuice:
                return "파인애플 주스"
            case .kiwiJuice:
                return "키위 주스"
            case .mangoJuice:
                return "망고 주스"
            case .strawberryAndBananaJuice:
                return "딸바 주스"
            case .mangoAndKiwiJuice:
                return "망키 주스"
            }
        }
}
