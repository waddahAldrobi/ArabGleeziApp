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
        strLength = userInput.text?.count ?? 0
        var iChars = Array(userInput.text!)
        var iCharsArabic = Array(userInput.text!)
        var iCharsString = ""
        
        //var wordsArr = userOutput.text?.split(separator: " ")
        var i = 0
        if (strLength < 1){
            userOutput.text = ""
            //print(i)
        }
        else{  //figure out how to do extra letter, and start determining location of letter in word
            for i in i..<strLength {
                //i > 0 ? print(i) : nil
                switch iChars[i] {
                case "7" :     iCharsArabic[i] = "ح" // also h
                case "5" :     iCharsArabic[i] = "خ"
                case "d" :     iCharsArabic[i] = "د"
                case "z" :     iCharsArabic[i] = "ز"
                case "r" :     iCharsArabic[i] = "ر"
                case "s" :     iCharsArabic[i] = "س"
                case "9" :     iCharsArabic[i] = "ص" // ## can also be s
                case "6" :     iCharsArabic[i] = "ط" // ## can also be t
                case "f","v":  iCharsArabic[i] = "ف"
                case "m" :     iCharsArabic[i] = "م"
                case "3" :     iCharsArabic[i] = "ع"
                case "8","q" : iCharsArabic[i] = "ق" // ## g and 2 too
                case "k" :     iCharsArabic[i] = "ك" // maybe g
                case "l" :     iCharsArabic[i] = "ل"
                case "n" :     iCharsArabic[i] = "ن"
                case "w" : iCharsArabic[i] = "و" //ou oo, maybe o
                case "y","i" : iCharsArabic[i] = "ي" // ai, maybe a
                case "a" :     iCharsArabic[i] = "ا"
                case "b","p" : iCharsArabic[i] = "ب"
                case "t" :     iCharsArabic[i] = "ت"
                case "j","g" : iCharsArabic[i] = "ج" // "dj"
                case "?" :     iCharsArabic[i] = "؟"
                case "," :     iCharsArabic[i] = "،"
                                /*ء أ آ ؤ إ ئ */
                case "2" :     iCharsArabic[i] = "أ"
                
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
                            iCharsArabic[i-1] = "\0"
                            iChars[i-1] = "\0"
                        case "e" :
                            iCharsArabic[i] = "ة"
                            iCharsArabic[i-1] = "\0"
                            iChars[i-1] = "\0"
                        case "k" :
                            iCharsArabic[i] = "خ"
                            iCharsArabic[i-1] = "\0"
                            iChars[i-1] = "\0"
                        default:
                            iCharsArabic[i] = "ه"
                        }
                    }
                    else{
                        iCharsArabic[i] = "ه" // ## e,ah and eh , maybe a
                    }
                    
                case "’","'" :
                    if(i>0){
                    switch iChars[i-1] {
                    case "7" :
                        iCharsArabic[i] = "خ"
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
                }
                    
                case "e" :
                    if(i>0){
                    switch iChars[i-1] {
                    case "e" , "i" :
                        iCharsArabic[i] = "ي"
                        iCharsArabic[i-1] = "\0"
                        iChars[i-1] = "\0"
                    default:
                        iCharsArabic[i] = "ا"
                    }
                  }
                    else{
                        iCharsArabic[i] = "ا"
                    }
                 // Case o and u can all be refactored into 1 case, will look into later
                 case "o","O" :
                    if(i>0){
                        switch iChars[i-1] {
                        case "o","u" :
                            iCharsArabic[i] = "و"
                            iCharsArabic[i-1] = "\0"
                            iChars[i-1] = "\0"
                        default:
                            iCharsArabic[i] = "ع"
                        }
                    }
                    else{
                        iCharsArabic[i] = "ع"
                    }
                    
                case "u" :
                    if(i>0){
                        switch iChars[i-1] {
                        case "o","u" :
                            iCharsArabic[i] = "و"
                            iCharsArabic[i-1] = "\0"
                            iChars[i-1] = "\0"
                        default:
                            iCharsArabic[i] = "و"
                        }
                    }
                    else{
                        iCharsArabic[i] = "و"
                    }

                default: break
                    
                    
                }
                
                // In the case of duplicates
                if (i>0 && iChars[i-1]==iChars[i]){
                    iChars[i-1]=="e" ? iCharsArabic[i] = "ي" : nil
                    iCharsArabic[i] = "\0"
                    iChars[i] = "\0"
                }
        
                //iChars[i] == "s" ? iCharsArabic[i] = "ث" : nil // iChars[i] ="th" if statement
                // "th" "dh" "z" for ذ
                
                /*
                 "d" "dh" => ض
                 "z" "th" => ظ
                 "a" "e" "at" "et" => ة
                 */
                
                //print(i)
                //print ("str " + String(strLength) )
                //i = i + 1
            }
            
            // Awesome functions that filters out the nulls for me <3s
            iCharsArabic = iCharsArabic.filter{$0 != "\0"}
            userOutput.text = String(iCharsArabic)
            
            // All the following is the suggestions options
            iCharsString = String(iCharsArabic)
            var iCharsStringArr = [String]()
            iCharsStringArr = iCharsString.components(separatedBy: " ")
            //print(iCharsStringArr[0])
            
            var y = 0
            var wordArr = [Character]()
            var wordArr2 = [Character]()
            var wordArr3 = [Character]()
            var word = ""
            var word2 = ""
            var word3 = ""
            while (y < iCharsStringArr.count){
                wordArr = Array(iCharsStringArr[y])
                wordArr2 = Array(iCharsStringArr[y])
                wordArr3 = Array(iCharsStringArr[y])
                
                y = y + 1
            }
            
            var s = 0
            while (s < wordArr.count){
                //print (wordArr[s])
                if (s != 0 && wordArr[s] == "ا"){
                    wordArr[s] = "\0"
                    wordArr2[s] = "ى"
                    wordArr3[s] = "ؤ"
                }
                
                s = s + 1
            }
            
            wordArr = wordArr.filter{$0 != "\0"}
            wordArr2 = wordArr2.filter{$0 != "\0"}
            wordArr3 = wordArr3.filter{$0 != "\0"}
            
            word = String(wordArr)
            word2 = String(wordArr2)
            word3 = String(wordArr3)
            
//            print (word)
//            print (word2)
//            print (word3)
        }
        // Ends here 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    /* func trasnlate (iChars: [String]){
     later implement
     
     if (iChars[i] == " "){
     print (iChars[i-1])
     }
     }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
