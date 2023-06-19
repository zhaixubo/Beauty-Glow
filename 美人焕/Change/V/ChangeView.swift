//
//  ChangeView.swift
//  美人焕
//
//  Created by 翟旭博 on 2023/6/7.
//

import UIKit

class ChangeView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionViewLeftAndRightFlag = 0
    var flagRightDrawerArray = [0, 0, 0, 0]
    func viewInit() {
        self.backgroundColor = UIColor.white
        let _ = backButton
        let _ = rightDrawerButton
        let _ = rightDrawerView
        let _ = rightCollectionView
        let _ = twoLeftButton
        let _ = twoRightButton
    }
    //返回按钮
    lazy var backButton: UIButton = {
        let backButton:UIButton = UIButton()
        backButton.backgroundColor = UIColor.red
        backButton.frame = CGRect(x: 50, y: 50, width: 80, height: 80)
        self.addSubview(backButton)
        backButton.addTarget(self, action: #selector(pressBackButton), for: .touchUpInside)
        return backButton
    }()
    @objc func pressBackButton() {
        NotificationCenter.default.post(name: Notification.Name("pressBackButton"), object: nil)
    }
    
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

    lazy var twoLeftButton: UIButton = {
        let twoLeftButton = UIButton()
        twoLeftButton.frame = CGRectMake(0, 80, SIZE_WIDTH / 6, 100)
        twoLeftButton.setTitle("经典", for: .normal)
        twoLeftButton.backgroundColor = UIColor(red: 203 / 255, green: 172 / 255, blue: 182 / 255, alpha: 1.0)
        twoLeftButton.isSelected = true
        twoLeftButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        twoLeftButton.setTitleColor(UIColor.black, for: .normal)
        twoLeftButton.addTarget(self, action: #selector(pressTwoLeftButton), for: .touchUpInside)
        self.rightDrawerView.addSubview(twoLeftButton)
        return twoLeftButton
    }()
    @objc func pressTwoLeftButton() {
        if (collectionViewLeftAndRightFlag == 1) {
            twoLeftButton.backgroundColor = UIColor(red: 203 / 255, green: 172 / 255, blue: 182 / 255, alpha: 1.0)
            twoRightButton.backgroundColor = UIColor(red: 168 / 255, green: 142 / 255, blue: 152 / 255, alpha: 1.0)
            self.rightCollectionView.reloadData()
            collectionViewLeftAndRightFlag = 0
        }
    }
    lazy var twoRightButton: UIButton = {
        let twoRightButton = UIButton()
        twoRightButton.frame = CGRectMake(0 + 1.0 * SIZE_WIDTH / 6, 80, SIZE_WIDTH / 6, 100)
        twoRightButton.setTitle("搭配", for: .normal)
        twoRightButton.backgroundColor = UIColor(red: 168 / 255, green: 142 / 255, blue: 152 / 255, alpha: 1.0)
        twoRightButton.isSelected = true
        twoRightButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        twoRightButton.setTitleColor(UIColor.black, for: .normal)
        twoRightButton.addTarget(self, action: #selector(pressTwoRightButton), for: .touchUpInside)
        self.rightDrawerView.addSubview(twoRightButton)
        return twoRightButton
    }()
    @objc func pressTwoRightButton() {
        if (collectionViewLeftAndRightFlag == 0) {
            twoLeftButton.backgroundColor = UIColor(red: 168 / 255, green: 142 / 255, blue: 152 / 255, alpha: 1.0)
            twoRightButton.backgroundColor = UIColor(red: 203 / 255, green: 172 / 255, blue: 182 / 255, alpha: 1.0)
            self.rightCollectionView.reloadData()
            collectionViewLeftAndRightFlag = 1
        }
    }
    //右侧抽屉里的UICollectionView
    lazy var rightCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let rightCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        rightCollectionView.backgroundColor = UIColor(red: 183 / 255, green: 160 / 255, blue: 167 / 255, alpha: 1.0)
        self.rightDrawerView.addSubview(rightCollectionView)
        rightCollectionView.delegate = self
        rightCollectionView.dataSource = self
        rightCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.rightDrawerView).offset(180)
            make.left.equalTo(self.rightDrawerView).offset(0)
            make.right.equalTo(self.rightDrawerView).offset(0)
            make.bottom.equalTo(self.rightDrawerView).offset(0)
        }
        rightCollectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: "TitleCollectionViewCell")
        rightCollectionView.register(SmallCollectionViewCell.self, forCellWithReuseIdentifier: "SmallCollectionViewCell")
        return rightCollectionView;
    }()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionViewLeftAndRightFlag == 1 {
            return 4
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionViewLeftAndRightFlag == 1 {
            return 1 + flagRightDrawerArray[section] * 10
        } else {
            return 10
        }
        
    }
    
    //内容函数
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionViewLeftAndRightFlag == 1 {
            if (indexPath.item == 0) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallCollectionViewCell", for: indexPath) as! SmallCollectionViewCell
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallCollectionViewCell", for: indexPath) as! SmallCollectionViewCell
            return cell
        }
        
        
    }
    
    //UICollectionView的cell点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionViewLeftAndRightFlag == 1 {
            if (indexPath.row == 0) {
                if (flagRightDrawerArray[indexPath.section] == 1) {
                    flagRightDrawerArray[indexPath.section] = 0
                } else {
                    flagRightDrawerArray[indexPath.section] = 1
                }
                collectionView.reloadData()
            }
        } else {
        
        }
    }
    
    //每个item大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionViewLeftAndRightFlag == 1 {
            if (indexPath.item == 0) {
                return CGSize(width: collectionView.frame.width, height: 130)
            } else {
                return CGSize(width: collectionView.frame.width / 2 - 5, height: collectionView.frame.width / 2 - 5)
            }
        } else {
            return CGSize(width: collectionView.frame.width / 2 - 5, height: collectionView.frame.width / 2 - 5)
        }
       
    }
    
    //头视图
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

