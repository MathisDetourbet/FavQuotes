//
//  LoginViewController.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoginRouting: class {
    func dismiss()
    func loginSuccess()
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private weak var routingDelegate: LoginRouting?
    private weak var loginDelegate: LoginDelegate?
    private let loginViewModel: LoginViewModel
    
    init(viewModel: LoginViewModel, routingDelegate: LoginRouting) {
        self.loginViewModel = viewModel
        self.routingDelegate = routingDelegate
        self.loginDelegate = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
    }
    
    private func buildUI() {
        setupNavBar()
        setupOutlets()
        bindToViewModel()
    }
    
    private func setupOutlets() {
        loginTextField.delegate = self
        loginTextField.placeholder = "login or email"
        loginTextField.returnKeyType = .default
        loginTextField.keyboardType = .emailAddress
        
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "password"
    }
    
    private func bindToViewModel() {
        loginTextField.rx.text
            .orEmpty
            .bind(to: loginViewModel.loginSubject)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: loginViewModel.passwordSubject)
            .disposed(by: disposeBag)
        
        loginViewModel.isValidObs
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginViewModel.isUserLoggedSubject
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] userIsLoggedIn in
                if userIsLoggedIn {
                    self?.routingDelegate?.loginSuccess()
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupNavBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        view.addSubview(navBar)
        
        let navItem = UINavigationItem()
        let dismissItem = UIBarButtonItem(title: "Dismiss", style: .done, target: self, action: #selector(dismissButtonTouched))
        navItem.rightBarButtonItem = dismissItem
        
        navBar.setItems([navItem], animated: true)
    }
    
    @objc private func dismissButtonTouched() {
        routingDelegate?.dismiss()
    }
    
    @IBAction private func loginButtonTouched(_ sender: UIButton) {
        loginDelegate?.userWantsToLogin()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
