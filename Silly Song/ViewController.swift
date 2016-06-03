//
//  ViewController.swift
//  Silly Song
//
//  Created by 杨伟 on 16/6/3.
//  Copyright © 2016年 Udacity. All rights reserved.
//

import UIKit

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    // join an array of strings into a single template string:
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joinWithSeparator("\n")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(sender: AnyObject) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(sender: AnyObject) {
        lyricsView.text! = lyricsForName(bananaFanaTemplate, fullName: nameField.text!)
    }
    
    
    func shortNameForName(fullName: String) -> String {
        
        let lowercaseName = fullName.lowercaseString
        
        let vowelSet = NSCharacterSet(charactersInString: "aeiou")
        if let firstVowelRange = lowercaseName.stringByFoldingWithOptions(.DiacriticInsensitiveSearch, locale: nil).rangeOfCharacterFromSet(vowelSet) {
            return lowercaseName.substringFromIndex(firstVowelRange.startIndex)
        }
        // No vowels - return the full name
        return lowercaseName
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        let shortName = shortNameForName(fullName)
        
        return lyricsTemplate.stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName)
            .stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortName)
    }
    

}

