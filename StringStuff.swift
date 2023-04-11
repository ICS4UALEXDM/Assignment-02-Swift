import Foundation
import Glibc
//
//  StringStuff.swift
//
//  Created by Alex De Meo
//  Created on 2023/02/11
//  Version 1.0
//  Copyright (c) 2023 Alex De Meo. All rights reserved.
//
//  This program is meant to demonstrate String manipulation at its finest

// creating input and output files
let inputFile = "input.txt"
let outputFile = "output.txt"

// opening the input file for reading
guard let input = FileHandle(forReadingAtPath: inputFile) else {
    print("Error: Cannot open input file.")
    exit(1)
}

// opening the output file for writing
guard let output = FileHandle(forWritingAtPath: outputFile) else {
    print("Error: Cannot open output file.")
    exit(1)
}

// Reading contents of input file
let inputData = input.readDataToEndOfFile()

// Converting data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("Error: Cannot convert data to string.")
    exit(1)
}

// Splitting string into separate lines
let lines = inputString.components(separatedBy: .newlines)

// calling the functions
let blowUps = blowUp(lines: lines)
let maxRuns = maxRun(lines: blowUps)

// Looping through blowUps and writing each line to the file
for result in blowUps {
    let outputData = String(result + "\n")
    output.write(outputData.data(using: .utf8)!)
}
// looping through maxRuns and writing each line to the file
for run in maxRuns {
    let outputData = String(run + "\n")
    output.write(outputData.data(using: .utf8)!)
}

// This function blows up a string. It iterates through every character in a
// String and if its a number, it takes the next character and prints it the
// same number of times
func blowUp(lines: Array<String>) -> Array<String> {
    // The array that will be sent back to main
    var newLines = [String]()
    newLines.append("Blow Up Program output: ")
    // Initialization of more variables
    var counter1 = 1
    var lineCounter = 0
    var isNum = false
    // Looping through the array of lines that was passed to this function
    for line in lines {
        // variable initialization
        var counter2 = 0
        var newSentence = ""
        // creating the char array that represents every char in the line
        let characters = Array(line)
        var newLine = [String]()
        // iterating through the characters in the line
        for char in characters {
            // checking to ensure its not the last character in the list
            if (counter2 != characters.count - 1) {
                // Checking to see if the current character is a number or not
                if let charNum = Int(character) {
                    isNum = true
                } else {
                    isNum = false
                }
                if (isNum) {
                    // If it is a number, than loop through that many times
                    for (i = 0; i < charNum; i++) {
                        // appending the next character to the newLine
                        newLine.append(characters[counter2 + 1])
                    }
                } else [
                    // Adding the character to the newLine
                    newLine.append(character)
                ]
            } else {
                // adding the character to the newLine
                newLine.append(character)
            }
            counter2 += 1
        }
        // Creating the new Sentence
        for piece in newLine {
            newSentence += piece
        }
        // adding the new sentence to the array that will be returned to main
        newLines.append(newSentence)
        counter1 ++
    }
    // returning to main
    return newLines
}

// This function finds the maximum run of characters in a string
func maxRun(lines: Array<String>) -> Array<String> {
    // Variable initialization
    var newLines = [String]()
    newLines.append("Max Run Program output: ")
    var counter1 = 1
    // Looping through the lines array
    for line in lines {
        // More variables that are needed inside of the loop
        var currRun = 0
        var topRun = 1
        var counter2 = 0
        // creating the array that breaks up the string into individual chars
        let characters = Array(line)

        // Setting the lastChar variable to the first place in the array
        var lastChar = characters[0]

        for char in characters {
            if (counter2 != characters.count - 1) {
                if (char == lastChar) {
                    currRun += 1
                } else {
                    if (currRun > topRun) {
                        topRun = currRun
                    }
                    currRun = 1
                }
                counter2 += 1
                // Setting the last char so that the next one can be compared
                // to this one
                lastChar = char
            } else {
                if (char == lastChar) {
                    currRun += 1
                    if (currRun > topRun) {
                        topRun = currRun
                    }
                } else {
                    if (currRun > topRun) {
                        topRun = currRun
                    }
                }
            }
        }
        let theTopRun = String("\(topRun)")
        newLines.append(theTopRun) 
        counter1 += 1
    }
    return newLines
}