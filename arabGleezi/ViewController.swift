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
        else{  //figure out how to do extra letter, and start determining location of letter in word
            for i in 0 ... strLength-1{
                (iChars[i] == "a" || iChars[i] == "e") ? iChars[i] = "ا" : nil  /*or e*/
                iChars[i] == "2" ? iChars[i] = "أ" : nil      //ء أ آ ؤ إ ئ
                
                (iChars[i] == "b" || iChars[i] == "p")  ? iChars[i] = "ب" : nil
                iChars[i] == "t" ? iChars[i] = "ت" : nil
                iChars[i] == "s" ? iChars[i] = "ث" : nil // iChars[i] ="th" if statement
                (iChars[i] == "j" || iChars[i] == "g")  ? iChars[i] = "ج" : nil  // "dj" if
                iChars[i] == "7" ? iChars[i] = "ح" : nil // also h
                iChars[i] == "5" ? iChars[i] = "خ" : nil  // "kh" "7'"
                iChars[i] == "d" ? iChars[i] = "د" : nil
                iChars[i] == "z" ? iChars[i] = "ذ" : nil // "th" "dh"  ## z can be ز
                iChars[i] == "r" ? iChars[i] = "ر" : nil
                iChars[i] == "s" ? iChars[i] = "س" : nil //
                iChars[i] == "9" ? iChars[i] = "ص" : nil // ## can also be s
                iChars[i] == "6" ? iChars[i] = "ط" : nil // ## can also be t
                
                
                
                (iChars[i] == "o" || iChars[i] == "3") ? iChars[i] = "ع" : nil
                (iChars[i] == "f" || iChars[i] == "v") ? iChars[i] = "ف" : nil
                
                
                iChars[i] == "m" ? iChars[i] = "م" : nil
                
                (iChars[i] == "8" || iChars[i] == "q") ? iChars[i] = "ق" : nil // ## g and 2 too
                iChars[i] == "k" ? iChars[i] = "ك" : nil  // maybe g ?
                iChars[i] == "l" ? iChars[i] = "ل" : nil
                iChars[i] == "n" ? iChars[i] = "ن" : nil
                (iChars[i] == "h") ? iChars[i] = "ه" : nil // ## e,ah and eh , maybe a
                (iChars[i] == "w" || iChars[i] == "u") ? iChars[i] = "و" : nil //ou oo, maybe o
                (iChars[i] == "y" || iChars[i] == "i") ? iChars[i] = "ي" : nil //ee ei ai, maybe a
                
                /*
                 "sh" or "ch" => ش
                 "9'" "dh" "d" => ض
                 "z" "th" "dh" "6'" => ظ
                 "gh" "3'" => غ
                 "a" "e" "eh" "at" "et" => ة
                 
 */
                
                
                
            }
            userOutput.text = String(iChars)
        }
    }
    
    func trasnlate (iChars: [String]){
        
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

