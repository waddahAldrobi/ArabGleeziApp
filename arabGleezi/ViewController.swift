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
    var arbitraryValue = 0
    
    var array = [Substring]()
    var index = 0
    
    
    @IBAction func isEditing(_ sender: Any) {
        userInput.makeTextWritingDirectionRightToLeft((Any).self)
        let userInputString = Array(userInput.text! as String)
        strLength = userInputString.count
        
//        arbitraryValue = (userInput.text?.count)!
//        print ("a: \(arbitraryValue)")
//        print ("w: \(wordArr.count)")
//        if let newPosition = userInput.position(from: userInput.endOfDocument, offset: arbitraryValue) {
//
//            userInput.selectedTextRange = userInput.textRange(from: newPosition, to: newPosition)
//        }
        let selectedRange: UITextRange? = userInput.selectedTextRange
        let cursorOffset: Int = userInput.offset(from: userInput.beginningOfDocument , to: (selectedRange?.start)!)
        let text: String = userInput.text!
        let substring: String? = (text as? NSString)?.substring(to: cursorOffset)
        let Words = substring?.components(separatedBy: " ")
        let lastWordEdited = substring?.components(separatedBy: " ").last
        index = (Words?.index(of: lastWordEdited!))!

        print (cursorOffset)
        print (index as Any)
        print(strLength)
        
        array = userInput.text!.split(separator: " ")
        print(array)
        
        var str = String(lastWordEdited!)
        

        if (userInput.text?.count == 0){
            userInput.text = " "
            setCopyandPaste()
        }

        else if spacePressed{
            spacePressed = false
            if cursorOffset == strLength{
                if tapped == "1"{button1Tapped(self)}
                else if tapped == "3"{button3Tapped(self); tapped="1"}
            }
            
//            userInput.text?.append(" ")
            // Magic so far is here
            userInput.insertText(" ")
            
            
//           userInput.text?.append(" ")
//           userInput.text?.insert(" ", at: cursorOffset)
            
        }
            // for normal words
        else if ((userInput.text?.count)! > 1) {

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
                
                var lastWord = Array(wordArray[wordArray.count-1])
                
                if cursorOffset != strLength {
                    lastWord = Array (array[index])
                }
                
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
                
                // Sets predictive bar button
                self.button1.title = String(wordArr)
                self.button2.title = String(wordArr2)
                self.button3.title = String(wordArr3)
                
                
                
        
//                userOutput.text = String(iCharsStringArr.joined(separator: " "))
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
    
    @IBOutlet weak var button1: UIBarButtonItem!
    @IBOutlet weak var button2: UIBarButtonItem!
    @IBOutlet weak var button3: UIBarButtonItem!
    
    @IBAction func button1Tapped(_ sender: Any) {
        print("Button1 tapped")
        if (button1.title == "Copy"){
            UIPasteboard.general.string = userInput.text!
        }
        else{
            tapped = "1"
            var temp = userInput.text! as String        //
            var temp1 = temp.split(separator: " ")      // These lines take the last word t
            //Keeps it from breaking 
            if temp1.count != 0 { temp1.remove(at: (temp1.count - 1))}
            temp1.append(Substring(String(wordArr)))
            userInput.text = String(temp1.joined(separator: " "))
        }
    }
    
    
    // When the 3rd button of the predictive bar is tapped
    @IBAction func button3Tapped(_ sender: Any) {
        print("Button3 tapped")
        if (button1.title == "Paste"){  //paste does not work properly, will be investigated
            userInput.text = UIPasteboard.general.string
//            iCharsArabic = Array(userInput.text!)
//            translate(iCharsArabic: &iCharsArabic)
        }

        else{
            tapped = "3"
            var temp = userInput.text! as String        //
            var temp1 = temp.split(separator: " ")      // These lines take the last word t
            if temp1.count != 0 { temp1.remove(at: (temp1.count - 1)) }
            temp1.append(Substring(String(wordArr3)))
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
    
    var mappings: [Character : Character] = [
       /*number*/"2" : "أ",  //also  /*ء أ آ ؤ إ ئ */
       /*number*/"3" : "ع",
       /*number*/"5" : "خ",
       /*number*/"6" : "ط",  //also "t"
       /*number*/"7" : "ح",  //also "h"
       /*number*/"8" : "ق",
       /*number*/"9" : "ص",  //also "s"
        
                 "a" : "ا", // a lot more complicated
                 "b" : "ب",
                 "d" : "د",
                 "f" : "ف",
                 "g" : "ج", // "dj"
                 
                 "i" : "ي", // other letters
                 "j" : "ج",
                 "k" : "ك", // maybe g
                 "l" : "ل",
                 "m" : "م",
                 "n" : "ن",
                 
                 "p" : "ب",
                 "q" : "ق", // ## g and 2 too
                 "r" : "ر",
                 "s" : "س",
                 
                 "t" : "ت",
                 "v" : "ف",
                 
                 "w" : "و", //ou oo, maybe o
                 "y" : "ي", // ai, maybe a
                 "z" : "ز",
                 
     /*special*/ "?" :  "؟",
     /*special*/ "," :  "،"
        ]
    
    // Function that does the translating
    func translate ( iCharsArabic: inout [Character] )  {
        let i = 0
        for i in i..<iCharsArabic.count {
            // Calls the dictionary 
            iCharsArabic[i] = mappings[iCharsArabic[i], default: iCharsArabic[i] ]// also h
            switch iCharsArabic[i] {
            // Try to remember why you have those else's maybe it's fixed
            case "h" :
                if(i>0){
                    switch iCharsArabic[i-1] {
                    case "س","c" : iCharsArabic[i] = "ش"
                    case "ط" : iCharsArabic[i] = "ظ"
                    case "ج" : iCharsArabic[i] = "غ"
                    case "ه" : iCharsArabic[i] = "ة"
                    case "ك" : iCharsArabic[i] = "خ"
                        
                    default: iCharsArabic[i] = "ه"
                    }
                    
                    if iCharsArabic[i] != "ه"{iCharsArabic[i-1] = "\0"}
                }
                
                else{ iCharsArabic[i] = "ه"} // ## e,ah and eh , maybe a
                
            case "’","'" :
                if(i>0){
                    switch iCharsArabic[i-1] {
                        case "ح" :iCharsArabic[i] = "خ"
                        case "ع" :iCharsArabic[i] = "غ"
                        case "ص" :iCharsArabic[i] = "ض"
                        case "ط" :iCharsArabic[i] = "ظ"
                        default: iCharsArabic[i] = "'"
                    }
                    
                    if iCharsArabic[i] != "'"{iCharsArabic[i-1] = "\0"}
                }
                
            case "e" :
                if(i>0){
                    switch iCharsArabic[i-1] {
                    
                        case "ا" , "ي" : iCharsArabic[i] = "ي"
                        default:iCharsArabic[i] = "ا"
                    }
                    
                    if iCharsArabic[i] != "ا" {iCharsArabic[i-1] = "\0"}
                }
                
                else{ iCharsArabic[i] = "ا" }
            
            // Case o and u can all be refactored into 1 case, will look into later
            case "o","O" :
                if(i>0){
                    switch iCharsArabic[i-1] {
                        // the 3een doesnt seem right
                        case "ع","و" :iCharsArabic[i] = "و"
                        default: iCharsArabic[i] = "ع"
                    }
                    
                    if iCharsArabic[i] != "ع" {iCharsArabic[i-1] = "\0"}
                }
                else{ iCharsArabic[i] = "ع" }
                
            case "u" :
                if(i>0){
                    switch iCharsArabic[i-1] {
                        case "و" : iCharsArabic[i] = "و"
                        default: iCharsArabic[i] = "و"
                    }
                    
                    if iCharsArabic[i] != "و" {iCharsArabic[i-1] = "\0"}
                }
                else{iCharsArabic[i] = "و"}
                
            default: break
                
            }
            
            // In the case of duplicates
            if (i>0 && iCharsArabic[i-1]==iCharsArabic[i]){
                iCharsArabic[i-1]=="e" ? iCharsArabic[i] = "ي" : nil
                iCharsArabic[i] = "\0"
            }
            
        } // for i
    } //translate

    
    // keyboard related
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
    
}// Uiveiw


