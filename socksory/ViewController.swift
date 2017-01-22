//
//  ViewController.swift
//  socksory
//
//  Created by Akilesh Bapu on 1/21/17.
//  Copyright © 2017 org.berkeleyMobile. All rights reserved.
//

import UIKit
import SceneKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    var mainTimer: Timer = Timer()

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var arch: UILabel!
    @IBOutlet weak var toes: UILabel!
    @IBOutlet weak var outerBall: UILabel!
    @IBOutlet weak var innerBall: UILabel!
    @IBOutlet weak var heelBall: UILabel!
    @IBOutlet weak var heelBack: UILabel!
    @IBOutlet weak var advice: UILabel!
    @IBOutlet var sceneView: SCNView!
    var totalViews: [UILabel] = []
    var totalViewStrings: [String] = []
    var sceneNodes: [SCNNode] = []
    var current: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // create a new scene
        self.totalViews = [self.heelBack,self.outerBall, self.heelBall, self.innerBall,  self.toes, self.arch]
        self.totalViewStrings = ["Heel Back: ", "Outer Ball: ", "Heel Ball: ", "Inner Ball: ",  "Toes: ", "Arch: "]
        
        for view in self.totalViews {
            view.isHidden = true
        }
        let scene = SCNScene(named: "art.scnassets/MAIN-FOOT.scn")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 25)
        
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
        
        let mainfoot = scene.rootNode.childNode(withName: "mainFoot", recursively: true)!
        let toes = scene.rootNode.childNode(withName: "toes", recursively: true)!
        let outerball = scene.rootNode.childNode(withName: "outerball", recursively: true)!
        let heelball = scene.rootNode.childNode(withName: "heelball", recursively: true)!
        let heelback = scene.rootNode.childNode(withName: "heelback", recursively: true)!
        let innerball = scene.rootNode.childNode(withName: "innerball", recursively: true)!
        let arch = scene.rootNode.childNode(withName: "arch", recursively: true)!

        self.sceneNodes = [heelback, outerball, heelball, innerball, toes, arch]
        heelback.geometry?.material(named: "heelback")!.diffuse.contents = UIColor.blue
        // animate the 3d object
//        mainfoot.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 2)))
//        ship.scale = SCNVector3(x: 4, y: 4, z: 4)
//        ship.geometry?.firstMaterial?.emission.contents = UIColor.red
        mainfoot.position = SCNVector3Make(mainfoot.position.x, mainfoot.position.y - 1, mainfoot.position.z)
        // retrieve the SCNView
        self.sceneView.scene = scene
        
        // allows the user to manipulate the camera
        self.sceneView.allowsCameraControl = true
        self.sceneView.autoenablesDefaultLighting = true

        // configure the view
//        self.sceneView.backgroundColor = UIColor.brown
        
        // add a tap gesture recognizer
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        self.sceneView.addGestureRecognizer(tapGesture)
        self.mainTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.pingServer), userInfo: nil, repeats: true);
    }
    func pingServer() {
        var endpoint = "http://10.251.65.201:8080/"
        Alamofire.request(endpoint).responseJSON
            { response in
                
                if response.result.isFailure {
                    self.performSegue(withIdentifier: "backErrorTwo", sender: self)
                } else {
                    let points = JSON(data: response.data!)
                    self.updatePoints(points[0].int!, points[1].int!, points[2].int!, points[3].int!, points[4].int!, points[5].int!)
                    //See if there is data coming
                    
                }
                
                
        }
        endpoint =  "http://10.251.65.201:8080/steps"

        Alamofire.request(endpoint).responseJSON
            { response in
                
                if response.result.isFailure {
//                    self.performSegue(withIdentifier: "backErrorTwo", sender: self)
                } else {
                    let num = JSON(data: response.data!).int
                    self.updateSteps(num!)
                    //See if there is data coming
                }
                
                
        }
    }
    
    func intToUIColor(_ a: Int) -> UIColor {
        if a < 600 {
            return UIColor.green
        } else if (a > 600 && a < 800) {
            return UIColor.yellow
        } else if (a > 800) {
            return UIColor.red
        }
        return UIColor.blue
    }
    func intToFloat(_ a: Int) -> CGFloat {
        var div: CGFloat = CGFloat.init(a)
        div = div/600.0
        if div > 1 {
            div = 1
        }
        return div
    }
    func updatePoints(_ a: Int, _ b: Int, _ c: Int,_ d:Int, _ e:Int, _ f:Int ) {
        var spaceCrunch: [Int] = [a,b,c,d,e,f]
        var someCount = 0
        for sceneNode in self.sceneNodes {
            if ((sceneNode.geometry) != nil) {
                var chosenMaterial = (sceneNode.geometry?.materials[0])! as SCNMaterial
                chosenMaterial.diffuse.contents = intToUIColor(spaceCrunch[someCount])
            }
            someCount += 1
        }
        for i in 0...5 {
            var rawValue = CGFloat(spaceCrunch[i])
            if (i == 4) {
                if (rawValue - 200) > 0 {
                    rawValue = (rawValue - 200) * 0.1015
                }
                else {
                    rawValue = 0
                }
            }
            else if (rawValue - 500) > 0 {
                rawValue = (rawValue - 500) * 0.15
            } else {
                rawValue = 0
            }
            totalViews[i].text = totalViewStrings[i] + String(describing: rawValue) + "lbs"
        }
    }
    
    func updateSteps(_ steps: Int) {
        if self.current == 2 {
            self.advice.text = String(steps) + " Steps"
        }
    }
    @IBAction func changeBottom(_ sender: Any) {
        current = segmentedControl.selectedSegmentIndex
        if (current == 0){
            self.advice.isHidden = false
            for view in self.totalViews {
                view.isHidden = true
            }
        } else if (current == 1){
            self.advice.isHidden = true
            for view in self.totalViews {
                view.isHidden = false
            }
        } else {
            self.advice.isHidden = false
            for view in self.totalViews {
                view.isHidden = true
            }
        }
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

