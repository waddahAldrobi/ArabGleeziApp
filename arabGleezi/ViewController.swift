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
        strLength = userInput.text?.count ?? 0
        var iChars = Array(userInput.text!)
        var iCharsArabic = Array(userInput.text!)
        
        //var wordsArr = userOutput.text?.split(separator: " ")
        var i = 0
        if (strLength <= 0){
            userOutput.text = ""
        }
        else{  //figure out how to do extra letter, and start determining location of letter in word
            while (i < strLength){
                
                switch iChars[i] {
                case "7" :
                    iCharsArabic[i] = "ح" // also h
                case "5" :
                    iCharsArabic[i] = "خ" // "kh" "7'"
                case "d" :
                    iCharsArabic[i] = "د"
                case "z" :
                    iCharsArabic[i] = "ذ" // "th" "dh"  ## z can be ز
                case "r" :
                    iCharsArabic[i] = "ر"
                case "s" :
                    iCharsArabic[i] = "س"
                case "9" :
                    iCharsArabic[i] = "ص" // ## can also be s
                case "6" :
                    iCharsArabic[i] = "ط" // ## can also be t
                case "o","O","3":
                    iCharsArabic[i] = "ع"
                case "f","v":
                    iCharsArabic[i] = "ف"
                case "m" :
                    iCharsArabic[i] = "م"
                case "8","q" :
                    iCharsArabic[i] = "ق" // ## g and 2 too
                case "k" :
                    iCharsArabic[i] = "ك" // maybe g
                case "l" :
                    iCharsArabic[i] = "ل"
                case "n" :
                    iCharsArabic[i] = "ن"
                case "w","u" :
                    iCharsArabic[i] = "و" //ou oo, maybe o
                case "y","i" :
                    iCharsArabic[i] = "ي" //ee ei ai, maybe a
                case "a","e" :
                    iCharsArabic[i] = "ا"
                case "2" ://ء أ آ ؤ إ ئ
                    iCharsArabic[i] = "أ"
                case "b","p" :
                    iCharsArabic[i] = "ب"
                case "t" :
                    iCharsArabic[i] = "ت"
                case "j","g" :
                    iCharsArabic[i] = "ج" // "dj"
                
                case "h" :
                    if(i>0){
                        switch iChars[i-1] {
                        case "s","c" :
                            iCharsArabic[i] = "ش"
                            iCharsArabic[i-1] = "\0"
                            iChars[i-1] = "\0"
                        case "d" :
                            iCharsArabic[i] = "ظ"
                            iCharsArabic[i-1] = "\0"
                            iChars[i-1] = "\0"
                        case "g" :
                            iCharsArabic[i-1] = "غ"
                            iCharsArabic.remove(at: i)
                            iChars.remove(at: i)
                            //i = i + 1
                            //iCharsArabic[i-1] = "\0"
                            //iChars[i-1] = "\0"
                        case "e" :
                            iCharsArabic[i] = "ة"
                            iCharsArabic[i-1] = "\0"
                            iChars[i-1] = "\0"
                        default:
                            iCharsArabic[i] = "ه"
                        }
                    }
                    else{
                        iCharsArabic[i] = "ه" // ## e,ah and eh , maybe a
                    }
                    
                case "’" :
                    switch iChars[i-1] {
                    case "7" : // this is broken FIX!
                        iCharsArabic[i-1] = "خ"
                        iCharsArabic.remove(at: i)
                        iChars.remove(at: i)
                        iCharsArabic[i-1] = "\0"
                        iChars[i-1] = "\0"
                    case "3" :
                        iCharsArabic[i] = "غ"
                        iCharsArabic[i-1] = "\0"
                        iChars[i-1] = "\0"
                    case "9" :
                        iCharsArabic[i] = "ض"
                        iCharsArabic[i-1] = "\0"
                        iChars[i-1] = "\0"
                    case "6" :
                        iCharsArabic[i] = "ظ"
                        iCharsArabic[i-1] = "\0"
                        iChars[i-1] = "\0"
                    default:
                        iCharsArabic[i] = "'"
                    }

                default:
                    print ("none")
                    
                }
           
                // figure out spacing issue
                //iChars[i] == "s" ? iCharsArabic[i] = "ث" : nil // iChars[i] ="th" if statement
                
                /*
                 "d" "dh" => ض
                 "z" "th" => ظ
                 "a" "e" "at" "et" => ة
                 */
                
                print(i)
                print ("str " + String(strLength) )
                i = i + 1
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

/*iCharsArabic[i-1] = "خ"
 iCharsArabic[i] = "\0"
 iChars[i] = "\0"*/
//might be useful for other letters
// spacing issues for the nulls

/* Database
 (iChars[i] == "a" || iChars[i] == "e") ? iCharsArabic[i] = "ا" : nil  /*or e*/
 iChars[i] == "2" ? iCharsArabic[i] = "أ" : nil      //ء أ آ ؤ إ ئ
 (iChars[i] == "b" || iChars[i] == "p")  ? iCharsArabic[i] = "ب" : nil
 iChars[i] == "t" ? iCharsArabic[i] = "ت" : nil
 (iChars[i] == "j" || iChars[i] == "g")  ? iCharsArabic[i] = "ج" : nil  // "dj" if
 (iChars[i] == "w" || iChars[i] == "u") ? iCharsArabic[i] = "و" : nil //ou oo, maybe o
 (iChars[i] == "y" || iChars[i] == "i") ? iCharsArabic[i] = "ي" : nil //ee ei ai, maybe a
 iChars[i] == "7" ? iCharsArabic[i] = "ح" : nil
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
 iChars[i] == "n" ? iCharsArabic[i] = "ن" : nil*/


/*if (iChars[i] == "h") {
 if(i>0){
 if (iChars[i-1] == "s" || iChars[i-1] == "c" ){
 iCharsArabic[i] = "ش"
 iCharsArabic[i-1] = "\0"
 iChars[i-1] = "\0"
 }
 else if (iChars[i-1] == "d" ){
 iCharsArabic[i] = "ظ"
 iCharsArabic[i-1] = "\0"
 iChars[i-1] = "\0"
 }
 else if (iChars[i-1] == "g" ){
 iCharsArabic[i] = "غ"
 iCharsArabic[i-1] = "\0"
 iChars[i-1] = "\0"
 }
 else if (iChars[i-1] == "e" ){
 iCharsArabic[i] = "ة"
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
 
 }*/


/*if (iChars[i] == "’") { // add or '
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
 
 }*/
