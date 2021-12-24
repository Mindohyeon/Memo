//
//  DetailViewController.swift
//  Memo2
//
//  Created by GSM05 on 2021/12/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var memo : Memo?
    
    let formatter : DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}

extension DetailViewController : UITableViewDataSource {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case  0:
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
        
        cell.textLabel?.text = memo?.content
        
        return cell
    case 1:
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
        
        cell.textLabel?.text = formatter.string(for: memo?.insertDate)
        
        return cell
    default :
        fatalError()
        }
    }
}
