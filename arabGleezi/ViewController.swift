//
//  ViewController.swift
//  arabGleezi
//
//  Created by Waddah Aldrobi on 2017-12-06.
//  Copyright © 2017 Waddah Aldrobi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var userOutput: UILabel!
    var strLength = 0
    
    @IBAction func isEditing(_ sender: Any) {
        userOutput.text = userInput.text
        print ("hi")
        print (strLength)
        strLength = userInput.text?.count ?? 0
        var iChars = Array(userInput.text!)
        
        //print (iChars[0])
        if (strLength <= 0){
            userOutput.text = ""
        }
        else{
            for i in 0 ... strLength-1{
                if (iChars[i] == "o"){
                    iChars[i] = "ع"
                }
                if (iChars[i] == "m"){
                    iChars[i] = "م"
                }
                if (iChars[i] == "r"){
                    iChars[i] = "ر"
                }
                
            }
            userOutput.text = String(iChars)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

