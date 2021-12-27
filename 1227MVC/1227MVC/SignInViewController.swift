//
//  SignInViewController.swift
//  1227MVC
//
//  Created by 신상원 on 2021/12/27.
//

import UIKit

class SignInViewController: UIViewController {
    
    let mainView = SignInView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //만약 이전에 회원가입을 했다면 바로 메인화면으로 넘어갈 수 있도록 설정
        if let logInBefore = UserDefaults.standard.string(forKey: "token") {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
        mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func signInButtonClicked() {
        APIService.signin(username: mainView.usernameTextField.text!, email: mainView.usermailTextField.text!, password: mainView.passwordTextField.text!) { userData, error in
            if let userData = userData {
                print(userData.jwt)
                print(userData.user.username)
                print(userData.user.id)
                print(userData.user.email)
                
                UserDefaults.standard.set(userData.jwt, forKey: "token")
                UserDefaults.standard.set(userData.user.username, forKey: "nickname")
                UserDefaults.standard.set(userData.user.id, forKey: "id")
                UserDefaults.standard.set(userData.user.email, forKey: "email")
                
                DispatchQueue.main.async {
                    self.showAlert(title: "SUCCESS", message: "Your Account") {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                        windowScene.windows.first?.makeKeyAndVisible()
                    }
                }
            } else { //Error 상태에 따라 얼럿 설정
                guard let error = error else { return }
                DispatchQueue.main.async {
                    switch error {
                    case .errorCode:
                        self.showAlert(title: "ERROR CODE", message: "") {
                            print("ERROR")
                        }
                    case .failed:
                        self.showAlert(title: "FAILED", message: "") {
                            print("FAIL")
                        }
                    case .noData:
                        self.showAlert(title: "NO DATA", message: "") {
                            print("NO DATA")
                        }
                    case .decodeFail:
                        self.showAlert(title: "DECODE FAIL", message: "") {
                            print("DECODE FAIL")
                        }
                    }
                }
            }
        }
    }
}
