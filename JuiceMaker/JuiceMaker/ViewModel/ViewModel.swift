//
//  ViewModel.swift
//  JuiceMaker
//
//  Created by 이시원 on 2022/06/23.
//

import Foundation
import RxSwift

class ViewModel {
    typealias Juice = JuiceMaker.Juice
    
    let juiceMaker = JuiceMaker()
    
    let orderObservable = PublishSubject<Juice?>()
    var stockObservable = BehaviorSubject<[String: Int]?>(value: nil)

    lazy var editStock = stockObservable
        .compactMap({ [weak self] dic -> FruitStore? in
            dic?.forEach({ [weak self] (key, value) in
                self?.juiceMaker.addStock(fruit: key, value: value)
            })
            return self?.juiceMaker.fruitStore
        })
    
    lazy var fruitStock = orderObservable
        .compactMap { [weak self] _ in
            self?.juiceMaker.fruitStore
        }
    
    lazy var orderMenu = orderObservable
        .map { [weak self] juice -> Juice? in
            guard let juice = juice else { return nil }
            return self?.juiceMaker.makeJuice(menu: juice)
        }
        .map { juice -> String in
            guard let juice = juice else { return "품절" }
            switch juice {
            case .strawberryJuice:
                return "딸기 주스 나왔습니다."
            case .bananaJuice:
                return "바나나 주스 나왔습니다."
            case .pineappleJuice:
                return "파인애플 주스 나왔습니다."
            case .kiwiJuice:
                return "키위 주스 나왔습니다."
            case .mangoJuice:
                return "망고 주스 나왔습니다."
            case .strawberryAndBananaJuice:
                return "딸바 주스 나왔습니다."
            case .mangoAndKiwiJuice:
                return "망키 주스 나왔습니다."
            }
        }
}
