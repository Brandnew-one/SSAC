//
//  ViewController.swift
//  ARPractice-Scene
//
//  Created by 신상원 on 2022/01/23.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView! // 3D-Object 추가를 위해서
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        
        // 이미지가 들어간 정육면체
        let box: SCNGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "sini.jpg")
        let node = SCNNode()
        node.geometry = box
        node.geometry?.materials = [material]
        node.position = SCNVector3(1, 0, 0) // 우-좌, 상-하, 뒤-앞
        scene.rootNode.addChildNode(node)
        
        // 텍스트 띄우기
        let textGeometry = SCNText(string: "위클리 컨퍼런스!", extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.black
        let textNode = SCNNode(geometry: textGeometry)
        textNode.position = SCNVector3(-1, 0, 0)
        textNode.scale = SCNVector3(0.01, 0.01, 0.01)
        scene.rootNode.addChildNode(textNode)
        
        // 탭 하면 색깔 바뀌는 구
        let sphere = SCNSphere(radius: 0.2)
        let sphereMaterial = SCNMaterial()
        sphereMaterial.diffuse.contents = UIColor.red
        sphereMaterial.name = "Color"
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.geometry?.materials = [sphereMaterial]
        sphereNode.position = SCNVector3(0, 0, -1)
        scene.rootNode.addChildNode(sphereNode)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(recognizer:)))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    @objc func tapped(recognizer: UITapGestureRecognizer) {
        let sceneView = recognizer.view as! SCNView
        let touchLocation: CGPoint = recognizer.location(in: sceneView)
        let hitResults: [SCNHitTestResult] = sceneView.hitTest(touchLocation, options: [:])
        
        if !hitResults.isEmpty {
            let node = hitResults[0].node
            let meterial : SCNMaterial? = node.geometry?.material(named: "Color")
            meterial?.diffuse.contents = UIColor.random()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}
