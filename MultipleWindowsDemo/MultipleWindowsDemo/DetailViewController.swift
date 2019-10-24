//
//  DetailViewController.swift
//  MultiWindowTest
//
//  Created by Kévin MAAREK on 24/10/2019.
//  Copyright © 2019 Kévin MAAREK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var restaurant: Restaurant?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let introLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newWindowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open in a new window", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(newWindow), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            button.isHidden = false
        } else {
            button.isHidden = true
        }
        return button
    }()
    
    public convenience init(userActivity: NSUserActivity) {
        let id = userActivity.userInfo!["id"] as? String ?? ""
        let restaurant: Restaurant = DataManager.getItemById(id: id)
        self.init(restaurant: restaurant)
    }
    
    public convenience init(restaurant: Restaurant) {
        self.init(nibName: nil, bundle: nil)
        self.restaurant = restaurant
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.titleLabel.text = self.restaurant?.name
        self.addressLabel.text = self.restaurant?.adress
        self.introLabel.text = self.restaurant?.intro
        self.ratingLabel.text = String(repeating: "⭐️", count: self.restaurant?.rating ?? 1)
    }
    
    func layout() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.addressLabel)
        self.view.addSubview(self.introLabel)
        self.view.addSubview(self.ratingLabel)
        self.view.addSubview(self.newWindowButton)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.addressLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.addressLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.introLabel.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor, constant: 10),
            self.introLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.ratingLabel.topAnchor.constraint(equalTo: self.introLabel.bottomAnchor, constant: 10),
            self.ratingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.newWindowButton.topAnchor.constraint(equalTo: self.introLabel.bottomAnchor, constant: 40),
            self.newWindowButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    @objc func newWindow() {
        if #available(iOS 13.0, *) {
            let activity = NSUserActivity(activityType: MyActivityType.restaurant.rawValue)
            activity.userInfo!["id"] = self.restaurant?.id ?? ""
            UIApplication.shared.requestSceneSessionActivation(nil, userActivity: activity, options: nil, errorHandler: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
