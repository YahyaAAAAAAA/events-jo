import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

class IconForString {
  // Function to get the best matching icon
  static IconData? get(String input) {
    // Define a map of keywords to icons
    final Map<String, IconData> stringToIconMap = {
      // Main Dishes
      "steak": Icons.restaurant,
      "chicken": Icons.food_bank,
      "fish": Icons.set_meal,
      "lamb": Icons.dinner_dining,
      "turkey": Icons.local_dining,
      "cookie": Icons.cookie,

      // Side Dishes
      "rice": Icons.rice_bowl,
      "potatoes": Icons.breakfast_dining,
      "mashed potatoes": Icons.lunch_dining,
      "pasta": Icons.dining,
      "salad": Icons.eco,
      "vegetables": Icons.spa,

      // Appetizers
      "soup": Icons.ramen_dining,
      "spring rolls": Icons.fastfood,
      "hummus": Icons.bubble_chart,
      "stuffed grape leaves": Icons.food_bank,

      // Breads
      "bread": Icons.bakery_dining,
      "naan": Icons.flatware,
      "pita": Icons.donut_small,

      // Desserts
      "cake": Icons.cake,
      "cupcake": Icons.emoji_food_beverage,
      "baklava": Icons.grain,
      "ice cream": Icons.icecream,
      "fruit salad": Icons.local_florist,

      // Miscellaneous
      "kebab": Icons.kebab_dining,
      "meatballs": Icons.fastfood,
      "lasagna": Icons.dining,
      "pizza": Icons.local_pizza,

      // Drinks
      "water": Icons.water_drop, // Water
      "juice": Icons.local_bar, // Juice (placeholder)
      "coffee": Icons.local_cafe, // Coffee
      "tea": Icons.emoji_food_beverage, // Tea
      "soda": Icons.bubble_chart, // Soda (placeholder)
      "smoothie": Icons.blender, // Smoothie (placeholder)
      "hot chocolate": Icons.coffee_maker, // Hot Chocolate (placeholder)
    };

    final normalizedInput = input.toLowerCase();

    // If there's an exact match, return it
    if (stringToIconMap.containsKey(normalizedInput)) {
      return stringToIconMap[normalizedInput]!;
    }

    // Fuzzy matching: Use `findBestMatch`
    final keys = stringToIconMap.keys.toList();
    final bestMatch = StringSimilarity.findBestMatch(normalizedInput, keys);

    // Get the best match with its rating
    final bestMatchKey = bestMatch.bestMatch.target;
    final bestMatchRating = bestMatch.bestMatch.rating;

    // Fallback to a default icon if null
    if (bestMatchRating == null) {
      return null;
    }

    // Return the matched icon if the rating is above a threshold
    if (bestMatchRating > 0.3) {
      // Adjust the threshold as needed
      return stringToIconMap[bestMatchKey]!;
    }

    // Fallback to a default icon if no good match is found
    return null;
  }
}
