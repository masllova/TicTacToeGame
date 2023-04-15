//
//  ViewController.swift
//  TicTacToeGame
//
//  Created by Александра Маслова on 15.04.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    enum Turn {
        case Nought
        case Cross
    }
    
    var firstTurn = Turn.Cross
    var curentTurn = Turn.Cross
    
    var nought = "O"
    var cross = "X"
    var board = [UIButton]()
    
    var crossScore = 0
    var noughtScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
        // Do any additional setup after loading the view.
    }
  
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        if checkForVictory(cross) {
            crossScore += 1
            resultAlert(title: "A \(cross) win!")
            
        }
        if checkForVictory(nought) {
            noughtScore += 1
            resultAlert(title: "A \(nought) win!")
            
        }
        if fullBoard() {
            resultAlert(title: "Draw")
        }
    }
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        
        board.append(b1)
        board.append(b2)
        board.append(b3)
        
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    func checkForVictory(_ s: String) -> Bool {
        if thisSympbol(a1, s) && thisSympbol(a2, s) && thisSympbol(a3, s) {return true}
        if thisSympbol(b1, s) && thisSympbol(b2, s) && thisSympbol(b3, s) {return true}
        if thisSympbol(c1, s) && thisSympbol(c2, s) && thisSympbol(c3, s) {return true}
        
        if thisSympbol(a1, s) && thisSympbol(b1, s) && thisSympbol(c1, s) {return true}
        if thisSympbol(a2, s) && thisSympbol(b2, s) && thisSympbol(c2, s) {return true}
        if thisSympbol(a3, s) && thisSympbol(b3, s) && thisSympbol(c3, s) {return true}
        
        if thisSympbol(a1, s) && thisSympbol(b2, s) && thisSympbol(c3, s) {return true}
        if thisSympbol(a3, s) && thisSympbol(b2, s) && thisSympbol(c1, s) {return true}
        return false
    }
    
    func thisSympbol(_ button: UIButton, _ sympbol: String) -> Bool {
        button.title(for: .normal) == sympbol
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {return false}
        }
        return true
    }
    
    func resultAlert(title: String) {
        let message = "Score: \(nought)=\(noughtScore) and \(cross)=\(crossScore) "
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resedBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resedBoard () {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            turnLabel.text = cross
        }
        else if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            turnLabel.text = nought
        }
        curentTurn = firstTurn
    }
    
    func addToBoard(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            if curentTurn == Turn.Nought {
                sender.setTitle(nought, for: .normal)
                curentTurn = Turn.Cross
                turnLabel.text = cross
            }
            else if curentTurn == Turn.Cross {
                sender.setTitle(cross, for: .normal)
                curentTurn = Turn.Nought
                turnLabel.text = nought
            }
            sender.isEnabled = false
        }
    }

}

