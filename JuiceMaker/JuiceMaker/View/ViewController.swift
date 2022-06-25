//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    typealias JuiceName = JuiceMaker.Juice
    
    let viewModel = ViewModel()
    var bag = DisposeBag()
    
    @IBOutlet weak var strawberryLabel: UILabel!
    @IBOutlet weak var bananaLabel: UILabel!
    @IBOutlet weak var pineappleLabel: UILabel!
    @IBOutlet weak var kiwiLabel: UILabel!
    @IBOutlet weak var magoLabel: UILabel!
    
    @IBOutlet weak var strawberryJuiceButton: UIButton!
    @IBOutlet weak var bananaJuiceButton: UIButton!
    @IBOutlet weak var pineappleJuiceButton: UIButton!
    @IBOutlet weak var kiwiJuiceButton: UIButton!
    @IBOutlet weak var mangoJuiceButton: UIButton!
    @IBOutlet weak var strawberryAndBananaJuiceButton: UIButton!
    @IBOutlet weak var mangoAndKiwiJuiceButton: UIButton!
    
    lazy var buttonGroup :[UIButton: JuiceName] = [strawberryJuiceButton: .strawberryJuice,
                                                   bananaJuiceButton: .bananaJuice,
                                                pineappleJuiceButton: .pineappleJuice,
                                                     kiwiJuiceButton: .kiwiJuice,
                                                    mangoJuiceButton: .mangoJuice,
                                      strawberryAndBananaJuiceButton: .strawberryAndBananaJuice,
                                             mangoAndKiwiJuiceButton: .mangoAndKiwiJuice]

    override func viewDidLoad() {
        super.viewDidLoad()
        bined()
    }
    @IBAction func orderButtonDidTapped(_ sender: UIButton) {
        guard let juice = buttonGroup[sender] else { return }
        viewModel.orderObservable.onNext(juice)
    }
    
    func bined() {
        viewModel.orderMenu
            .subscribe(onNext: { [weak self] value in
                guard let value = value else { return }
                let alertController = UIAlertController(title: value, message: nil, preferredStyle: .alert)
                alertController.addAction(.init(title: "확인", style: .default))
                self?.present(alertController, animated: true, completion: nil)
            }).disposed(by: bag)
        
        viewModel.fruitStock
            .subscribe(onNext: { [weak self] value in
                guard let value = value else { return }
                self?.strawberryLabel.text = "\(value.strawberryStock)"
                self?.bananaLabel.text = "\(value.bananaStock)"
                self?.pineappleLabel.text = "\(value.pineappleStock)"
                self?.kiwiLabel.text = "\(value.kiwiStock)"
                self?.magoLabel.text = "\(value.mangoStock)"
            })
            .disposed(by: bag)
    }
}
