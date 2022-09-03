//
//  LogInViewController.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import UIKit

protocol LogInViewController: AnyObject {
    var presenter: LogInPresenter? { get set }
    func navigateToHome()
}

class LogInViewControllerImpl: UIViewController, LogInViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var sigInButton: UIButton!
    var presenter: LogInPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI(view: emailTextField)
        setUI(view: logInButton)
        setUI(view: sigInButton)
        setUI(view: passwordTextField)
    }

    @IBAction func didTapLogIn(_ sender: Any) {
        if ((emailTextField.text?.isEmpty) != nil) && ((passwordTextField.text?.isEmpty) != nil) {
            presenter?.logIn(email: emailTextField.text!, password: passwordTextField.text!)
        }
        print("empty area error")
    }

    @IBAction func didTapSignIn(_ sender: Any) {
        presenter?.createAccount(withEmail: emailTextField.text!, password: passwordTextField.text!)
    }
}

extension UIViewController {
    func navigateToHome() {
        DispatchQueue.main.async {
            let homeVC = HomeViewControllerImpl(nibName: "HomeViewController", bundle: nil)
            homeVC.modalPresentationStyle = .fullScreen
            self.present(homeVC, animated: true, completion: nil)
        }
    }
    
    func setUI(view: UIView){
        
        
        UIView.animate(withDuration: 0.5, delay: 0.5) {
            view.center.x -= self.view.bounds.width
        }
        
        
        view.layer.borderColor = UIColor(named: "foreGroundColor")?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
    }
}
