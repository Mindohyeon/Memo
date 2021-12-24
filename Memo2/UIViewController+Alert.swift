//
//  UIViewController+Alert.swift
//  Memo2
//
//  Created by GSM05 on 2021/12/23.
//

import UIKit

extension UIViewController {
    func alert(title : String = "알림", message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title:"확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
