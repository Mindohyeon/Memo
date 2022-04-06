//
//  ComposeViewController.swift
//  Memo2
//
//  Created by GSM05 on 2021/12/23.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var editTarget : Memo?
    var originalContent : String?
    
    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let memo = editTarget {
            navigationItem.title = "메모 편집"
            memoTextView.text = memo.content
            originalContent = memo.content
        } else {
            navigationItem.title = "새 메모"
            memoTextView.text = ""
        }

        memoTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.presentationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.presentationController?.delegate = nil
    }
    
    
    
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let memo = memoTextView.text, memo.count > 0 else {
            alert(message: "메모를 입력하세요.")
            return
        }
//        let newMemo = Memo(content: memo)
//        Memo.dummyMemoList.append(newMemo)
        
        if let target = editTarget {
            target.content = memo
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: ComposeViewController.memoDidChange, object: nil)
        } else {
            DataManager.shared.addNewMemo(memo)
            
            NotificationCenter.default.post(name: ComposeViewController.newMemoDidInsert, object: nil)

        }
    
        
        dismiss(animated: true, completion: nil)
    }


}

extension ComposeViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let original = originalContent, let edited = textView.text {
            isModalInPresentation = original != edited
            
        }
    }
}

extension  ComposeViewController : UIAdaptivePresentationControllerDelegate {
    
    //창을 조금 내렸을 때
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        let alert = UIAlertController(title: "알림", message: "편집한 내용을 저장할까요?", preferredStyle: .alert)
        
        //확인 버튼을 클릭하면 {}실행됨.
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] (action) in
            self?.save(action)
        }
        alert.addAction(okAction)
        
        let cancelActioin = UIAlertAction(title: "취소", style: .cancel) {[weak self] (action) in
            self?.close(action)
        }
        alert.addAction(cancelActioin)
        
        //alert 띄우기
        present(alert, animated: true, completion: nil)
    }
}


extension ComposeViewController {
    static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}

