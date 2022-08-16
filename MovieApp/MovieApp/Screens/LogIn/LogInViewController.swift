//
//  LogInViewController.swift
//  MovieApp
//
//  Created by Adem Tarhan on 16.08.2022.
//

import UIKit

protocol LogInViewController: AnyObject {
    var presenter: LogInPresenter? { get set }
}

class LogInViewControllerImpl: UIViewController, LogInViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var presenter: LogInPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func didTapLogIn(_ sender: Any) {
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
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
