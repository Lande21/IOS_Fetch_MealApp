//
//  WelcomeView.swift
//  MealApp
//
//  Created by Rolande umuhoza on 6/16/23.
//  Created a welcome page for the Meal App
//  The page has a button to direct the user to another page
import SwiftUI

struct WelcomeView: View {
    @State private var isWelcomePresented = false
    
    var body: some View {
        VStack(spacing: 20) {
            //adding the icon
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 100))
                .foregroundColor(.orange)
            // a welcome text
            Text("Welcome to Meal App")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical, 40)
            //Button for action to see the meal page
            Button(action: {
                // Handling button action when pressed
                isWelcomePresented = true
            }) {
                Text("Click to Get Started")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.orange.opacity(0.8))
                    .cornerRadius(10)
            }
        }
        .fullScreenCover(isPresented: $isWelcomePresented) {
            ContentView()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
