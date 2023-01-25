//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anthony Cifre on 1/25/23.
//

import SwiftUI

//Each turn of the game the app will randomly pick either rock, paper, or scissors.
//Each turn the app will alternate between prompting the player to win or lose.
//The player must then tap the correct move to win or lose the game.
//If they are correct they score a point; otherwise they lose a point.
//The game ends after 10 questions, at which point their score is shown.

struct ContentView: View {
    
    @State private var computerChoice = 0
    @State private var playerChoice = 0
    @State private var shouldWin = false
    
    
    let choices = ["Rock", "Paper", "Scissors"]
    
    var toWinChoice: Int {
        //rock -> paper (1)
        //paper -> scissor (2)
        //scissor -> rock (0)
        
        switch computerChoice {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 0
        default:
            return 0
        }
        
    }
    
    var playerWon: Bool  {
        
        playerChoice == toWinChoice
        
    }
    
    var body: some View {
        VStack {
            
            Text("Rock Paper Scissors!")
        }
        .padding()
    }
    
    func checkChoice(objective: Bool, choice: Int) -> Bool {
        
        objective && playerWon
        
    }
    
    func resetRound() {
        computerChoice = Int.random(in: 0...2)
        playerChoice = 0
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
