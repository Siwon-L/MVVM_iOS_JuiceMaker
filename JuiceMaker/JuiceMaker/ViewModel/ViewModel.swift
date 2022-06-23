//
//  ViewModel.swift
//  JuiceMaker
//
//  Created by 이시원 on 2022/06/23.
//

import Foundation
import Combine

class ViewModel {
    var juiceMaker = JuiceMaker()
    
    struct Input {
        let order: AnyPublisher<JuiceMaker.Juice?, Never>
    }
    
    struct OutPut {
        let menu: AnyPublisher<String?, Never>
        //let stock AnyPublisher<[String: Int], Never>
    }
    
    func changeJuiceToString(input: Input) -> OutPut {
        let juice = input.order.map { juice -> String? in
            guard let juice = juice else { return nil }
            guard let output = self.juiceMaker.makeJuice(menu: juice) else {
                return "품절입니다."
            }
            switch output {
            case .strawberryJuice:
                return "딸기 쥬스"
            case .bananaJuice:
                return "바나나 쥬스"
            case .pineappleJuice:
                return "파인애플 쥬스"
            case .kiwiJuice:
                return "키위 쥬스"
            case .mangoJuice:
                return "망고 쥬스"
            case .strawberryAndBananaJuice:
                return "딸바 쥬스"
            case .mangoAndKiwiJuice:
                return "망키 쥬스"
            }
        }.eraseToAnyPublisher()
        return OutPut(menu: juice)
    }
    
}
