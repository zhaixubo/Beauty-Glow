//
//  TitleCollectionViewCell.swift
//  美人焕
//
//  Created by 翟旭博 on 2023/6/7.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 213 / 255, green: 187 / 255, blue: 195 / 255, alpha: 1.0)
        let _ = titleImageView
        let _ = titleLabel
        let _ = titleRightImageView
    }
    lazy var titleImageView: UIImageView = {
        let titleImageView = UIImageView()
        titleImageView.backgroundColor = UIColor.green
        self.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(80)
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-20)
            make.width.equalTo(69)
        }
        return titleImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "汉服"
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(180)
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-20)
            make.width.equalTo(80)
        }
        return titleLabel
    }()
    
    lazy var titleRightImageView: UIImageView = {
        let titleRightImageView = UIImageView()
        titleRightImageView.backgroundColor = UIColor.purple
        self.addSubview(titleRightImageView)
        titleRightImageView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(260)
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-20)
            make.width.equalTo(60)
        }
        return titleRightImageView
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
