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
      "mansaf": Icons.food_bank, // Mansaf (National Dish of Jordan)
      "maqluba": Icons.lunch_dining, // Maqluba
      "musakhan": Icons.flatware, // Musakhan (placeholder)
      "kebab": Icons.kebab_dining, // Kebab
      "kofta": Icons.fastfood, // Kofta (placeholder)
      "warak enab": Icons.food_bank, // Stuffed Grape Leaves

      // Side Dishes
      "rice": Icons.rice_bowl,
      "potatoes": Icons.breakfast_dining,
      "mashed potatoes": Icons.lunch_dining,
      "pasta": Icons.dining,
      "salad": Icons.eco,
      "vegetables": Icons.spa,
      "hummus": Icons.bubble_chart,
      "mutabbal": Icons.fastfood, // Mutabbal (placeholder)
      "fattoush": Icons.eco, // Fattoush (Salad)
      "tabbouleh": Icons.spa, // Tabbouleh (Salad)
      "falafel": Icons.donut_small, // Falafel

      // Appetizers
      "soup": Icons.ramen_dining,
      "spring rolls": Icons.fastfood,
      "stuffed grape leaves": Icons.food_bank,

      // Breads
      "bread": Icons.bakery_dining,
      "naan": Icons.flatware,
      "pita": Icons.donut_small,
      "shrak": Icons.flatware, // Shrak (Thin Bread) (placeholder)
      "manakish": Icons.local_pizza, // Manakish (Thyme Bread)

      // Desserts
      "cake": Icons.cake,
      "cupcake": Icons.emoji_food_beverage,
      "baklava": Icons.grain,
      "ice cream": Icons.icecream,
      "fruit salad": Icons.local_florist,
      "kunafa": Icons.cake, // Kunafa
      "maamoul": Icons.bakery_dining, // Maamoul (Stuffed Pastry)
      "awameh": Icons.donut_small, // Awameh (Fried Dough Balls)
      "atayef": Icons.donut_large, // Atayef
      "halva": Icons.emoji_food_beverage, // Halva (placeholder)
      "znoud el sit": Icons.local_dining, // Znoud el Sit (placeholder)

      // Miscellaneous
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
      "sahlab": Icons.ramen_dining, // Sahlab (Warm Milk Pudding Drink)
      "jallab": Icons.bubble_chart, // Jallab (Grape Syrup Drink)
      "qamar al-din": Icons.local_bar, // Qamar Al-Din (Apricot Juice)
      "tamarind": Icons.spa, // Tamarind Juice (Placeholder)
      "mint lemonade": Icons.local_drink, // Mint Lemonade
      "rose water": Icons.local_florist, // Rose Water (Placeholder)
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
