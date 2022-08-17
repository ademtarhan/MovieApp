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

    var presenter: LogInPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapLogIn(_ sender: Any) {
        if ((emailTextField.text?.isEmpty) != nil) && ((passwordTextField.text?.isEmpty) != nil) {
            presenter?.logIn(email: emailTextField.text!, password: passwordTextField.text!)
        }
        print("empty area error")
    }

    @IBAction func didTapSignIn(_ sender: Any) {
        //if ((emailTextField.text?.isEmpty) != nil) && ((passwordTextField.text?.isEmpty) != nil) {
            presenter?.createAccount(withEmail: emailTextField.text!, password: passwordTextField.text!)
        //}
        //print("empty area error")
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
}
