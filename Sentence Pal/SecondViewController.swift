//
//  SecondViewController.swift
//  Sentence Pal
//
//  Created by Jon Simington on 9/27/15.
//  Copyright (c) 2015 Jon Simington. All rights reserved.
//

import UIKit
import Parsimmon

extension String {
    func words() -> [String] {
        
        let range = Range<String.Index>(start: self.startIndex, end: self.endIndex)
        var words = [String]()
        
        self.enumerateSubstringsInRange(range, options: NSStringEnumerationOptions.ByWords) { (substring, _, _, _) -> () in
            words.append(substring!)
        }
        
        return words
    }
}

func random(range: Range<Int> ) -> Int
{
    var offset = 0
    
    if range.startIndex < 0   // allow negative ranges
    {
        offset = abs(range.startIndex)
    }
    
    let mini = UInt32(range.startIndex + offset)
    let maxi = UInt32(range.endIndex   + offset)
    
    return Int(mini + arc4random_uniform(maxi - mini)) - offset
}

// Returns the last character of a string
func lastChar(string: String) -> Character {
    let char: Character = string[string.endIndex.predecessor()]
    return char
}

// Returns the first character of a string
func firstChar(string: String) -> Character {
    let char: Character = string[string.startIndex]
    return char
}

class SecondViewController: UIViewController {

    // UITextFields
    @IBOutlet weak var structureTextField: UITextField!
    
    // UILabels
    @IBOutlet weak var structureLabel: UILabel!
    
    // UIButtons
    @IBOutlet weak var nounButton: UIButton!
    @IBOutlet weak var prepositionButton: UIButton!
    @IBOutlet weak var adjectiveButton: UIButton!
    @IBOutlet weak var verbButton: UIButton!
    @IBOutlet weak var determinerButton: UIButton!
    @IBOutlet weak var personalNameButton: UIButton!
    @IBOutlet weak var uarticleButton: UIButton!
    @IBOutlet weak var particleButton: UIButton!
    @IBOutlet weak var interjectionButton: UIButton!
    @IBOutlet weak var adverbButton: UIButton!
    @IBOutlet weak var placeNameButton: UIButton!
    @IBOutlet weak var conjunctionButton: UIButton!
    @IBOutlet weak var numberButton: UIButton!
    @IBOutlet weak var pronounButton: UIButton!
    @IBOutlet weak var orgNameButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var generatedText: UILabel!
    @IBOutlet weak var clearAllKeywordsButton: UIButton!
    
    // Button Actions
    @IBAction func nounButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " noun"
    }
    @IBAction func adverbButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " adverb"
    }
    @IBAction func personalNameButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " personal_name"
    }
    @IBAction func prepositionButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " preposition"
    }
    @IBAction func interjectionButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " interjection"
    }
    @IBAction func determinerButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " determiner"
    }
    @IBAction func particleButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " particle"
    }
    @IBAction func uarticleButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + "  uarticle"
    }
    @IBAction func orgNameButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " organization_name"
    }
    @IBAction func numberButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " number"
    }
    @IBAction func adjectiveButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " adjective"
    }
    @IBAction func conjunctionButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " conjunction"
    }
    @IBAction func verbButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " verb"
    }
    @IBAction func placeNameButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " place_name"
    }
    @IBAction func pronounButtonPressed(sender: UIButton) {
        structureTextField.text = structureTextField.text! + " pronoun"
    }
    @IBAction func generateButtonPressed(sender: UIButton) {
        generatedText.hidden = false
        generatedText.text = generateSentence(structureTextField.text!)
        
        if (generatedText.text == "") {
            generatedText.text = "Enter some keywords, ya doop!"
        }
    }
    @IBAction func clearAllKeywordsButtonPressed(sender: UIButton) {
        structureTextField.text = ""
    }
    
    
    // NLP machines
    let tokenizer = Tokenizer()
    let tagger = Tagger()
    let classifier = NaiveBayesClassifier()
    
    // Arrays to hold words of each tag
    var nouns: [String] = [""]
    var adjectives: [String] = [""]
    var verbs: [String] = [""]
    var determiners: [String] = [""]
    var prepositions: [String] = [""]
    var adverbs: [String] = [""]
    var conjunctions: [String] = [""]
    var numbers: [String] = [""]
    var pronouns: [String] = [""]
    var place_names: [String] = [""]
    var personal_names: [String] = [""]
    var particles: [String] = [""]
    var interjections: [String] = [""]
    var organization_names: [String] = [""]
    let uarticles: [String] = ["The", "A"]
    let space: String = " "
    
    // Fills arrays with words of their tag
    func setUp() {
        let taggedTokens = tagger.tagWordsInText(book_text)
        
        for token in taggedTokens {
            switch token.getTag {
            case "Noun":
                nouns.append(token.getToken.lowercaseString)
            case "Adjective":
                adjectives.append(token.getToken.lowercaseString)
            case "Verb":
                verbs.append(token.getToken.lowercaseString)
            case "Determiner":
                determiners.append(token.getToken.lowercaseString)
            case "Preposition":
                prepositions.append(token.getToken.lowercaseString)
            case "Adverb":
                adverbs.append(token.getToken.lowercaseString)
            case "Conjunction":
                conjunctions.append(token.getToken.lowercaseString)
            case "Number":
                numbers.append(token.getToken.lowercaseString)
            case "Pronoun":
                pronouns.append(token.getToken.lowercaseString)
            case "PlaceName":
                place_names.append(token.getToken.lowercaseString)
            case "PersonalName":
                personal_names.append(token.getToken.lowercaseString)
            case "Particle":
                particles.append(token.getToken.lowercaseString)
            case "Interjection":
                interjections.append(token.getToken.lowercaseString)
            case "OrganizationName":
                organization_names.append(token.getToken.lowercaseString)
            default:
                continue
            }
        }
    }

    // returns sentence built from structure passed
    func generateSentence(structure: String) -> String {
        var word: String = ""
        let words = structure.words()
        var string: String = ""
        
        
        
        for token in words {
            switch token.lowercaseString {
            case "noun":
                word = nouns[random(0...nouns.count-1)]
            case "adjective", "adj":
                word = adjectives[random(0...adjectives.count-1)]
            case "verb":
                word = verbs[random(0...verbs.count-1)]
            case "determiner", "det":
                word = determiners[random(0...determiners.count-1)]
            case "preposition", "prep":
                word = prepositions[random(0...prepositions.count-1)]
            case "adverb", "adv":
                word = adverbs[random(0...adverbs.count-1)]
            case "conjunction", "conj":
                word = conjunctions[random(0...conjunctions.count-1)]
            case "number":
                word = numbers[random(0...numbers.count-1)]
            case "pronoun":
                word = pronouns[random(0...pronouns.count-1)]
            case "place_name":
                word = place_names[random(0...place_names.count-1)]
            case "personal_name":
                word = personal_names[random(0...personal_names.count-1)]
            case "particle":
                word = particles[random(0...particles.count-1)]
            case "interjection":
                word = interjections[random(0...interjections.count-1)]
            case "organization_name":
                word = organization_names[random(0...organization_names.count-1)]
            case "uarticle":
                word = uarticles[random(0...uarticles.count-1)]
            case "<the>", "the":
                word = "the"
            case "<period>", "period":
                word = "."
                
            default:
                word = ""
            }
            
            if token == words[0] {
                word = word.capitalizedString
            }
            
            print(word)
            
            if word == "." {
                string += word
            }
            else {
                string += " " + word
            }
        }
        print(string)
        return string
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
