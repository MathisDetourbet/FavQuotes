//
//  UserFavQuotesViewController.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit

protocol UserFavQuotesRouting: class {
    func showLogin()
}

final class UserFavQuotesViewController: UIViewController {
    
    public weak var routingDelegate: UserFavQuotesRouting?
    private weak var tableView: UITableView?
    
    init(routingDelegate: UserFavQuotesRouting) {
        self.routingDelegate = routingDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
    }
    
    private func buildUI() {
        tableView = makeTableView()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(loginBarButtonTouched))
    }
    
    @objc func loginBarButtonTouched() {
        routingDelegate?.showLogin()
    }
}

extension UserFavQuotesViewController {
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
        
        return tableView
    }
}

extension UserFavQuotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError()
    }
}

extension UserFavQuotesViewController: UITableViewDelegate {
    
}
