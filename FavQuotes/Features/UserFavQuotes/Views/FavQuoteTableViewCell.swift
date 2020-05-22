//
//  FavQuoteTableViewCell.swift
//  FavQuotes
//
//  Created by Mathis Detourbet on 22/5/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit

protocol FavQuotesPresenter {
    var authorString: String { get }
    var bodyString: String { get }
}

class FavQuoteTableViewCell: UITableViewCell {
    
    public static let identifier = "idFavQuoteTableViewCell"

    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func fill(with favQuotePresenter: FavQuotesPresenter) {
        authorLabel.text = favQuotePresenter.authorString
        bodyLabel.text = favQuotePresenter.bodyString
    }
    
}
