//
//  ViewController.swift
//  LoginValidationWithMVVM
//
//  Created by park kyung suk on 2017/08/27.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginEnabledLabel: UILabel!
    
    let bag = DisposeBag()
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindToViewModel()
        
        //ViewModelのisValidを購読する
        loginViewModel.isValid.subscribe(onNext: { isValid in
            
            if isValid {
                self.loginEnabledLabel.text = "Enabled"
                self.loginEnabledLabel.textColor = .green
                self.loginButton.backgroundColor = UIColor(red: 143/255, green: 210/255, blue: 200/255, alpha: 1)
                self.loginButton.setTitleColor(.white, for: .normal)
            } else {
                self.loginEnabledLabel.text = "Not Enabled"
                self.loginEnabledLabel.textColor = .red
                self.loginButton.backgroundColor = .gray
                self.loginButton.setTitleColor(.darkGray, for: .normal)
            }
        }).addDisposableTo(bag)
        
    }
    
    func bindToViewModel() {
        
        emailTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.emailText).addDisposableTo(bag)
        passwordTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.passwordText).addDisposableTo(bag)
        //ViewModelのisValidとlogInButtonのisValidをbindする！！
        loginViewModel.isValid.bind(to: loginButton.rx.isEnabled).addDisposableTo(bag)
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

