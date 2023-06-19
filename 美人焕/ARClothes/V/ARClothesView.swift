//
//  ARClothesView.swift
//  美人焕
//
//  Created by 翟旭博 on 2023/6/16.
//

import UIKit
import ARKit
import RealityKit
import BodyTracking
class ARClothesView: ARView {
    private let bodyAnchor = AnchorEntity(.body)
    private var robot: BodyTrackedEntity!
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        guard let _ = try? runBodyTrackingConfig3D() else {
            print("This device does Not support body tracking.")
            return
        }
        
        self.scene.addAnchor(bodyAnchor)
        BodyTrackedEntity.loadCharacterAsync(named: "robotWhite"){ robot in
            print("Loaded \"robotWhite\"")
            print(robot)
            if let modelComp = robot.components[ModelComponent.self] as? ModelComponent {
                print(modelComp.materials)
            }
            self.robot = robot
            self.bodyAnchor.addChild(robot)
        }
    }
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func stopSession() {
        self.session.pause()
        self.scene.anchors.removeAll()
        self.robot.removeFromParent()
        self.robot = nil
    }
    deinit {
        self.stopSession()
    }
}
