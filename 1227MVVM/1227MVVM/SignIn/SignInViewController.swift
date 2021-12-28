//
//  SignInViewController.swift
//  1227MVVM
//
//  Created by 신상원 on 2021/12/28.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    private var signInViewMoel = SignInViewModel()
    let mainView = SignInView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let logInBefore = UserDefaults.standard.string(forKey: "token") {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: BoardsViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
        
        signInViewMoel.username.bind { text in
            self.mainView.usernameTextField.text = text
        }
        
        signInViewMoel.email.bind { text in
            self.mainView.usermailTextField.text = text
        }
        
        signInViewMoel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        
        mainView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.usermailTextField.addTarget(self, action: #selector(usermailTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        
    }
    
    @objc
    func usernameTextFieldDidChange(_ textfield: UITextField) {
        signInViewMoel.username.value = textfield.text ?? ""
    }
    
    @objc
    func usermailTextFieldDidChange(_ textfield: UITextField) {
        signInViewMoel.email.value = textfield.text ?? ""
    }
    
    @objc
    func passwordTextFieldDidChange(_ textfield: UITextField) {
        signInViewMoel.password.value = textfield.text ?? ""
    }
    
    @objc
    func signInButtonClicked() {
        signInViewMoel.fetchAPI()
        print(UserDefaults.standard.string(forKey: "token") ?? "ERROR")
        print(UserDefaults.standard.string(forKey: "name") ?? "ERROR")
        print(UserDefaults.standard.string(forKey: "id") ?? "ERROR")
        print(UserDefaults.standard.string(forKey: "email") ?? "ERROR")
        DispatchQueue.main.async {
            //로그인을 하면 루트뷰를 아예 바꿔줌
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: BoardsViewController())
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }
    
}

