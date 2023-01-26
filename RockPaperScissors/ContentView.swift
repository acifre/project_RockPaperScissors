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
    @State private var showResult = false
    @State private var correctResult = false
    @State private var score = 0
    @State private var numberOfTurns = 0
    
    
    let choices = ["👊", "🖐️", "✌️"]
    
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
        
        NavigationView {
            
            VStack {

                Spacer()
                Text("Rock Paper Scissors")
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                VStack {
                    HStack {
                        Text("Computer's Choice \n\(choices[computerChoice])")
                            .font(.title.weight(.semibold))
                            .frame(maxWidth: 400, maxHeight: 100)
                            .background(.blue)
                            .cornerRadius(35)
                            .shadow(color: .black, radius: 3)
                            .padding()
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Text("For the player to _**\(shouldWin ? "WIN" : "LOSE")**_ they must choose...")
                            .font(.title2.weight(.semibold))
                            .padding()
                            .frame(maxWidth: 270, maxHeight: 100)
                            .background(.gray)
                            .cornerRadius(35)
                            .shadow(color: .black, radius: 3)
                        .multilineTextAlignment(.leading)
                    }
                }
                .padding()
                .frame(maxWidth: 400, maxHeight: 300)
//                .border(.black)
                .background(.white)
                .cornerRadius(35)
                .shadow(color: .white, radius: 5)
                
                
                Spacer()
                Spacer()
                Text("Player's Choice:")
                    .font(.title)
                HStack(spacing: 20) {
                    ForEach(0...2, id: \.self) { index in
                        Button(choices[index]) {
                            playerChoice = index
                            correctResult = checkChoice(objective: shouldWin, choice: playerWon)
                            changeScore(result: correctResult)
                            numberOfTurns += 1
                            showResult = true
                            
                        }
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: 100, maxHeight: 100)
                        .background(.blue)
                        .cornerRadius(35)
                        .shadow(color: .black, radius: 2)
                        
                    }
                }
                .frame(maxWidth: 350, maxHeight: 100)
                .padding()
                .background(.white)
                .cornerRadius(35)
                .shadow(color: .white, radius: 5)
                Text("Score: \(score)")
                    .font(.title2.weight(.semibold))
                Spacer()
                
            }
            .padding(.horizontal)
            .alert(correctResult ? "Correct!" : "Wrong!", isPresented: $showResult) {
                Button(numberOfTurns <= 10 ? "Continue" : "Reset Game", action: numberOfTurns <= 10 ? resetRound : resetGame)
            } message: {
                if numberOfTurns <= 10 {
                    Text("\(correctResult ? "Player won!" : "Player lost!")")
                } else {
                    Text("Game over... final score: \(score)")
                }
                
            }
            .navigationTitle("RockPaperScissors")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    func checkChoice(objective: Bool, choice: Bool) -> Bool {
        (objective && choice) || (!objective && !choice)

    }
    
    func resetRound() {
        computerChoice = Int.random(in: 0...2)
        playerChoice = 0
        shouldWin.toggle()
    }
    
    func resetGame() {
        computerChoice = Int.random(in: 0...2)
        playerChoice = 0
        shouldWin.toggle()
        score = 0
        numberOfTurns = 0
    }
    
    func changeScore(result: Bool) {
        
        if result {
            score += 1
        } else if !result && score >= 1 {
            score -= 1
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
