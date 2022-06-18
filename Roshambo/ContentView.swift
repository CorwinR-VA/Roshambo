//
//  ContentView.swift
//  Roshambo
//
//  Created by Corwin Rainier on 6/15/22.
//

import SwiftUI

struct ContentView: View {
    @State private var movePick = Int.random(in: 0...2)
    @State private var winLose = Bool.random()
    @State private var pointScore = 0
    @State private var totalTurns = 1
    @State private var winMatch = 0
    @State private var loseMatch = 0
    @State private var showPopup = false
    @State private var popupMessage = ""
    @State private var endLoop = false
    
    var rochamboMoves = ["ROCK", "PAPER", "SCISSORS"]
    
    var body: some View {
        ZStack {
            Color("customYellow")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Text("Score: \(pointScore)")
                        .font(.subheadline.weight(.black))
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Turn \(totalTurns)/10")
                        .font(.subheadline.weight(.black))
                    Spacer()
                }
                Spacer()
                VStack {
                    Text("You must")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(winLose ? "WIN" : "LOSE")")
                        .font(.system(size: 75).weight(.black))
                    Text("against")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } .frame(maxWidth: 225)
                Spacer()
                gameObjectiveImage()
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 225)
                Text(rochamboMoves[movePick])
                    .font(.title.weight(.heavy))
                Spacer()
                Text("SELECT")
                    .font(.system(size: 60).weight(.black))
                VStack {
                    HStack (alignment: .top) {
                        Spacer()
                        Button(action: {
                            winMatch = 2
                            loseMatch = 1
                            checkAnswerButton()
                        }, label: {
                            VStack {
                                Image("rock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 175)
                            }
                        })
                        Spacer()
                        Spacer()
                        Button(action: {
                            winMatch = 0
                            loseMatch = 2
                            checkAnswerButton()
                        }, label: {
                            VStack {
                                Image("paper")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 175)
                            }
                        })
                        Spacer()
                        Spacer()
                        Button(action: {
                            winMatch = 1
                            loseMatch = 0
                            checkAnswerButton()
                        }, label: {
                            VStack {
                                Image("scissors")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 175)
                            }
                        })
                        Spacer()
                    } .padding(.horizontal)
                    HStack {
                        Spacer()
                        Text("ROCK")
                            .fontWeight(.black)
                        Spacer()
                        Spacer()
                        Text("PAPER")
                            .fontWeight(.black)
                        Spacer()
                        Spacer()
                        Text("SCISSORS")
                            .fontWeight(.black)
                        Spacer()
                    }
                }
                Spacer()
            }
        }
        .alert(popupMessage, isPresented: $showPopup) {
            Button("Ro! Cham! Bo!", action: rerollGameObjectives)
        } message: {
            Text("Your current score is \(pointScore).")
        }
        .alert("Game Over", isPresented: $endLoop) {
            Button("Play Again?", action: restartGameLoop)
        } message: {
            Text("Your final score was \(pointScore)!")
        }
    }
    func gameObjectiveImage() -> Image {
        if movePick == 0 {
            return Image("rock")
        } else if movePick == 1 {
            return Image("paper")
        } else {
            return Image("scissors")
        }
    }
    func rerollGameObjectives() {
        if totalTurns < 10 {
            totalTurns += 1
            movePick = Int.random(in: 0...2)
            winLose = Bool.random()
        } else {
            endLoop = true
        }
    }
    func checkAnswerButton() {
        showPopup = true
        if winLose {
            if winMatch == movePick {
                pointScore += 1
                popupMessage = "Success!"
            } else {
                popupMessage = "Failed..."
                pointScore -= 1
            }
        } else {
            if loseMatch == movePick {
                pointScore += 1
                popupMessage = "Success!"
            } else {
                popupMessage = "Failed..."
                pointScore -= 1
            }
        }
    }
    func restartGameLoop() {
        pointScore = 0
        totalTurns = 0
        rerollGameObjectives()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
