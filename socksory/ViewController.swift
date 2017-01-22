//
//  ViewController.swift
//  socksory
//
//  Created by Akilesh Bapu on 1/21/17.
//  Copyright © 2017 org.berkeleyMobile. All rights reserved.
//

import UIKit
import SceneKit
class ViewController: UIViewController {

    @IBOutlet var sceneView: SCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/sock.scn")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 2)
        
        // create and add a light to the scene
//        let lightNode = SCNNode()
//        lightNode.light = SCNLight()
//        lightNode.light!.type = .omni
//        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
//        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light!.type = .ambient
//        ambientLightNode.light!.color = UIColor.darkGray
//        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        let sock = scene.rootNode.childNode(withName: "sock", recursively: true)!
        let box = scene.rootNode.childNode(withName: "box", recursively: true)!
        box.geometry?.material(named: "j")?.diffuse.contents = UIColor.red
        // animate the 3d object
        sock.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 2)))
//        ship.scale = SCNVector3(x: 4, y: 4, z: 4)
//        ship.geometry?.firstMaterial?.emission.contents = UIColor.red
        sock.position = SCNVector3Make(sock.position.x, sock.position.y - 0.5, sock.position.z)
        // retrieve the SCNView
        self.sceneView.scene = scene
        
        // allows the user to manipulate the camera
        self.sceneView.allowsCameraControl = true
        self.sceneView.autoenablesDefaultLighting = true

        // configure the view
        self.sceneView.backgroundColor = UIColor.brown
        
        // add a tap gesture recognizer
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        self.sceneView.addGestureRecognizer(tapGesture)
    }

    @IBAction func changeCoor(_ sender: Any) {
        let box = self.sceneView.scene?.rootNode.childNode(withName: "box", recursively: true)!
        box?.geometry?.material(named: "j")?.diffuse.contents = UIColor.green
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

