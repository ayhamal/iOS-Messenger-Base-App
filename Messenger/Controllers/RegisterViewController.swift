//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Ayham Al Chouhuf on 4/19/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let ScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let ImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
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
    
    private let PasswordConfirmationInputField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Confirm Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let NextStepButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Next", for: .normal)
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
        
        NextStepButton.addTarget(self,
                                 action: #selector(nextRegisterStepButtonTapped),
                                 for: .touchUpInside)
        
        EmailInputField.delegate = self
        PasswordInputField.delegate = self
        PasswordConfirmationInputField.delegate = self
        
        view.addSubview(ScrollView)
        ScrollView.addSubview(ImageView)
        ScrollView.addSubview(EmailInputField)
        ScrollView.addSubview(PasswordInputField)
        ScrollView.addSubview(PasswordConfirmationInputField)
        ScrollView.addSubview(NextStepButton)
        ScrollView.isUserInteractionEnabled = true
        ImageView.isUserInteractionEnabled = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(
                                        target: self, action: #selector(didTapChangeProfilePic)))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ScrollView.frame = view.bounds
        let size = ScrollView.width/3
        ImageView.frame = CGRect(x: (ScrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        ImageView.layer.cornerRadius = ImageView.width/2.0
        EmailInputField.frame = CGRect(x: 30,
                                       y: ImageView.bottom+100,
                                       width: ScrollView.width-60,
                                       height: 52)
        PasswordInputField.frame = CGRect(x: 30,
                                          y: EmailInputField.bottom+20,
                                          width: ScrollView.width-60,
                                          height: 52)
        PasswordConfirmationInputField.frame = CGRect(x: 30,
                                                      y: PasswordInputField.bottom+20,
                                                      width: ScrollView.width-60,
                                                      height: 52)
        NextStepButton.frame = CGRect(x: 30,
                                      y: PasswordConfirmationInputField.bottom+20,
                                      width: ScrollView.width-60,
                                      height: 52)
    }
    
    @objc private func didTapChangeProfilePic(){
        presentPhotoActionSheet()
    }
    
    
    @objc private func nextRegisterStepButtonTapped(){
        EmailInputField.resignFirstResponder()
        PasswordInputField.resignFirstResponder()
        PasswordConfirmationInputField.resignFirstResponder()
        guard let email = EmailInputField.text, let password = PasswordInputField.text, let passwordConfirmation = PasswordConfirmationInputField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6, password == passwordConfirmation else {
            AlertUserRegisterAccountError()
            return
        }
        
        // MARK: - Implement Firebase create account, and move user to next register step
    }
    
    func AlertUserRegisterAccountError() {
        // Send respective error
        
        let alert = UIAlertController(title: "Woooooops!",
                                      message: "Email is a required field! :(",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // MARK: - Implement Responders for Register Form
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: {[weak self] _ in
                                                self?.presentCamera()
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Chose Photo",
                                            style: .default,
                                            handler: {[weak self] _ in
                                                self?.presentPhotoPicker()
                                            }))
        present(actionSheet, animated: true)
    }
    func presentCamera(){
        let uiipvc = UIImagePickerController()
        uiipvc.sourceType = .camera
        uiipvc.delegate = self
        uiipvc.allowsEditing = true
        present(uiipvc, animated: true)
    }
    func presentPhotoPicker(){
        let uiipvc = UIImagePickerController()
        uiipvc.sourceType = .photoLibrary
        uiipvc.delegate = self
        uiipvc.allowsEditing = true
        present(uiipvc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.ImageView.image = selectedImage
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
