//
//  ChangeViewController.swift
//  美人焕
//
//  Created by 翟旭博 on 2023/6/7.
//

import UIKit

class ChangeViewController: ViewController {
    let changeView = ChangeView()
    override func viewDidLoad() {
        super.viewDidLoad()
        changeView.frame = self.view.frame
        self.view.addSubview(changeView)
        changeView.viewInit()
        NotificationCenter.default.addObserver(self, selector: #selector(pressBackButton), name: Notification.Name("pressBackButton"), object: nil)
    }
    @objc func pressBackButton() {
        self.dismiss(animated: true)
    }
}
