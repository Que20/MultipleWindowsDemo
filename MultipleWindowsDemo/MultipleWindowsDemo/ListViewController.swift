//
//  ListViewController.swift
//  MultiWindowTest
//
//  Created by Kévin MAAREK on 24/10/2019.
//  Copyright © 2019 Kévin MAAREK. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.layout()
    }
    
    private func layout() {
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            let restaurant = DataManager.data[indexPath.row]
            cell.textLabel?.text = restaurant.name
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailViewController(restaurant: DataManager.data[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let userActivity = NSUserActivity(activityType: MyActivityType.restaurant.rawValue)
        userActivity.userInfo!["id"] = DataManager.data[indexPath.row].id
        let itemProvider = NSItemProvider()
        itemProvider.registerObject(userActivity, visibility: .all)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }

}

