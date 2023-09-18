//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ygor Simoura on 02/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var endGame = false
    @State private var scoreTitle = ""
    @State var atualScore = 0
    
    @State var attempts = 0
    
    @State var contries = ["Estonia", "France", "Germany", "Ireland", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color(red: 0.28, green: 0.23, blue: 0.54)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the falg of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(contries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(contries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(atualScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your Score Is \(atualScore)")
        }
        .alert(scoreTitle, isPresented: $endGame){
            Button("Restart", action: reset)
        } message: {
            Text("End the game, your total socre was: \(atualScore)")
        }
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correrct!"
            atualScore += 1
            attempts += 1
        } else {
            attempts += 1
            scoreTitle = "Wrong! This flag is of \(contries[number])"
        }
        
        if attempts == 8 {
            scoreTitle = "End game!"
            endGame = true
        } else {
            showingScore = true
        }
    }
    func askQuestion() {
        contries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func reset() {
        scoreTitle = "End Game"
        askQuestion()
        atualScore = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
