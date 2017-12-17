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
    var word = ""
    @IBAction func isEditing(_ sender: Any) {
        userOutput.text = userInput.text
        print ("str " + String(strLength) )
        strLength = userInput.text?.count ?? 0
        var iChars = Array(userInput.text!)
        var iCharsArabic = Array(userInput.text!)
        
        if (strLength <= 0){
            userOutput.text = ""
        }
        else{  //figure out how to do extra letter, and start determining location of letter in word
            for i in 0 ... strLength-1{
                (iChars[i] == "a" || iChars[i] == "e") ? iCharsArabic[i] = "ا" : nil  /*or e*/
                iChars[i] == "2" ? iCharsArabic[i] = "أ" : nil      //ء أ آ ؤ إ ئ
                
                (iChars[i] == "b" || iChars[i] == "p")  ? iCharsArabic[i] = "ب" : nil
                iChars[i] == "t" ? iCharsArabic[i] = "ت" : nil
                iChars[i] == "s" ? iCharsArabic[i] = "ث" : nil // iChars[i] ="th" if statement
                (iChars[i] == "j" || iChars[i] == "g")  ? iCharsArabic[i] = "ج" : nil  // "dj" if
                if (iChars[i] == "’") { // add or '
                    print ("in")
                    if iChars[i-1] == "7" {
                        iChars[i] = "5"
                        iCharsArabic[i-1] = "\0"
                        iChars[i-1] = "\0"
                    }
                    if iChars[i-1] == "3" {
                        iCharsArabic[i] = "غ"
                        iCharsArabic[i-1] = "\0"
                        iChars[i-1] = "\0"
                    }
                    if iChars[i-1] == "9" {
                        iCharsArabic[i] = "ض"
                        iCharsArabic[i-1] = "\0"
                        iChars[i-1] = "\0"
                    }
                    if iChars[i-1] == "6" {
                        iCharsArabic[i] = "ظ"
                        iCharsArabic[i-1] = "\0"
                        iChars[i-1] = "\0"
                    }
                    
                }
                iChars[i] == "7" ? iCharsArabic[i] = "ح" : nil // also h
                iChars[i] == "5" ? iCharsArabic[i] = "خ" : nil  // "kh" "7'"
                iChars[i] == "d" ? iCharsArabic[i] = "د" : nil
                iChars[i] == "z" ? iCharsArabic[i] = "ذ" : nil // "th" "dh"  ## z can be ز
                iChars[i] == "r" ? iCharsArabic[i] = "ر" : nil
                iChars[i] == "s" ? iCharsArabic[i] = "س" : nil // this is WRONG
                iChars[i] == "9" ? iCharsArabic[i] = "ص" : nil // ## can also be s
                iChars[i] == "6" ? iCharsArabic[i] = "ط" : nil // ## can also be t
            
                
                
                (iChars[i] == "o" || iChars[i] == "3") ? iCharsArabic[i] = "ع" : nil
                (iChars[i] == "f" || iChars[i] == "v") ? iCharsArabic[i] = "ف" : nil
                
                
                iChars[i] == "m" ? iCharsArabic[i] = "م" : nil
                
                (iChars[i] == "8" || iChars[i] == "q") ? iCharsArabic[i] = "ق" : nil // ## g and 2 too
                iChars[i] == "k" ? iCharsArabic[i] = "ك" : nil  // maybe g ?
                iChars[i] == "l" ? iCharsArabic[i] = "ل" : nil
                iChars[i] == "n" ? iCharsArabic[i] = "ن" : nil
                
                if (iChars[i] == "h") {
                    if(i>0){
                        if (iChars[i-1] == "s" || iChars[i-1] == "c" ){
                            iCharsArabic[i] = "ش"
                            iCharsArabic[i-1] = "\0"
                            iChars[i-1] = "\0"
                        }
                        else{
                            iCharsArabic[i] = "ه"
                            }
                    }
                    
                    else{
                    iCharsArabic[i] = "ه" // ## e,ah and eh , maybe a
                    }
                    
                }
                (iChars[i] == "w" || iChars[i] == "u") ? iCharsArabic[i] = "و" : nil //ou oo, maybe o
                (iChars[i] == "y" || iChars[i] == "i") ? iCharsArabic[i] = "ي" : nil //ee ei ai, maybe a
                
                /*
                 "ch" => ش
                 "dh" "d" => ض
                 "z" "th" "dh" => ظ
                 "gh" => غ
                 "a" "e" "eh" "at" "et" => ة
                 */
                
                /*iCharsArabic[i-1] = "خ"
                 iCharsArabic[i] = "\0"
                 iChars[i] = "\0"*/
                //might be useful for other letters
                // spacing issues for the nulls
            }
            
            userOutput.text = String(iCharsArabic)
        }
    }
    
   /* func trasnlate (iChars: [String]){
      later implement
     
     if (iChars[i] == " "){
     print (iChars[i-1])
     }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

