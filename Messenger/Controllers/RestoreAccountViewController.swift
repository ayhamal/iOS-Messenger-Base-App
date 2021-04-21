//
//  RestoreAccountViewController.swift
//  Messenger
//
//  Created by Ayham Al Chouhuf on 4/19/21.
//

import UIKit

class RestoreAccountViewController: UIViewController {
    
    private let ScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()

    private let ImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let EmailInputField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Adress"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let RestoreAccountButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Send Request", for: .normal)
        btn.backgroundColor = .link
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        RestoreAccountButton.addTarget(self,
                                       action: #selector(restoreAccountButtonTapped),
                                       for: .touchUpInside)
                
        EmailInputField.delegate = self

        view.addSubview(ScrollView)
        ScrollView.addSubview(ImageView)
        ScrollView.addSubview(EmailInputField)
        ScrollView.addSubview(RestoreAccountButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ScrollView.frame = view.bounds
        let size = ScrollView.width/3
        ImageView.frame = CGRect(x: (ScrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        EmailInputField.frame = CGRect(x: 30,
                                       y: ImageView.bottom+100,
                                       width: ScrollView.width-60,
                                       height: 52)
        RestoreAccountButton.frame = CGRect(x: 30,
                                            y: EmailInputField.bottom+20,
                                            width: ScrollView.width-60,
                                            height: 52)
    }
    
    @objc private func restoreAccountButtonTapped(){
        EmailInputField.resignFirstResponder()
        guard let email = EmailInputField.text,
              !email.isEmpty else {
            AlertUserRestoreAccountError()
            return
        }
        
        // Firebase request restor account link
    }
    
    func AlertUserRestoreAccountError() {
        let alert = UIAlertController(title: "Woooooops!",
                                      message: "Email is a required field! :(",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
}


extension RestoreAccountViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
