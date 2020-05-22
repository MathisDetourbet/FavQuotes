//
//  FavQuoteDetailsViewController.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 22/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit

final class FavQuoteDetailsViewController: UIViewController {
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var dialogueLabel: UILabel!
    @IBOutlet private weak var privateLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var authorPermaLinkLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var favoritesCountLabel: UILabel!
    @IBOutlet private weak var downVotesCountLabel: UILabel!
    @IBOutlet private weak var bodyTextView: UITextView!
    
    private let viewModel: QuoteDetailsViewModel
    
    init(viewModel: QuoteDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
    }
    
    private func buildUI() {
        idLabel.text = viewModel.idString
        dialogueLabel.text = viewModel.dialogueString
        privateLabel.text = viewModel.privateString
        authorLabel.text = viewModel.authorString
        authorPermaLinkLabel.text = viewModel.authorPermaLinkString
        tagsLabel.text = viewModel.tagsString
        urlLabel.text = viewModel.urlStrigng
        favoritesCountLabel.text = viewModel.favoritesCountString
        downVotesCountLabel.text = viewModel.downVotesCountString
        bodyTextView.text = viewModel.bodyString
    }
}
