//
//  ViewController.swift
//  BowlingScorer
//
//  Created by BJ Brooks  on 6/2/17.
//  Copyright © 2017 brookswebpro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var frame10LabelTS: UILabel!
    @IBOutlet weak var frame10Label3: UILabel!
    @IBOutlet weak var frame10Label2: UILabel!
    @IBOutlet weak var frame10Label1: UILabel!
    @IBOutlet weak var frame9LabelTS: UILabel!
    @IBOutlet weak var frame9Label2: UILabel!
    @IBOutlet weak var frame8LabelTS: UILabel!
    @IBOutlet weak var frame9Label1: UILabel!
    @IBOutlet weak var frame8Label2: UILabel!
    @IBOutlet weak var frame8Label1: UILabel!
    @IBOutlet weak var frame7LabelTS: UILabel!
    @IBOutlet weak var frame7Label2: UILabel!
    @IBOutlet weak var frame7Label1: UILabel!
    @IBOutlet weak var frame6LabelTS: UILabel!
    @IBOutlet weak var frame6Label2: UILabel!
    @IBOutlet weak var frame6Label1: UILabel!
    @IBOutlet weak var frame5LabelTS: UILabel!
    @IBOutlet weak var frame5Label1: UILabel!
    @IBOutlet weak var frame5Label2: UILabel!
    @IBOutlet weak var frame4LabelTS: UILabel!
    @IBOutlet weak var frame4Label2: UILabel!
    @IBOutlet weak var frame3LabelTS: UILabel!
    @IBOutlet weak var frame4Label1: UILabel!
    @IBOutlet weak var frame3Label2: UILabel!
    @IBOutlet weak var frame3Label1: UILabel!
    @IBOutlet weak var frame2LabelTS: UILabel!
    @IBOutlet weak var frame2Label2: UILabel!
    @IBOutlet weak var frame2Label1: UILabel!
    @IBOutlet weak var frame1LabelTS: UILabel!
    @IBOutlet weak var frame1Label2: UILabel!
    @IBOutlet weak var frame1Label1: UILabel!
    @IBOutlet weak var enterButton1: UIButton!
    @IBOutlet weak var testLabel: UILabel!
    
    private var firstScoreLabelsArray = [UILabel]()
    private var secondScoreLabelsArray = [UILabel]()
    private var totalScoreLabelsArray = [UILabel]()
    
    var highScoresArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var tempScoresArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var frameFirstScore = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]
    var gameNumber = 1
    var gameScores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var totalScores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var totalScore = 0
    var isStrike = false
    var isSpare = false
    var isStrikeA = false
    var isStrikeB = false
    var isStrikeC = false
    var i = 1
    var j = 0
    var secondRoll = false
    var roll1 = 0
    var roll2 = 0
    var rolls = 2
    var num1 = 0
    var prevRoll = 0
    var tenStrike1 = false
    var tenStrike2 = false
    var tenSpare = false
    var isGameOver = false
    var highGameScore = 0
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var resetHighScores: UIButton!
    
    @IBOutlet weak var resetNoButton: UIButton!
    
    
    @IBOutlet weak var resetYesButton: UIButton!
    
    
    @IBAction func resetYesBtnPressed(_ sender: Any) {
        testLabel.text = ""
        testLabel.alpha = 0
        resetHighScoreArray()
        resetHighScores.alpha = 0
        print (highScoresArray)
        resetYesButton.alpha = 0
        resetNoButton.alpha = 0
        playAgainButton.alpha = 1
    }
    
    @IBAction func resetNoBtnPressed(_ sender: Any) {
        testLabel.text = ""
        testLabel.alpha = 0
        resetYesButton.alpha = 0
        resetNoButton.alpha = 0
        resetHighScores.alpha = 1
        playAgainButton.alpha = 1
    }
    
    
    
    @IBAction func resetHighScoresButton(_ sender: Any) {
        testLabel.alpha = 1
        testLabel.text = "ARE YOU SURE YOU WANT TO DELETE YOUR HIGH SCORES?"
        resetHighScores.alpha = 0
        resetYesButton.alpha = 1
        resetNoButton.alpha = 1
        playAgainButton.alpha = 0
    }
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        
        testLabel.text = ""
        testLabel.alpha = 0
        textField1.text = ""
        
        resetScores()
        gameNumber += 1
        
        playAgainButton.alpha = 0
        
        enterButton1.alpha = 1
        resetHighScores.alpha = 0
    }
    
    @IBAction func pressButton1(_ sender: Any) {
  
        self.textField1.resignFirstResponder()
         let testNum = Int(textField1.text!)
         if let num1 = testNum {
            textField1.text = ""
 if (!isGameOver && (num1 > 10-prevRoll || num1 < 0)) {
        testLabel.alpha = 1
         testLabel.text = "Score must be a number between 0 and \(10-prevRoll). Try again."
    } else if (!isGameOver) {
         testLabel.text = ""
        testLabel.alpha = 0
    if (i==10) {
        tenthFrame(num1: num1)
    } else {
        if  num1 == 10 {
            if (!secondRoll) {
                frameFirstScore[i-1][0] = 10
              if (isStrikeA && isStrikeB) {
                    frameFirstScore[i-2][1] = 10
                    frameFirstScore[i-3][2] = 10
                printTotal(frame: i-2)
                 } else if (isStrikeA) {
                        isStrikeB = true
                    frameFirstScore[i-2][1] = 10
                 } else if (isSpare) {
                            frameFirstScore[i-2][2] = 10
                            isSpare = false
                    printTotal(frame: i-1)
                    isStrikeA = true
              } else {
                isStrikeA = true
                }
                    displayStrike(frame: i)
            } else { //num is 10, and is a spare in second box
                frameFirstScore[i-1][1] = 10
                isSpare = true
                displaySpare(frame: i)
                secondRoll = false
                if (isStrikeA) {
                    frameFirstScore[i-2][2] = num1
                    printTotal(frame: i-1)
                    isStrikeA = false
                }
                }
            i += 1
            prevRoll = 0
        } else {
            if (!secondRoll) {
                roll1 = num1
                frameFirstScore[i-1][0] = roll1
                secondRoll = true
                displayFirstScore (frame: i, roll: roll1)
                  if (isStrikeA && isStrikeB) {
                        frameFirstScore[i-2][1] = roll1
                        frameFirstScore[i-3][2] = roll1
                    printTotal(frame: i-2)
                        isStrikeB = false
                 } else if (isStrikeA) {
                        frameFirstScore[i-2][1] = roll1
                 } else if (isSpare) {
                    frameFirstScore[i-2][2] = roll1
                    isSpare = false 
                    printTotal(frame: i-1)
                 }
           prevRoll = roll1
            } else {
                roll2 = num1
                frameFirstScore[i-1][1] = roll2
              if (isStrikeA) {
                    frameFirstScore[i-2][2] = roll2
                    isStrikeA = false
                printTotal(frame: i-1)
                 }
                if frameFirstScore[i-1][0] + frameFirstScore [i-1][1] == 10 {
                    displaySpare (frame: i)
                    isSpare = true
                } else {
                    displaySecondScore (frame: i, roll: roll2)
                  printTotal(frame: i)
                }
                i += 1
                secondRoll = false
              prevRoll = 0
            }
        }
    }
}
         } else {
            testLabel.alpha = 1
            testLabel.text = "Score must be a number between 0 and \(10-prevRoll). Try again."
        }
}
 
    func tenthFrame(num1: Int) {
        if (!isGameOver) {
            if (((num1 == 10) && (j == 0)) || ((num1 == 10) && (j >= 1) && (frameFirstScore [9][j-1] == 10))) {
                frameFirstScore [i-1][j] = 10
                prevRoll = 0
                displayStrikein10 (box: j+1)
                if (isStrikeA && isStrikeB) {
                    frameFirstScore [i-3][2] = 10
                    frameFirstScore [i-2][1] = 10
                    isStrikeB = false
                    printTotal(frame: i-2)
                } else if (isStrikeA) {
                    frameFirstScore[i-2][j+1] = 10
                    if (j >= 1) {
                        printTotal (frame: i-1)
                        isStrikeA = false
                    }
                } else if (isSpare) {
                    frameFirstScore[i-2][2] = 10
                    isSpare = false
                    printTotal (frame: i-1)
                }
                if (tenStrike1 && tenStrike2) {
                    printTotal(frame: i)
                } else if (tenStrike1) {
                    tenStrike2 = true
                } else if (tenSpare) {
                    frameFirstScore [i-1][2] = 10
                    printTotal(frame: i)
                }  else {
                    tenStrike1 = true
                    rolls = 3
                }
            } else {        //end of STRIKE bracket
                frameFirstScore[9][j] = num1
                if (isStrikeA && isStrikeB) {
                    frameFirstScore [i-3][2] = num1
                    frameFirstScore [i-2][1] = num1
                    isStrikeB = false
                    prevRoll = num1
                    printTotal(frame: i-2)
                } else if (isStrikeA) {
                    frameFirstScore [i-2][j+1] = num1
                    prevRoll = num1 //leave this or not
                    if (j >= 1) {
                        isStrikeA = false
                        printTotal(frame: i-1)
                    }
                } else if (isSpare) {
                    frameFirstScore [i-2][2] = num1
                    isSpare = false
                    prevRoll = num1
                    printTotal (frame: i-1)
                }
                if (tenStrike1 && tenStrike2) {
                    frameFirstScore[9][j] = num1
                    // prevRoll = num1
                    displayScorein10(box: j+1, score: num1)
                    printTotal(frame: 10)
                }  else if (tenStrike1) {
                    frameFirstScore[9][j] = num1
                    if (j >= 2) {
                        if (frameFirstScore[9][j-1] + frameFirstScore[9][j] == 10){
                            displaySparein10(box: j+1)
                            prevRoll = 0
                        } else {
                            displayScorein10(box: j+1, score: num1)
                            prevRoll = num1
                        }
                        printTotal(frame: 10)
                        tenStrike1 = false
                    } else {
                        displayScorein10(box: j+1, score: num1)
                        prevRoll = num1
                    }
                } else if (tenSpare) {
                    if (num1 == 10) {
                        displayStrikein10 (box: j+1)
                        frameFirstScore [i-1][2] = 10
                        printTotal(frame: i)
                    } else {
                        displayScorein10(box: j+1, score: num1)
                        printTotal(frame: 10)
                    }
                } else if ((j >= 1) && frameFirstScore[9][j-1] + frameFirstScore [9][j] == 10) {
                    displaySparein10 (box: j+1)
                    tenSpare = true
                    prevRoll = 0
                    rolls = 3
                } else {
                    displayScorein10(box: j+1, score: num1)
                    prevRoll = num1
                    if (j==1) {
                        printTotal(frame: 10)
                    }
                }
            }//END OF NUMBER 0-9 BRACKET
        
            j += 1
            
        if (j == rolls) {
            isGameOver = true
            gameOver()
            printTotal(frame: i)
        }
    }
    }

     func displayStrikein10 (box: Int) {
        switch box {
            case 1:
                frame10Label1.text = "X"
            case 2:
                frame10Label2.text = "X"
            case 3:
                frame10Label3.text = "X"
            default:
                break
        }
     }

     func displaySparein10 (box: Int) {
        switch box {
            case 2:
                frame10Label2.text = "/"
            case 3:
                frame10Label3.text = "/"
            default:
                break
        }
     }

     func displayScorein10 (box: Int, score: Int) {
        var printItem = ""
        if (score == 0) {
            printItem = "-"
        } else {
            printItem = "\(score)"
        }
        switch box {
            case 1:
                frame10Label1.text = printItem
            case 2:
                frame10Label2.text = printItem
            case 3:
                frame10Label3.text = printItem
            default:
                break
        }
     }

    func clearScorein10 (box: Int) {
        switch box {
            case 1:
                frame10Label1.text = ""
            case 2:
                frame10Label2.text = ""
            case 3:
                frame10Label3.text = ""
            default:
                break
        }
    }
    
    func gameOver() {
       var message = "GAME OVER!"
        

        enterButton1.alpha = 0

        playAgainButton.alpha = 1
        
        
        compareScores(score: totalScores[10])
        
        message += " Your score for the game is "
        
        message += "\(totalScores[10])"
        
        message += ". Your high scores are: "
        
        for i in 1...10 {
            message += "(" + "\(i)" + ")" + " " + "\(highScoresArray[i-1]) "
        }
        message += ". Press play again for new game."
        
        testLabel.alpha = 1
        testLabel.text = message
        
        resetHighScores.alpha = 1
    
    }
    
    func resetHighScoreArray() {
        for i in 1...10 {
            highScoresArray[i-1] = 0
        }
        resetHighScores.alpha = 0
        testLabel.text = ""
        testLabel.alpha = 0
        
        UserDefaults.standard.set(highScoresArray, forKey: "scores")
    }
    
    func compareScores (score: Int) {

        var addScore = false
        var i = 1
        while (!addScore && i <= 10) {
            if (score > highScoresArray[i-1]) {
                addScore = true
                addNewScore(newScore: score, index: (i-1))
            }
            i = i + 1
        }
        
    }
    
    func addNewScore (newScore: Int, index: Int) {
        var temp1 = 0
        var temp2 = 0
        var i = index
        if (i == 9) {
            highScoresArray[i] = newScore
        } else {
            temp1 = highScoresArray[i]
            highScoresArray[i] = newScore
            i = i+1
            while (i <= 9) {
                temp2 = highScoresArray[i]
                highScoresArray[i] = temp1
                temp1 = temp2
                i = i + 1
            }
        }		
        highScoresArray.sort(by: >)
        UserDefaults.standard.set(highScoresArray, forKey: "scores")
    }

    func resetScores () {

        // reset game values
        
        totalScore = 0
        isStrike = false
        isSpare = false
        isStrikeA = false
        isStrikeB = false
        i = 1
        j = 0
        secondRoll = false
        roll1 = 0
        roll2 = 0
        rolls = 2
        num1 = 0
        prevRoll = 0
        tenStrike1 = false
        tenStrike2 = false
        tenSpare = false
        isGameOver = false

        // reset all scores
        
        frameFirstScore = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]
        totalScores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        clearFirstScore()
        
        clearSecondScore()

        clearTotalScore()

        for k in 1...3 {
            clearScorein10(box: k)
        }
    }
    
    func displayFirstScore (frame: Int, roll: Int) {
        var printItem = ""
        if (roll == 0) {
            printItem = "-"
        } else {
            printItem = "\(roll)"
        }
         firstScoreLabelsArray[frame-1].text = printItem
    }

    func displaySecondScore (frame: Int, roll: Int) {
        var printItem = ""
        if (roll == 0) {
            printItem = "-"
        } else {
            printItem = "\(roll)"
        }
        secondScoreLabelsArray[frame-1].text = printItem
    }
    
    func displayTotalScore (frame: Int, score: Int) {
        totalScoreLabelsArray[frame-1].text = "\(score)"
    }
    
    func displayStrike (frame: Int) {
        secondScoreLabelsArray[frame-1].text = "X"
    }
    
    func displaySpare (frame: Int) {    //CHANGED
        secondScoreLabelsArray[frame-1].text = "/"
    }
    
  func printTotal(frame:Int) {
     totalScores[frame] = totalScores[frame-1] + frameFirstScore[frame-1][0] + frameFirstScore[frame-1][1] + frameFirstScore[frame-1][2]
     displayTotalScore (frame: frame, score: totalScores[frame])
    }
    
    func clearFirstScore () {         //CHANGED
         for i in 1...9 {
            firstScoreLabelsArray[i-1].text = ""
         }
    }

    func clearSecondScore () {        //CHANGED
         for i in 1...9 {
            secondScoreLabelsArray[i-1].text = ""
         }
    }
    
    func clearTotalScore () {     //CHANGED
        for i in 1...10 {
            totalScoreLabelsArray[i-1].text = ""
        }
    }
    
   
    
   override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    playAgainButton.alpha = 0
    resetHighScores.alpha = 0
    resetYesButton.alpha = 0
    resetNoButton.alpha = 0

    // round corners of buttons
    
    playAgainButton.layer.cornerRadius = 5
    playAgainButton.clipsToBounds = true
    resetHighScores.layer.cornerRadius = 5
    resetHighScores.clipsToBounds = true
    resetYesButton.layer.cornerRadius = 5
    resetYesButton.clipsToBounds = true
    resetNoButton.layer.cornerRadius = 5
    resetNoButton.clipsToBounds = true
    enterButton1.layer.cornerRadius = 5
    enterButton1.clipsToBounds = true
    
    
    firstScoreLabelsArray = [frame1Label1, frame2Label1, frame3Label1, frame4Label1, frame5Label1, frame6Label1, frame7Label1, frame8Label1, frame9Label1]
    
    secondScoreLabelsArray = [frame1Label2, frame2Label2, frame3Label2, frame4Label2, frame5Label2, frame6Label2, frame7Label2, frame8Label2, frame9Label2]
    
    totalScoreLabelsArray = [frame1LabelTS, frame2LabelTS, frame3LabelTS, frame4LabelTS, frame5LabelTS, frame6LabelTS, frame7LabelTS, frame8LabelTS, frame9LabelTS, frame10LabelTS]
    
    let arrayObject = UserDefaults.standard.object(forKey: "scores")
    var array = [Int]()
    
    if let tempArray = arrayObject as? [Int] {
    
        array = tempArray
    } else {
    
 //       print("No array in storage, now saving one")
        UserDefaults.standard.set(highScoresArray, forKey: "scores")
        let arrayObject = UserDefaults.standard.object(forKey: "scores")
        
        if (arrayObject as? [Int]) != nil {
            array = arrayObject as! [Int]
//            print("Array has been stored and retrieved")
//            print(array)
            
        }
    
    }
    highScoresArray = array     //cannot convert NSArray to Int (global array)
    }

   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

