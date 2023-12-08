//
//  UIView.swift
//  ConversorDeMoedas
//
//  Created by Gilvan Wemerson on 05/12/23.
//

import UIKit

extension UIView {
    public func showMessage(view:UIViewController,message:String, title:String = "Atenção", btnTitle:String = "OK"){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: nil))
        view.present(alert, animated: true)
    }
}
