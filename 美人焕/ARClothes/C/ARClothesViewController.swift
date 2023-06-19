//
//  ARClothesViewController.swift
//  美人焕
//
//  Created by 翟旭博 on 2023/6/16.
//

import UIKit

class ARClothesViewController: ViewController {
    let aRClothesView = ARClothesView(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        aRClothesView.frame = self.view.frame
        self.view.addSubview(self.aRClothesView)
    }

}
