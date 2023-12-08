//
//  CoinConverterViewController.swift
//  ConversorDeMoedas
//
//  Created by Gilvan Wemerson on 06/11/23.
//

import UIKit
import iOSDropDown

class CoinConverterViewController: UIViewController {
    //MARK: IBOUTLET
    @IBOutlet weak var dropDownTo: DropDown!
    @IBOutlet weak var dropDownFrom: DropDown!
    @IBOutlet weak var iblValueConver: UILabel!
    @IBOutlet weak var txtValueInfo: UITextField!
    @IBOutlet weak var btnHistory:UIButton!
    
    //MARK: Vars/Lets
    var keyToExchange:String = String.empty()
    var keyFromExchange: String = String.empty()
    
    //MARK: Private Vars/Lets
    private var coinUsed:Coin!
    
    
    
    //MARK: ViewModel
    private var viewModel: CoinConverterViewModel!
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CoinConverterViewModel()
        self.btnHistory.isHidden = self.viewModel.getHistoryExchange().count <= 0
        self.configDropDown()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let coin = self.viewModel.coinsHistory {
            self.dropDownTo.text = coin.code!
            self.dropDownFrom.text = coin.codein!
            self.txtValueInfo.text = "1"
        }
    }
    
    //MARK: @IBActions
    @IBAction func actionGetCoin(_ sender: UIButton){
        let error:String = self.validateFields()
        if error != String.empty() {
            self.view.showMessage(view: self, message: error)
        }else {
            if let coint = self.viewModel.coinsHistory {
                let valueStr: NSNumber = self.viewModel.calculateCoins(valueInfo: self.txtValueInfo.text!, valueCoin: coint.buyValue)
                self.iblValueConver.text = String().formatCurrency(value: valueStr, enumCoin: self.dropDownFrom.text!)
            }else {
                let param1 = self.dropDownTo.text!
                let param2 = self.dropDownFrom.text!
                
                self.keyToExchange = param1+param2
                self.keyFromExchange = param2+param1
                
                let param:String = "\(param1)-\(param2)"
                self.getCoins(param: param)
            }
            
        }
    }
    
    @IBAction func actionSaveHistory(_ sender: UIButton){
        let error:String = self.validateFields()
        if error != String.empty() {
            self.view.showMessage(view: self, message: error)
        }else {
            if let coin = self.coinUsed {
                self.viewModel.saveHistoryExchange(coin: coin){ message in
                    self.view.showMessage(view: self, message: message)
                }
            }else {
                self.view.showMessage(view: self, message: "Você precisa realizar a conversão, para salvar!")
            }
        }
        self.btnHistory.isHidden = self.viewModel.getHistoryExchange().count <= 0
    }
    
    
    @IBAction func actionShowHistory(_ sender: UIButton){
        self.performSegue(withIdentifier: "history", sender: nil)
    }
    
    //MARK: Private Funcs
    
    private func validateFields() -> String {
        var error:String = ""
        if self.txtValueInfo.text == "" {
            error = "Informe um valor a ser convertido!"
        } else if self.dropDownTo.text == "" || self.dropDownFrom.text == ""{
            error = "Selecione as moeda a serem convertida!"
        } else if self.dropDownTo.text == self.dropDownFrom.text {
            error = "Selecione moedas diferentes!"
        }
        return error
    }
    
    private func getCoins(param:String){
        self.viewModel.getCoins(params:param){ (data, error) in
            if let coins = data {
                DispatchQueue.main.async {
                    self.coinUsed = coins.first!.value
                    let valueStr: NSNumber = self.viewModel.calculateCoins(valueInfo: self.txtValueInfo.text!, valueCoin: self.coinUsed!.buyValue)
                    self.iblValueConver.text = String().formatCurrency(value: valueStr, enumCoin: self.dropDownFrom.text!)                }
                
            }else{
                print("ALGO TÁ NULO")
            }
            
        }
    }
    
    private func configDropDown() {
        self.dropDownTo.optionArray = self.viewModel.getListCoins()
        self.dropDownTo.arrowSize = 5
        self.dropDownTo.selectedRowColor = .black
        
        self.dropDownFrom.optionArray = self.viewModel.getListCoins()
        self.dropDownFrom.arrowSize = 5
        self.dropDownFrom.selectedRowColor = .black
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ConverterTableViewController {
            controller.viewModel = self.viewModel
        }
    }
}
