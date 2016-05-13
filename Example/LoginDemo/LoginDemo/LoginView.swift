//
//  LoginView.swift
//  LoginDemo
//
//  Created by dasdom on 13.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

class LoginView: UIView {
  let loginButton: UIButton
  let usernameTextField: UITextField
  let descriptionLabel: UILabel
  let passwordTextField: UITextField
  
  override init(frame: CGRect) {
    loginButton = UIButton(type: .System)
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    loginButton.setTitle("Log me in", forState: .Normal)
    
    
    usernameTextField = UITextField()
    usernameTextField.placeholder = "Username"
    usernameTextField.font = UIFont.systemFontOfSize(14)
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    usernameTextField.borderStyle = .RoundedRect
    usernameTextField.textAlignment = .Center
    usernameTextField.minimumFontSize = 17
    
    descriptionLabel = UILabel()
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.textAlignment = .Center
    descriptionLabel.text = "Please log in"
    descriptionLabel.setContentHuggingPriority(251, forAxis: .Horizontal)
    descriptionLabel.font = UIFont(name: "HoeflerText-Regular", size: 30)
    
    passwordTextField = UITextField()
    passwordTextField.placeholder = "Password"
    passwordTextField.font = UIFont.systemFontOfSize(14)
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.borderStyle = .RoundedRect
    passwordTextField.textAlignment = .Center
    passwordTextField.minimumFontSize = 17
    
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
    
    addSubview(loginButton)
    addSubview(usernameTextField)
    addSubview(descriptionLabel)
    addSubview(passwordTextField)
    
    let loginViewMargins = layoutMarginsGuide
    
    usernameTextField.leadingAnchor.constraintEqualToAnchor(descriptionLabel.leadingAnchor).active = true
    passwordTextField.topAnchor.constraintEqualToAnchor(usernameTextField.bottomAnchor, constant: 8).active = true
    loginButton.trailingAnchor.constraintEqualToAnchor(passwordTextField.trailingAnchor).active = true
    descriptionLabel.trailingAnchor.constraintEqualToAnchor(loginViewMargins.trailingAnchor).active = true
    passwordTextField.trailingAnchor.constraintEqualToAnchor(usernameTextField.trailingAnchor).active = true
    descriptionLabel.leadingAnchor.constraintEqualToAnchor(loginViewMargins.leadingAnchor).active = true
    loginButton.leadingAnchor.constraintEqualToAnchor(passwordTextField.leadingAnchor).active = true
    passwordTextField.leadingAnchor.constraintEqualToAnchor(usernameTextField.leadingAnchor).active = true
    loginButton.topAnchor.constraintEqualToAnchor(passwordTextField.bottomAnchor, constant: 8).active = true
    usernameTextField.trailingAnchor.constraintEqualToAnchor(descriptionLabel.trailingAnchor).active = true
    usernameTextField.topAnchor.constraintEqualToAnchor(descriptionLabel.bottomAnchor, constant: 8).active = true
  }
  
  convenience required init(coder aDecoder: NSCoder) {
    self.init()
  }
  
}

extension LoginViewController {
  override func loadView() {
    view = LoginView()
  }
  
  func setLayoutGuideConstraints() {
    let contentView = view as! LoginView
    contentView.descriptionLabel.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8).active = true
  }
}
