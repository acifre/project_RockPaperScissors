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
                Spacer()
                Text("Computer's Pick: \(choices[computerChoice])")
                    .font(.largeTitle.weight(.bold))
                    .frame(width: 350, height: 100)
                    .background(.blue)
                    .cornerRadius(35)
                    .shadow(color: .white, radius: 3)
                    .padding()
                Text("For the player to _**\(shouldWin ? "WIN" : "LOSE")**_ they must pick...")
                    .font(.title2.weight(.semibold))
                    .frame(width: 250, height: 100)
                    .background(.secondary)
                    .cornerRadius(35)
                    .multilineTextAlignment(.trailing)
                
                Spacer()
                Spacer()
                
                HStack {
                    ForEach(0...2, id: \.self) { index in
                        Button(choices[index]) {
                            playerChoice = index
                            correctResult = checkChoice(objective: shouldWin, choice: playerWon)
                            showResult = true
                            
                        }
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .background(.blue)
                        .cornerRadius(35)
                        .shadow(color: .white, radius: 2)
                        
                    }
                }
                Spacer()
                
            }
            .padding()
            .alert("Result", isPresented: $showResult) {
                Button("Continue", action: resetRound)
            } message: {
                Text("\(correctResult ? "Player won!" : "Player lost!")")
            }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
