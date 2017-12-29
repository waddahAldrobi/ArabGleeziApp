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
    var word2 = ""
    var word3 = ""
 
    @IBAction func isEditing(_ sender: Any) {
        userOutput.text = userInput.text
        strLength = userInput.text?.count ?? 0
        var iChars = Array(userInput.text!)
        var iCharsArabic = Array(userInput.text!)
        var iCharsString = ""
        
        //Will turn the english into arabic
        translate (iChars: &iChars , iCharsArabic: &iCharsArabic)
        
        if (strLength < 1){
            userOutput.text = ""
            //print(i)
            self.button1.title = "Copy"
            self.button2.title = ""
            self.button3.title = "Paste"
        }
        else{  //figure out how to do extra letter, and start determining location of letter in word
            
            
            // Awesome functions that filters out the nulls for me <3s
            iCharsArabic = iCharsArabic.filter{$0 != "\0"}
            
            // All the following is the suggestions options
            iCharsString = String(iCharsArabic)
            var iCharsStringArr = [String]()
            iCharsStringArr = iCharsString.components(separatedBy: " ")
            
            var wordArr = [Character]()
            var wordArr2 = [Character]()
            var wordArr3 = [Character]()
            
            // Sets the words that will be filtered
            var y = 0
            while (y < iCharsStringArr.count){
                wordArr = Array(iCharsStringArr[y])
                wordArr2 = Array(iCharsStringArr[y])
                wordArr3 = Array(iCharsStringArr[y])
                
                y = y + 1
            }
            
            // Filters out letters to be filtered
            var s = 0
            while (s < wordArr.count){
                if (s != 0 && wordArr[s] == "ا"){
                    //wordArr[s] = "\0"
                    wordArr2[s] = "ى"
                    wordArr3[s] = "ؤ"
                }
                
                s = s + 1
            }
            
            // Filters and turns to strings
            wordArr = wordArr.filter{$0 != "\0"}
            wordArr2 = wordArr2.filter{$0 != "\0"}
            wordArr3 = wordArr3.filter{$0 != "\0"}
            word = String(wordArr)
            word2 = String(wordArr2)
            word3 = String(wordArr3)
            
            // Sets predictive bar button
            self.button1.title = word
            self.button2.title = word2
            self.button3.title = word3
            
            userOutput.text = String(iCharsStringArr.joined(separator: " "))
        }
        // Ends here
        /* func trasnlate (iChars: [String]){
         later implement*/
    }
    
    //Comment the shit out of here
    // Disable the mid button when it's blank
    // Look into copy paste functions before going forward
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var toolbarBottomConstraint: NSLayoutConstraint!
    var toolbarBottomConstraintInitialValue = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        enableKeyboardHideOnTap()
        toolbarBottomConstraint.constant = 0
        self.toolbarBottomConstraintInitialValue = toolbarBottomConstraint.constant
        print("first")
        print (toolbarBottomConstraint.constant)
        
        if (toolbarBottomConstraint.constant == 0){
            self.button1.title = "Copy"
            self.button2.title = ""
            self.button3.title = "Paste"
            
        }
    }
    
    // Removes keyboard on Tap
    private func enableKeyboardHideOnTap() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    //Moves toolbar up
    @objc func keyboardWillShow(notification: NSNotification)
    {
        let info = notification.userInfo!
        
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate(withDuration: duration) {
            
            self.toolbarBottomConstraint.constant = keyboardFrame.size.height
            self.view.layoutIfNeeded()
        }
    }
    
    //Moves toolbar down
    @objc func keyboardWillHide(notification : NSNotification){
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate(withDuration: duration) {
            
            self.toolbarBottomConstraint.constant = self.toolbarBottomConstraintInitialValue
            self.view.layoutIfNeeded()
        }
        self.button1.title = "Copy"
        self.button2.title = ""
        self.button3.title = "Paste"
    }
    
    // Not sure what it does
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var button1: UIBarButtonItem!
    @IBOutlet weak var button2: UIBarButtonItem!
    @IBOutlet weak var button3: UIBarButtonItem!
    
    @IBAction func button1Tapped(_ sender: Any) {
        print("Button1 tapped")
        if (button1.title == "Copy"){
            UIPasteboard.general.string = userOutput.text!
        }
    }
    
    
    
    @IBAction func button3Tapped(_ sender: Any) {
        print("Button3 tapped")
        if (button1.title == "Paste"){  //paste does not work properly, will be investigated
        userInput.text = UIPasteboard.general.string
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func translate ( iChars: inout [Character] , iCharsArabic: inout [Character] )  {
        var i = 0
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
            
            // "th" "dh" "z" for ذ
            
            /*
             "d" "dh" => ض
             "z" "th" => ظ
             "a" "e" "at" "et" => ة
             */
            //iChars[i] == "s" ? iCharsArabic[i] = "ث" : nil // iChars[i] ="th" if statement
        }
        
        
    }
    
    
}


