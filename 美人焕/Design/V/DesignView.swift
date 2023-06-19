//
//  DesignView.swift
//  美人焕
//
//  Created by 翟旭博 on 2023/6/6.
//

import UIKit
import SnapKit
class DesignView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var flagRightDrawerArray = [0, 0, 0, 0]
    func viewInit() {
        let _ = headImageView
        let _ = headLabel
        let _ = gradeLabel
        let _ = leftButton
        let _ = leftLabel
        let _ = rightButtonAndLabel
        let _ = rightDrawerButton
        let _ = rightDrawerView
        let _ = rightCollectionView
        self.backgroundColor = UIColor.white
    }
    
    //头像懒加载
    lazy var headImageView: UIImageView = {
        let image: UIImage = UIImage()
        let headImageView: UIImageView = UIImageView(image: image)
        headImageView.backgroundColor = UIColor.blue
        self.addSubview(headImageView)
        headImageView.layer.masksToBounds = true
        headImageView.layer.cornerRadius = SIZE_WIDTH / 26
        headImageView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(30)
            make.width.equalTo(SIZE_WIDTH / 13)
            make.height.equalTo(SIZE_WIDTH / 13)
        }
        return headImageView
    }()
    
    //名字懒加载
    lazy var headLabel: UILabel = {
        let headLabel:UILabel = UILabel()
        headLabel.text = "慧慧小主"
        headLabel.font = UIFont.systemFont(ofSize: 23)
        headLabel.textAlignment = .left;
        self.addSubview(headLabel)
        headLabel.snp.makeConstraints { make in
            make.left.equalTo(self.headImageView).offset(20 + SIZE_WIDTH / 15)
            make.top.equalTo(self.headImageView).offset(-30)
            make.width.equalTo(SIZE_WIDTH / 5)
            make.height.equalTo(SIZE_WIDTH / 10)
        }
        return headLabel
    }()
    
    //等级文字懒加载
    lazy var gradeLabel: UILabel = {
        let gradeLabel:UILabel = UILabel()
        gradeLabel.text = "LV4"
        gradeLabel.font = UIFont.systemFont(ofSize: 19)
        gradeLabel.textColor = UIColor.systemPink
        gradeLabel.textAlignment = .left;
        self.addSubview(gradeLabel)
        gradeLabel.snp.makeConstraints { make in
            make.left.equalTo(self.headImageView).offset(20 + SIZE_WIDTH / 15)
            make.top.equalTo(self.headImageView).offset(5)
            make.width.equalTo(SIZE_WIDTH / 5)
            make.height.equalTo(SIZE_WIDTH / 10)
        }
        return gradeLabel
    }()
    
    //左侧按钮懒加载
    lazy var leftButton: [UIButton] = {
        var leftButtons = [UIButton]()
        for i in 0...2 {
            let leftButton:UIButton = UIButton()
            //leftButton.backgroundColor = UIColor.blue
            self.addSubview(leftButton)
            let string = String(format: "left%d.png", i + 1)
            leftButton.setImage(UIImage(named: string), for:.normal)
            leftButton.addTarget(self, action: #selector(pressChange), for: .touchUpInside)
            leftButton.tag = i
            leftButton.snp.makeConstraints { make in
                make.left.equalTo(self).offset(30)
                make.top.equalTo(self).offset(Int(SIZE_HEIGHT) / 4 + i * (Int(SIZE_WIDTH) / 6))
                make.width.equalTo(SIZE_WIDTH / 10)
                make.height.equalTo(SIZE_WIDTH / 10)
            }
        }
        return leftButtons
    }()
    @objc func pressChange(button: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("pressChange"), object: nil, userInfo: ["button":button])
    }
    //左侧按钮文字懒加载
    lazy var leftLabel: [UILabel] = {
        var leftLabels = [UILabel]()
        let array = ["设计空间", "学习中心", "AR"]
        for i in 0...2 {
            let leftLabel:UILabel = UILabel()
            leftLabel.text = array[i]
            leftLabel.textAlignment = .center
            self.addSubview(leftLabel)
            leftLabel.snp.makeConstraints { make in
                make.left.equalTo(self).offset(30)
                make.top.equalTo(self).offset(Int(SIZE_HEIGHT) / 5 + i * (Int(SIZE_WIDTH) / 6) + Int(SIZE_WIDTH) / 10)
                make.width.equalTo(SIZE_WIDTH / 10)
                make.height.equalTo(SIZE_WIDTH / 10)
            }
        }
        return leftLabels
    }()
    
    //右上角按钮懒加载
    lazy var rightButtonAndLabel:[(rightButton:UIButton,  rightLabel:UILabel)] = {
        var rightButtonAndLabelArray = [(rightButton: UIButton, rightLabel: UILabel)]()
        let array = ["客服", "设置", "家长指南", "商城"]
        for i in 0..<4 {
            let button = UIButton()
            button.backgroundColor = UIColor.blue
            self.addSubview(button)
            button.snp.makeConstraints { make in
                make.right.equalTo(self).offset(-30 - (SIZE_WIDTH / 13) * CGFloat(i))
                make.top.equalTo(self).offset(40)
                make.width.equalTo(SIZE_WIDTH / 15)
                make.height.equalTo(SIZE_WIDTH / 15)
            }
           
            let label = UILabel()
            label.text = array[i]
            label.textAlignment = .center
            self.addSubview(label)
            label.snp.makeConstraints { make in
                make.right.equalTo(self).offset(-30 - (SIZE_WIDTH / 13) * CGFloat(i))
                make.top.equalTo(self).offset(35 + SIZE_WIDTH / 15)
                make.width.equalTo(SIZE_WIDTH / 15)
                make.height.equalTo(SIZE_WIDTH / 30)
            }
            let tuple = (rightButton: button, rightLabel: label)
            rightButtonAndLabelArray.append(tuple)
        }

        return rightButtonAndLabelArray
    }()
    //右侧抽屉按钮懒加载
    lazy var rightDrawerButton: UIButton = {
        let rightDrawerButton = UIButton()
        rightDrawerButton.backgroundColor = UIColor.red
        self.addSubview(rightDrawerButton)
        rightDrawerButton.isSelected = false
        rightDrawerButton.snp.makeConstraints { make in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(SIZE_HEIGHT / 3)
            make.width.equalTo(SIZE_WIDTH / 15)
            make.height.equalTo(SIZE_HEIGHT / 3)
        }
        rightDrawerButton.addTarget(self, action:#selector(rightPop) , for: .touchUpInside)
        return rightDrawerButton
    }()
    //右侧抽屉的点击事件
    @objc func rightPop(button: UIButton) {
        if button.isSelected {
            UIButton.animate(withDuration: 0.5) {
                self.rightDrawerButton.snp.updateConstraints { make in
                    make.right.equalTo(self).offset(0)
                }
                self.layoutIfNeeded() // 将更改应用于视图的布局
            }
            button.isSelected = false
        } else {
            UIButton.animate(withDuration: 0.5) {
                self.rightDrawerButton.snp.updateConstraints { make in
                    make.right.equalTo(self).offset(-SIZE_WIDTH / 3)
                }
                self.layoutIfNeeded() // 将更改应用于视图的布局
            }
            button.isSelected = true
        }
    }

    //右侧抽屉懒加载
    lazy var rightDrawerView: UIView = {
        let rightDrawerView = UIView()
        rightDrawerView.backgroundColor = UIColor.green
        self.addSubview(rightDrawerView)
        rightDrawerView.snp.makeConstraints { make in
            make.left.equalTo(self.rightDrawerButton.snp_right).offset(0)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.width.equalTo(SIZE_WIDTH / 3)
        }
        return rightDrawerView
    }()
    //右侧抽屉里的UICollectionView
    lazy var rightCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let rightCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        rightCollectionView.backgroundColor = UIColor(red: 183 / 255, green: 160 / 255, blue: 167 / 255, alpha: 1.0)
        self.rightDrawerView.addSubview(rightCollectionView)
        rightCollectionView.delegate = self
        rightCollectionView.dataSource = self
        rightCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.rightDrawerView).offset(0)
            make.left.equalTo(self.rightDrawerView).offset(0)
            make.right.equalTo(self.rightDrawerView).offset(0)
            make.bottom.equalTo(self.rightDrawerView).offset(0)
        }
        rightCollectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: "TitleCollectionViewCell")
        rightCollectionView.register(SmallCollectionViewCell.self, forCellWithReuseIdentifier: "SmallCollectionViewCell")
        return rightCollectionView;
    }()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + flagRightDrawerArray[section] * 10
    }
    
    //内容函数
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallCollectionViewCell", for: indexPath) as! SmallCollectionViewCell
            return cell
        }
        
    }
    
    //UICollectionView的cell点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            if (flagRightDrawerArray[indexPath.section] == 1) {
                flagRightDrawerArray[indexPath.section] = 0
            } else {
                flagRightDrawerArray[indexPath.section] = 1
            }
            collectionView.reloadData()
        }
    }
    
    //每个item大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.item == 0) {
            return CGSize(width: collectionView.frame.width, height: 130)
        } else {
            return CGSize(width: collectionView.frame.width / 2 - 5, height: collectionView.frame.width / 2 - 5)
        }
    }
    
    //头视图
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (section == 0) {
            return CGSize(width: collectionView.frame.width, height: 90)
        } else {
            return CGSize(width: collectionView.frame.width, height: 12)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
