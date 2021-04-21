//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Ayham Al Chouhuf on 4/19/21.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isloggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        if !isloggedIn {
            let logingViewController = LoginViewController()
            let navigation = UINavigationController(rootViewController: logingViewController)
            navigation.modalPresentationStyle = .fullScreen
            present(navigation, animated: false)
        }
    }
}
