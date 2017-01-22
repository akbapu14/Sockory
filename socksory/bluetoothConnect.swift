//
//  bluetoothConnect.swift
//  socksory
//
//  Created by Akilesh Bapu on 1/21/17.
//  Copyright © 2017 org.berkeleyMobile. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
class bluetoothConnect: UIViewController {


    @IBOutlet weak var label: UILabel!
    var mainTimer: Timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mainTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.pingServer), userInfo: nil, repeats: true);
    }
    func pingServer() {
    var endpoint = "http://10.251.65.201:8080/"
    Alamofire.request(endpoint).responseJSON
    { response in
    
    if response.result.isFailure {
    self.label.text = "Waiting For Connection: " + (response.result.error?.localizedDescription)!

    } else {
    let points = JSON(data: response.data!)
    
        //See if there is data coming
        self.mainTimer.invalidate()
        self.performSegue(withIdentifier: "toSetup", sender: self)
    }
    
    
    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
