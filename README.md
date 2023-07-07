# MealsDB-App

## MealsDB App

This is an app used to track desserts listed on MealsDB. When you open the app, you should see a list of desserts. When you tap on a dessert, a detail screen should opne up, displaying the dessert's picture, the name of the dessert, the country of originm the ingradients for the dessert (with quantities), and steps to prepare the food (with a checkbox to check off steps you have completed). 

## Developing the app

To develop the app, I used the native URLSession class to download the JSON file, and I parsed the JSON file using Codable by conforming to the Decodable protocol. I then defined by own custom keys by creating an enum that conformed to CodingKeys. To Get the instructions for each food, I defined a struct that conformed to CodingKeys so I could create CodingKeys to retreieve each step and ingedient. If the CodingKey value was present in the json file, I retreieved the ingriedient and measurement and concatenated the two values together 
