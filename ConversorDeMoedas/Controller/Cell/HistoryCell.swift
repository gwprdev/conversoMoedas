//
//  HistoryCell.swift
//  ConversorDeMoedas
//
//  Created by Gilvan Wemerson on 06/12/23.
//

import UIKit

class HistoryCell: UITableViewCell {
    @IBOutlet weak var lblTitle:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setTitle(title:String) {
        self.lblTitle.text = title
    }
}
