//
//  DesignViewController.swift
//  美人焕
//
//  Created by 翟旭博 on 2023/6/6.
//

import UIKit

class DesignViewController: ViewController {
    let designView = DesignView()
    override func viewDidLoad() {
        super.viewDidLoad()
        designView.frame = self.view.frame
        self.view.addSubview(designView)
        designView.viewInit()
        NotificationCenter.default.addObserver(self, selector: #selector(pressChange(_:)), name: Notification.Name("pressChange"), object: nil)
    }
    @objc func pressChange(_ notification: Notification) {
        let userInfo = notification.userInfo?["button"] as? UIButton
        if userInfo?.tag == 0 {
            let changeViewController = ChangeViewController()
            changeViewController.modalPresentationStyle = .fullScreen
            self.present(changeViewController, animated: true)
        } else if userInfo?.tag == 1 {
            
        } else if userInfo?.tag == 2 {
            let aRclothesController = ARClothesViewController()
            aRclothesController.modalPresentationStyle = .fullScreen
            self.present(aRclothesController, animated: true)
        }
    }

}
