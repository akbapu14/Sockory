//
//  welcomeScreen.swift
//  
//
//  Created by Akilesh Bapu on 1/21/17.
//
//

import UIKit
import Alamofire
import SwiftyJSON
class welcomeScreen: UIViewController {
    var mainTimer: Timer = Timer()
    @IBOutlet weak var calibrateCheckMark: UIImageView!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var stepCheckMark: UIImageView!
    @IBOutlet weak var wearCheckMark: UIImageView!
    @IBOutlet weak var logoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        wearCheckMark.image = wearCheckMark.image!.withRenderingMode(.alwaysTemplate)
        wearCheckMark.tintColor = UIColor.init(red: 1.0/255.0, green: 154.0/255.0, blue: 0.0, alpha: 1)
        self.mainTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.pingServer), userInfo: nil, repeats: true);
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pingServer() {
        var endpoint = "http://10.251.131.141:8080/"
        Alamofire.request(endpoint).responseJSON
            { response in
                
                if response.result.isFailure {
                    self.performSegue(withIdentifier: "backError", sender: self)
                } else {
                    let points = JSON(data: response.data!)
                    self.analyzePoints(points[0].int!, points[1].int!, points[2].int!, points[3].int!, points[4].int!, points[5].int!)
                    //See if there is data coming
                    
                }
                
                
        }
    }
    func analyzePoints(_ a: Int, _ b: Int, _ c: Int,_ d:Int, _ e:Int, _ f:Int ) {
        var sum = a + b + c + d + e + f
        if sum > 3000 {
            self.mainTimer.invalidate()
            stepCheckMark.image = stepCheckMark.image!.withRenderingMode(.alwaysTemplate)
            stepCheckMark.tintColor = UIColor.init(red: 1.0/255.0, green: 154.0/255.0, blue: 0.0, alpha: 1)

            self.mainTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.lastGreen), userInfo: nil, repeats: false);
        }
    }
    func lastGreen() {
        calibrateCheckMark.image = calibrateCheckMark.image!.withRenderingMode(.alwaysTemplate)
        calibrateCheckMark.tintColor = UIColor.init(red: 1.0/255.0, green: 154.0/255.0, blue: 0.0, alpha: 1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
