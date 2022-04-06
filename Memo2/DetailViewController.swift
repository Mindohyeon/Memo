//
//  DetailViewController.swift
//  Memo2
//
//  Created by GSM05 on 2021/12/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var memo : Memo?
    
    @IBOutlet weak var memoTableView: UITableView!
    

    let formatter : DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    

    @IBAction func deleteMemo(_ sender: Any) {
        let alert = UIAlertController(title: "메모 삭제", message: "메모를 삭제하시겠습니까?", preferredStyle: .alert)
        
        // style 을 destructive 로 하면 text 가 빨간색으로 표시된다.
        let okAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] (action) in
            DataManager.shared.deleteMemo(self?.memo)
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ComposeViewController {
            vc.editTarget = memo
        }
    }
    
    var token : NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        token = NotificationCenter.default.addObserver(forName: ComposeViewController.memoDidChange, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            self?.memoTableView.reloadData()
        })
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
