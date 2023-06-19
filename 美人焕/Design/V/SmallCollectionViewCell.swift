//
//  SmallCollectionViewCell.swift
//  美人焕
//
//  Created by 翟旭博 on 2023/6/7.
//

import UIKit

class SmallCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 183 / 255, green: 160 / 255, blue: 168 / 255, alpha: 1.0)
        let _ = mainImageView
    }
    lazy var mainImageView: UIImageView = {
        let mainImageView = UIImageView()
        mainImageView.backgroundColor = UIColor.white
        mainImageView.layer.masksToBounds = true
        mainImageView.layer.cornerRadius = 20
        self.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(5)
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(0)
        }
        return mainImageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
