//
//  MealAppTesting.swift
//  MealAppTesting
//
//  Created by Rolande umuhoza on 6/17/23.
//

import XCTest
@testable import MealApp

final class MealAppTesting: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchMeals() {
        // Given
        let mealViewModel = MealViewModel()

        // When
        mealViewModel.fetchMeals()

        // Then
        XCTAssertFalse(mealViewModel.meals.isEmpty, "Meals array should not be empty")
    }

    
    func testFetchMealDetail() throws {
        let mealDetailViewModel = MealDetailViewModel()
        
        // Call the fetchMealDetail(mealID:) method to fetch meal detail for a specific meal ID
        mealDetailViewModel.fetchMealDetail(mealID: "52877")
        
        // Assert that the mealDetail property is not nil after fetching
        XCTAssertNotNil(mealDetailViewModel.mealDetail, "Meal detail should not be nil")
    }
    func testEmptyIngredients() throws {
        // Given
        let mealDetail = MealDetail(strMeal: "Dundee cheesecake", strMealThumb: "wxyvqq1511723401.jpg", strInstructions: "", strIngredient1: nil, strIngredient2: "Milk", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "")

        // When
        let ingredients = mealDetail.ingredients

        // Then
        XCTAssertTrue(ingredients.isEmpty, "Ingredients should be empty")
    }


    
}
