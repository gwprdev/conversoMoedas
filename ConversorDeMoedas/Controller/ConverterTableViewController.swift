//
//  ConverterTableViewController.swift
//  ConversorDeMoedas
//
//  Created by Gilvan Wemerson on 06/12/23.
//

import UIKit

class ConverterTableViewController: UITableViewController {
    public var viewModel:CoinConverterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj:Coin = self.viewModel.getHistoryExchange()[indexPath.row]
        let cell:HistoryCell = tableView.dequeueReusableCell(withIdentifier: "historyExchangeCell", for: indexPath) as! HistoryCell
        cell.setTitle(title: obj.name!)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.coinsHistory = self.viewModel.getHistoryExchange()[indexPath.row]
        self.dismiss(animated: true)
    }
}
