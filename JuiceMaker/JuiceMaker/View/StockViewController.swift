//
//  StockViewController.swift
//  JuiceMaker
//
//  Created by 이시원 on 2022/06/27.
//

import UIKit
import RxSwift

class StockViewController: UIViewController {
    let viewModel: ViewModel
    var bag = DisposeBag()
    
    @IBOutlet weak var strawberryLabel: UILabel!
    @IBOutlet weak var bananaLabel: UILabel!
    @IBOutlet weak var pineappleLabel: UILabel!
    @IBOutlet weak var kiwiLabel: UILabel!
    @IBOutlet weak var mangoLabel: UILabel!
    
    @IBOutlet weak var strawberryStepper: UIStepper!
    @IBOutlet weak var bananaStepper: UIStepper!
    @IBOutlet weak var pineappleStepper: UIStepper!
    @IBOutlet weak var kiwiStepper: UIStepper!
    @IBOutlet weak var mangoStepper: UIStepper!

    @IBAction func strawberryStepper(with stepper: UIStepper) {
        
        viewModel.stockObservable.onNext(["딸기": Int(stepper.value)])
    }
    @IBAction func bananaStepper(with stepper: UIStepper) {
        viewModel.stockObservable.onNext(["바나나": Int(stepper.value)])
    }
    @IBAction func pineappleStepper(with stepper: UIStepper) {
        viewModel.stockObservable.onNext(["파인애플": Int(stepper.value)])
    }
    @IBAction func kiwiStepper(with stepper: UIStepper) {
        viewModel.stockObservable.onNext(["키위": Int(stepper.value)])
    }
    @IBAction func mangoStepper(with stepper: UIStepper) {
        viewModel.stockObservable.onNext(["망고": Int(stepper.value)])
    }
    
    init?(viewModel: ViewModel, coder: NSCoder) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bined()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func bined() {
        viewModel.editStock
            .subscribe(onNext: { [weak self] value in
                self?.strawberryLabel.text = "\(value.strawberryStock)"
                self?.bananaLabel.text = "\(value.bananaStock)"
                self?.pineappleLabel.text = "\(value.pineappleStock)"
                self?.kiwiLabel.text = "\(value.kiwiStock)"
                self?.mangoLabel.text = "\(value.mangoStock)"
                
                self?.strawberryStepper.value = Double(value.strawberryStock)
                self?.bananaStepper.value = Double(value.bananaStock)
                self?.pineappleStepper.value = Double(value.pineappleStock)
                self?.kiwiStepper.value = Double(value.kiwiStock)
                self?.mangoStepper.value = Double(value.mangoStock)
            })
            .disposed(by: bag)
    }
    
}
