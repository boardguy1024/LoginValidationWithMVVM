//
//  LoginViewModel.swift
//  LoginValidationWithMVVM
//
//  Created by park kyung suk on 2017/08/27.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModel {
    
    var emailText = Variable<String>("")
    var passwordText = Variable<String>("")
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()) {
            (email, password) in
            
            email.characters.count >= 3 && password.characters.count >= 3
        }
    }
}
