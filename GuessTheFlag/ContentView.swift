//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Runzi Mu on 2023-12-23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var gameIsReset = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
            VStack {
                Spacer()
                Text ("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack (spacing: 15){
                    VStack {
                        Text("Tap the flag of...")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .padding(.bottom, 5)
                        Text(countries[correctAnswer])
                            .foregroundStyle(.linearGradient(colors: [.orange,.white], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: 400)
                .padding(.vertical, 30)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Button{gameIsReset = true}label: {
                    Label("Score: \(score)",systemImage: "flag.checkered")
                        .font(.title.bold())
                }
                .buttonStyle(.bordered)
                .tint(.white)
                .padding(.top,10)
                .alert("Restart the game?",isPresented: $gameIsReset){
                    Button("Restart",role: .destructive, action: resetGame)
                    Button("Cancel",role: .cancel, action: resumeGame)
                } message: {
                    Text("This action cannot be undone.")
                }
                Spacer()
            }
        }
        .ignoresSafeArea()
        .alert(scoreTitle,isPresented: $showingScore) {
            Button("Continue" , action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    func flagTapped(_ number:Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong! Dats the flag of \(countries[number])."
            score -= 1
        }
        showingScore = true
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func resetGame(){
        score = 0
        gameIsReset = true
        askQuestion()
    }
    func resumeGame(){
    }
}

#Preview {
    ContentView()
}
