//
//  ContentView.swift
//  MealApp
//
//  Created by Rolande umuhoza on 6/15/23.
//

import SwiftUI

// Struct to represent a meal

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    
}
// Struct to represent the JSON response for a list of meals
struct MealListResponse: Codable {
    let meals: [Meal]
}

// View model class to fetch and manage meals
class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    func fetchMeals() {
        // API URL to fetch meals in the Dessert category
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        // Making a data task request to fetch the JSON data
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                // Decoding the JSON response into MealListResponse struct
                let response = try JSONDecoder().decode(MealListResponse.self, from: data)
                DispatchQueue.main.async {
                    // Sorting the meals alphabetically and updating the meals array
                    self.meals = response.meals.sorted(by: { $0.strMeal < $1.strMeal })
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct ContentView: View {
    @StateObject private var mealViewModel = MealViewModel()
    
    var body: some View {
        NavigationView {
            // Navigating to MealDetailView when a meal is tapped
            List(mealViewModel.meals, id: \.idMeal) { meal in
                NavigationLink(destination: MealDetailView(meal: meal)) {
                    Text(meal.strMeal)
                    
                }
            }
            
            .navigationTitle("Meals")
        }
        .onAppear {
            // Fetching the meals when the view appears
            mealViewModel.fetchMeals()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
