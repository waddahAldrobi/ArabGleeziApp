//
//  ViewController.swift
//  arabGleezi
//
//  Created by Waddah Aldrobi on 2017-12-06.
//  Copyright © 2017 Waddah Aldrobi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var userOutput: UILabel!
    var strLength = 0
    var word = ""
    var word2 = ""
    var word3 = ""
    var iCharsStringArr = [String]()
    var y = 0
    var s = 0
    var iCharsString = ""
    var iCharsArabic = [Character]()
    
    var wordArr = [Character]()
    var wordArr2 = [Character]()
    var wordArr3 = [Character]()
    
    var tapped = "1"
    
    var spacePressed = false
    
    // This function
    
    @IBAction func isEditing(_ sender: Any) {
        //print(userInput.text)
        
        let userInputString = Array(userInput.text! as String)
        strLength = userInputString.count
        var tempArr = userInput.text?.split(separator: " ")
        
        var tempIndex = Int(tempArr!.count)
//        var tempIndexLen = tempArr![tempIndex-1].count
//        print (tempIndexLen-1)
        
        //if the user clicks a space, autmatically insert button three's character
        if (userInputString.count == 0){
            userInput.text = ""
        }
            // ### This where the problem is the space is making it tap
        else if spacePressed{
            spacePressed = false
            if tapped == "1"{button1Tapped(self)}
            else if tapped == "3"{button3Tapped(self); tapped="1"}
            
            userInput.text?.append(" ")
        }
            // for normal words
        else {
//            print(userInputString.count)
            //setup for recognizing only last word of userInput
            let temp = userInput.text! as String
            var temp1 = temp.split(separator: " ")
            
            strLength = userInput.text?.count ?? 0
            iCharsArabic = Array(String(temp1[temp1.count-1]))
            translate (iCharsArabic: &iCharsArabic)
            
            if (strLength < 1){
                userOutput.text = ""
                setCopyandPaste()
            }
            else{  //figure out how to do extra letter, and start determining location of letter in word
                
                
                // Awesome functions that filters out the nulls for me
                iCharsArabic = iCharsArabic.filter{$0 != "\0"}
                
                // All the following is the predictive bar suggestions
                iCharsString = String(iCharsArabic)
                iCharsStringArr = iCharsString.components(separatedBy: " ")
                
                let iCharsArabicString = String(iCharsArabic)
                var wordArray = iCharsArabicString.split(separator: " ")
                let lastWord = Array(wordArray[wordArray.count-1])
                
                (wordArr, wordArr2, wordArr3) = (lastWord, lastWord, lastWord)
                
                
                // Filters out letters to be filtered
                s = 0
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
        }
    }
    
    //Comment the shit out of here
    // Disable the mid button when it's blank
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var toolbarBottomConstraint: NSLayoutConstraint!
    var toolbarBottomConstraintInitialValue = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInput.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            //Run your function here
            print("SpaceBar is pressed")
            spacePressed = true
        }
        return true
    }
    
    // this just makes the predictive bar
    override func viewDidAppear(_ animated: Bool) {
        enableKeyboardHideOnTap()
        toolbarBottomConstraint.constant = 0
        self.toolbarBottomConstraintInitialValue = toolbarBottomConstraint.constant
        
        if (toolbarBottomConstraint.constant == 0){
            setCopyandPaste()
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
        setCopyandPaste()
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
        else{
            tapped = "1"
            var temp = userInput.text! as String        //
            var temp1 = temp.split(separator: " ")      // These lines take the last word t
            //Keeps it from breaking 
            if temp1.count != 0 { temp1.remove(at: (temp1.count - 1))}
            temp1.append(Substring(word))
            userInput.text = String(temp1.joined(separator: " "))
        }
    }
    
    
    // When the 3rd button of the predictive bar is tapped
    @IBAction func button3Tapped(_ sender: Any) {
        print("Button3 tapped")
        if (button1.title == "Paste"){  //paste does not work properly, will be investigated
            userInput.text = UIPasteboard.general.string
        }
        else{
            tapped = "3"
            var temp = userInput.text! as String        //
            var temp1 = temp.split(separator: " ")      // These lines take the last word t
            temp1.remove(at: (temp1.count - 1))
            temp1.append(Substring(word3))
            userInput.text = String(temp1.joined(separator: " "))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setCopyandPaste() {
        self.button1.title = "Copy"
        self.button2.title = ""
        self.button3.title = "Paste"
    }
    
    // Function that does the translating
    // Inefficent I know, I'll hash it if this proves successful
    func translate ( iCharsArabic: inout [Character] )  {
        var i = 0
        for i in i..<iCharsArabic.count {
            //i > 0 ? print(i) : nil
            switch iCharsArabic[i] {
            case "ؤ" :     iCharsArabic[i] = "ؤ"
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
                    switch iCharsArabic[i-1] {
                    case "s","c" :
                        iCharsArabic[i] = "ش"
                        iCharsArabic[i-1] = "\0"
                        iCharsArabic[i-1] = "\0"
                    case "d" :
                        iCharsArabic[i] = "ظ"
                        iCharsArabic[i-1] = "\0"
                        iCharsArabic[i-1] = "\0"
                    case "g" :
                        iCharsArabic[i-1] = "غ"
                        iCharsArabic[i-1] = "\0"
                        iCharsArabic[i-1] = "\0"
                    case "e" :
                        iCharsArabic[i] = "ة"
                        iCharsArabic[i-1] = "\0"
                        iCharsArabic[i-1] = "\0"
                    case "k" :
                        iCharsArabic[i] = "خ"
                        iCharsArabic[i-1] = "\0"
                        iCharsArabic[i-1] = "\0"
                    default:
                        iCharsArabic[i] = "ه"
                    }
                }
                else{
                    iCharsArabic[i] = "ه" // ## e,ah and eh , maybe a
                }
                
            case "’","'" :
                if(i>0){
                    switch iCharsArabic[i-1] {
                    case "ع" :
                        iCharsArabic[i] = "خ"
                        iCharsArabic[i-1] = "\0"
                    case "ع" :
                        iCharsArabic[i] = "غ"
                        iCharsArabic[i-1] = "\0"
                    case "ص" :
                        iCharsArabic[i] = "ض"
                        iCharsArabic[i-1] = "\0"
                    case "ط" :
                        iCharsArabic[i] = "ظ"
                        iCharsArabic[i-1] = "\0"
                        iCharsArabic[i-1] = "\0"
                    default:
                        iCharsArabic[i] = "'"
                    }
                }
                
            case "e" :
                if(i>0){
                    switch iCharsArabic[i-1] {
                    case "e" , "i" :
                        iCharsArabic[i] = "ي"
                        iCharsArabic[i-1] = "\0"
                        iCharsArabic[i-1] = "\0"
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
                    switch iCharsArabic[i-1] {
                    case "o","u" :
                        iCharsArabic[i] = "و"
                        iCharsArabic[i-1] = "\0"
                        iCharsArabic[i-1] = "\0"
                    default:
                        iCharsArabic[i] = "ع"
                    }
                }
                else{
                    iCharsArabic[i] = "ع"
                }
                
            case "u" :
                if(i>0){
                    switch iCharsArabic[i-1] {
                    case "o","u" :
                        iCharsArabic[i] = "و"
                        iCharsArabic[i-1] = "\0"
                        iCharsArabic[i-1] = "\0"
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
            if (i>0 && iCharsArabic[i-1]==iCharsArabic[i]){
                iCharsArabic[i-1]=="e" ? iCharsArabic[i] = "ي" : nil
                iCharsArabic[i] = "\0"
                iCharsArabic[i] = "\0"
            }
            
            // "th" "dh" "z" for ذ
            
            /*
             "d" "dh" => ض
             "z" "th" => ظ
             "a" "e" "at" "et" => ة
             */
        }
        
        
    }
    
    
}


