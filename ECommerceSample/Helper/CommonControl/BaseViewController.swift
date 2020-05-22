//
//  BaseViewController.swift
//  ECommerceSample
//
//  Created by Pratik on 18/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var loaderView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func networkActivityIndicator(isVisible: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = isVisible
        }
    }
    
    func showAlert(withTitle title : String = "ECommerceSample", message : String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func displayActivityIndicator(onView : UIView) {
        let containerView = UIView.init(frame: onView.bounds)
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = containerView.center
        DispatchQueue.main.async {
            containerView.addSubview(activityIndicator)
            onView.addSubview(containerView)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        loaderView = containerView
    }
    
    func removeActivityIndicator() {
        DispatchQueue.main.async {
            self.loaderView?.removeFromSuperview()
            self.loaderView = nil
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

