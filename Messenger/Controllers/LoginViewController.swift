//
//  ViewController.swift
//  Messenger
//
//  Created by Ayham Al Chouhuf on 4/19/21.
//

import UIKit

class LoginViewController: UIViewController {
    
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
    
    private let PasswordInputField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let LoginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Log In", for: .normal)
        btn.backgroundColor = .link
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return btn
    }()
    
    private let ForgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot your password?"
        label.textColor = .link
        label.backgroundColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        LoginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        
        self.setupLabelTap()
        
        ForgotPasswordLabel.isUserInteractionEnabled = true
        ForgotPasswordLabel.addGestureRecognizer(
            UIGestureRecognizer(target: self,
                                action: #selector(labelForgotPasswordTapped)))
        
        EmailInputField.delegate = self
        PasswordInputField.delegate = self
        
        view.addSubview(ScrollView)
        ScrollView.addSubview(ImageView)
        ScrollView.addSubview(EmailInputField)
        ScrollView.addSubview(PasswordInputField)
        ScrollView.addSubview(LoginButton)
        ScrollView.addSubview(ForgotPasswordLabel)
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
        PasswordInputField.frame = CGRect(x: 30,
                                          y: EmailInputField.bottom+20,
                                          width: ScrollView.width-60,
                                          height: 52)
        LoginButton.frame = CGRect(x: 30,
                                   y: PasswordInputField.bottom+20,
                                   width: ScrollView.width-60,
                                   height: 52)
        ForgotPasswordLabel.frame = CGRect(x: ScrollView.width/4+20,
                                           y: LoginButton.bottom+20,
                                           width: ScrollView.width,
                                           height: 52)
    }
    
    @objc private func loginButtonTapped(){
        EmailInputField.resignFirstResponder()
        PasswordInputField.resignFirstResponder()
        guard let email = EmailInputField.text, let password = PasswordInputField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            AlertUserLoginError()
            return
        }
        
        // Firebase login
    }
    
    @objc private func labelForgotPasswordTapped(_ sender: UITapGestureRecognizer){
        let ravc = RestoreAccountViewController()
        ravc.title = "Restore Account"
        navigationController?.pushViewController(ravc, animated: true)
    }

    @objc private func didTapRegister(){
        let rvc = RegisterViewController()
        rvc.title = "Create Account"
        navigationController?.pushViewController(rvc, animated: true)
    }
    
    func setupLabelTap(){
        let labelTap = UITapGestureRecognizer(target: self,
                                              action: #selector(labelForgotPasswordTapped(_:)))
        ForgotPasswordLabel.isUserInteractionEnabled = true
        ForgotPasswordLabel.addGestureRecognizer(labelTap)
    }
    
    func AlertUserLoginError(){
        let alert = UIAlertController(title: "Woooooops!",
                                      message: "Email or Password are incorrect! :(",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == EmailInputField{
            PasswordInputField.becomeFirstResponder()
        }else if textField == PasswordInputField{
            loginButtonTapped()
        }
        return true
    }
}
