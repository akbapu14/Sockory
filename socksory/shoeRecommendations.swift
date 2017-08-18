//
//  shoeRecommendations.swift
//  socksory
//
//  Created by Akilesh Bapu on 1/22/17.
//  Copyright © 2017 org.berkeleyMobile. All rights reserved.
//


import UIKit
import Button

class shoeRecommendations: UIViewController {
    var dropInButton: BTNDropinButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location: BTNLocation = BTNLocation.init(name: "Parm", latitude: 40.723027, longitude: -73.9956459);
        let context: BTNContext = BTNContext.init(subjectLocation: location);
        
        if let button = self.dropInButton {
            button.buttonId = "btn-37181bad6b0e555b"
            
            button.prepare(with: context, completion: { (isDisplayable: Bool) -> Void in
                print("Displayable: \(isDisplayable)")
            })
        }
        
    }
    @IBAction func amazon(_ sender: Any) {
        UIApplication.shared.open(NSURL(string:"http://www.amazon.com/") as! URL, options: [:], completionHandler: nil)

    }
    
}

