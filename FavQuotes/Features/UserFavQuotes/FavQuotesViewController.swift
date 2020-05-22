//
//  UserFavQuotesViewController.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 19/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit
import RxSwift

protocol FavQuotesRouting: class {
    func showLogin()
}

final class FavQuotesViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: FavQuotesViewModel
    public weak var routingDelegate: FavQuotesRouting?
    private weak var tableView: UITableView?
    
    init(viewModel: FavQuotesViewModel, routingDelegate: FavQuotesRouting) {
        self.viewModel = viewModel
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
        bindToViewModel()
    }
    
    private func buildUI() {
        tableView = makeTableView()
    }
    
    private func bindToViewModel() {
        viewModel.needsReloadFavQuotesObs.asDriver(onErrorJustReturn: ()).drive(onNext: { [weak self] (_) in
            self?.tableView?.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.isUserLoggedObs.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] isLogged in
            if isLogged {
                self?.navigationItem.rightBarButtonItem = nil
            } else {
                self?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(self?.loginBarButtonTouched))
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func loginBarButtonTouched() {
        routingDelegate?.showLogin()
    }
}

extension FavQuotesViewController {
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
        
        let favQuoteTableViewCellNib = UINib(nibName: String(describing: FavQuoteTableViewCell.self), bundle: nil)
        tableView.register(favQuoteTableViewCellNib, forCellReuseIdentifier: FavQuoteTableViewCell.identifier)
        
        return tableView
    }
}

extension FavQuotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowIn(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavQuoteTableViewCell.identifier, for: indexPath) as? FavQuoteTableViewCell else {
            fatalError("Error dequeue reusable cell. Identifier might be wrong.")
        }
        
        let favQuotePresenter = viewModel.elementAt(indexPath)
        cell.fill(with: favQuotePresenter)
        
        return cell
    }
}

extension FavQuotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
