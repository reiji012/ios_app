//
//  ViewController.swift
//  DiaryApp
//
//  Created by ailesdor on 2018/06/07.
//  Copyright © 2018年 ailesdor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {



    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var diaryTitle: UITextField!
    @IBOutlet weak var diaryContent: UITextView!
    
    var dTitle: String?
    var dContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        diaryContent.layer.borderColor = UIColor.gray.cgColor
        diaryTitle.layer.borderColor = UIColor.gray.cgColor
        // 枠の幅
        diaryContent.layer.borderWidth = 1.0
        diaryTitle.layer.borderWidth = 1.0

        // 枠を角丸にする場合
        diaryContent.layer.cornerRadius = 10.0
        diaryContent.layer.masksToBounds = true
        diaryTitle.layer.cornerRadius = 10.0
        diaryTitle.layer.masksToBounds = true

        if let title = self.dTitle, let content = self.dContent {
            self.diaryTitle.text = title
            self.diaryContent.text = content
            self.navigationItem.title = "Diary"
        }
        self.updateSaveButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateSaveButton() {
        let title = self.diaryTitle.text ?? ""
        self.saveButton.isEnabled = !title.isEmpty
    }
    
    
    @IBAction func titleTextFieldVhanged(_ sender: Any) {
        self.updateSaveButton()
    }
    
    @IBAction func cansel(_ sender: Any) {
        //追加する画面でのキャンセル
        if self.presentingViewController is UINavigationController{
            dismiss(animated: true, completion: nil)
        }
        //編集画面でのキャンセル
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === self.saveButton else {
            return
        }
        self.dTitle = self.diaryTitle.text ?? ""
        self.dContent = self.diaryContent.text ?? ""
        }
    
    
}

