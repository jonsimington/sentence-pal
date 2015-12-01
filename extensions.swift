//
//  extensions.swift
//  Sentence Pal
//
//  Created by Jon Simington on 9/25/15.
//  Copyright © 2015 JaySik Studios. All rights reserved.
//

import Foundation

// Generates a random number in range given
extension Int
{
    
}

// Converts string to array of words
extension String {
    var words:[String] {
        return "".join(componentsSeparatedByCharactersInSet(NSCharacterSet.punctuationCharacterSet())).componentsSeparatedByString(" ")
    }
}

