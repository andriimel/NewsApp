//
//  NAAlertVCViewController.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 4/9/24.
//

import UIKit

class NAAlertVCViewController: UIViewController {

    let containerView = NAContainerView()
    let titleLabel = NASourceLabel()
    let messageLabel = NASourceLabel()
    let alertButtorn = NANewsButton()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }
    func addSubviews() {
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(alertButtorn)
    }
    
    func configureContainerView() {
        
   
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
    }

    func configureTitleLabel() {
      
        
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    func configureActionButton() {

        
        alertButtorn.setTitle(buttonTitle ?? "Ok", for: .normal)
        alertButtorn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            
            alertButtorn.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            alertButtorn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertButtorn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertButtorn.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
   @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: alertButtorn.topAnchor, constant:  -12)
        ])
    }
}
