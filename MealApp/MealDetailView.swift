//
//  MealDetailView.swift
//  MealApp
//
//  Created by Rolande umuhoza on 6/15/23.
//  

import SwiftUI
import URLImage

// Struct to represent the details of a meal
struct MealDetail: Codable {
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    // the maximun of 10 ingredients properties for now
    // Add more ingredient properties as needed
    
    // Computed property to filter out empty ingredients
    var ingredients: [String] {
        var result: [String] = []
        if let ingredient1 = strIngredient1, !ingredient1.isEmpty {
            result.append(ingredient1)
        }
        if let ingredient2 = strIngredient2, !ingredient2.isEmpty {
            result.append(ingredient2)
        }
        if let ingredient3 = strIngredient3, !ingredient3.isEmpty {
            result.append(ingredient3)
        }
        // Adding more ingredients
        if let ingredient4 = strIngredient4, !ingredient4.isEmpty {
            result.append(ingredient4)
        }
        if let ingredient5 = strIngredient5, !ingredient5.isEmpty {
            result.append(ingredient5)
        }
        if let ingredient6 = strIngredient6, !ingredient6.isEmpty {
            result.append(ingredient6)
        }
        if let ingredient7 = strIngredient7, !ingredient7.isEmpty {
            result.append(ingredient7)
        }
        if let ingredient8 = strIngredient8, !ingredient8.isEmpty {
            result.append(ingredient8)
        }
        if let ingredient9 = strIngredient9, !ingredient9.isEmpty {
            result.append(ingredient9)
        }
        if let ingredient10 = strIngredient10, !ingredient10.isEmpty {
            result.append(ingredient10)
        }
        
        return result
    }
}
// Struct to represent the JSON response for meal details

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}
// View model class to fetch meal details
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    // API URL to lookup a meal by its MEAL_ID
    func fetchMealDetail(mealID: String) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            return
        }
        // Making a data task request to fetch the JSON data
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                // Decoding the JSON response into MealDetailResponse struct
                let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                DispatchQueue.main.async {
                    // Updating the mealDetail property with the first meal from the response
                    self.mealDetail = response.meals.first
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
// a custom view to display an image from a URL

struct URLImageView: View {
    let url: URL

    var body: some View {
        URLImage(url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
// a view to display meal details
//with the properties for retrieving the details of the meal

struct MealDetailView: View {
    @StateObject private var mealDetailViewModel = MealDetailViewModel()
    let meal: Meal
    
    var body: some View {
        VStack {
            if let mealDetail = mealDetailViewModel.mealDetail {
                Text(mealDetail.strMeal)
                    .font(.title)
                    .padding()
                //Text(mealDetail.strMealThumb)
                //    .font(.body)
                
                if let imageURL = URL(string: mealDetail.strMealThumb) {
                    URLImageView(url: imageURL)
                        .frame(width: 200, height: 200)
                } else {
                    Text("Invalid image URL")
                        .foregroundColor(.red)
                }
                // fetching more details using the meal ID
                
                // styling the text for UI
                Spacer()
                Text("• Ingredients:")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Ingredient_Color"))
                    .padding(.top)
                    .underline()
                Spacer()
                // Displaying the ingredients details of the meal
                ForEach(mealDetail.ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                       // aligning the ingredient to the left
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Text("• Instructions:")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Instruction_Color"))
                    .padding(.top)
                    .underline()
                Spacer()
                
                // Displaying the instructions
                Text(mealDetail.strInstructions)
                    .padding(.horizontal)
                    .font(.body)
                    //.padding(.vertical, 8)
                    
                
                
            } else {
                Text("Loading meal details...")
                    .font(.headline)
            }
        }
        .onAppear {
            // Fetching meal details when the view appears
            mealDetailViewModel.fetchMealDetail(mealID: meal.idMeal)
        }
        .navigationTitle("Meal Detail")
    }
}
/// Mark : testing
/*
struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let meal = Meal(idMeal: "1", strMeal: "Cheesecake")
        MealDetailView(meal: meal)
    }
}*/
