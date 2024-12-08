import 'package:events_jo/config/enums/food_type.dart';
import 'package:string_similarity/string_similarity.dart';

class ImageForString {
  //get the best matching string
  static String get(String input, FoodType type) {
    final normalizedInput = input.toLowerCase();

    Map<String, String> map = {};

    //get meals map
    if (type == FoodType.meal) {
      map = stringToImageMealsMap;
    }
    //get drinks map
    if (type == FoodType.drink) {
      map = stringToImageDrinksMap;
    }

    //exact match
    if (map.containsKey(normalizedInput)) {
      return map[normalizedInput]!;
    }

    //fuzzy matching, use 'findBestMatch'
    final keys = map.keys.toList();
    final bestMatch = StringSimilarity.findBestMatch(normalizedInput, keys);

    //get the best match with its rating
    final bestMatchKey = bestMatch.bestMatch.target;
    final bestMatchRating = bestMatch.bestMatch.rating;

    //fallback
    if (bestMatchRating == null) {
      if (type == FoodType.meal) {
        return 'https://i.ibb.co/7NcDCwN/meal-placeholder.png';
      } else {
        return 'https://i.ibb.co/HPXw3h2/wine-glass-empty.png';
      }
    }

    //return the matched image if the rating is above a threshold
    if (bestMatchRating > 0.3) {
      return map[bestMatchKey]!;
    }

    //fallback
    if (type == FoodType.meal) {
      return 'https://i.ibb.co/7NcDCwN/meal-placeholder.png';
    } else {
      return 'https://i.ibb.co/HPXw3h2/wine-glass-empty.png';
    }
  }

  //map for meals
  static final Map<String, String> stringToImageMealsMap = {
    //bread display
    "freash arabic bread": 'https://i.ibb.co/CmXZ6Tk/fresh-arabic-bread.jpg',
    "olive bread": 'https://i.ibb.co/XSTJcvb/olive-bread.jpg',
    "walnut bread": 'https://i.ibb.co/qRvFKsQ/walnut-bread.jpg',
    "baguette bread": 'https://i.ibb.co/xXCPCxh/baguette-bread.jpg',
    "assorted bread rolls": 'https://i.ibb.co/BjLWHnR/assorted-bread-rolls.jpg',
    "grissini sticks": 'https://i.ibb.co/0J0wgQQ/grissini-sticks.jpg',

    //appetizers
    "hummus": 'https://i.ibb.co/GMgTbLx/hummus.jpg',
    "muhammara": 'https://i.ibb.co/vDFWg9p/muhammara.jpg',
    "moutabal": 'https://i.ibb.co/f24DxNm/moutabal.png',
    "baba gannoush": 'https://i.ibb.co/7vDSvYB/baba-gannoush.png',
    "kishkeh": 'https://i.ibb.co/jDyqQvk/kishkeh.png',
    "yalanji": 'https://i.ibb.co/T13JNbP/yalanji.jpg',
    "grilled vegetable platter":
        'https://i.ibb.co/Qfr7ZVT/grilled-vegetable-platter.png',
    "sambousek": 'https://i.ibb.co/DwBqNnT/sambousek.jpg',
    "kubbeh": 'https://i.ibb.co/f9BHxCH/kubbeh.jpg',
    "falafel": 'https://i.ibb.co/dKr7DzW/falafel.jpg',
    "tahini sauce": 'https://i.ibb.co/GcW6GGy/tahni-sauce.png',
    "shatta sauce": 'https://i.ibb.co/Wzsfq7D/shatta-sauce.png',
    "tomato sauce": 'https://i.ibb.co/7gJkCBw/tomato-sauce.jpg',
    "sumac": 'https://i.ibb.co/njGmtBH/sumac.png',

    //salads
    "fattoush salad": 'https://i.ibb.co/5ctP4tK/fattoush-salad.jpg',
    "taboulleh salad": 'https://i.ibb.co/JBQTt8g/taboulleh-salad.jpg',
    "coleslaw salad": 'https://i.ibb.co/XWS7mBm/coleslaw-salad.png',
    "greek salad": 'https://i.ibb.co/T0VJvKK/greek-salad.jpg',
    "rocca salad parmesan": 'https://i.ibb.co/cYpj6DF/rocca-salad-parmesan.jpg',
    "thai beef salad": 'https://i.ibb.co/wNRdD6y/thai-beef-salad.jpg',
    "palmetto salad": 'https://i.ibb.co/5TsnXfm/palmetto-salad.png',
    "assorted olives": 'https://i.ibb.co/Xyc8yL7/assorted-olives.jpg',
    "assorted pickles": 'https://i.ibb.co/WkR3DHq/assorted-pickles.png',

    //main
    "shawarma": 'https://i.ibb.co/s5xjf2f/shawarma.jpg',
    "roasted lamb": 'https://i.ibb.co/s9c65ng/roasted-lamb.png',
    "roasted potato": 'https://i.ibb.co/mDRS107/roasted-potato.png',
    "kebab": 'https://i.ibb.co/MpHt9Wk/kebab.jpg',
    "penne arrabbiata": 'https://i.ibb.co/Vg5Wv1V/penne-arrabbiata.jpg',
    "fettuccine alfredo": 'https://i.ibb.co/x6BnvV1/fettuccine-alfredo.jpg',

    //deserts
    //todo add cakes
    "apple crumble pie": 'https://i.ibb.co/nwJfyFJ/apple-crumble-pie.jpg',
    "chocolate gateau": 'https://i.ibb.co/R3cJwYs/chocolate-gateau.jpg',
    "fruit salad": 'https://i.ibb.co/D4gVSKN/fruit-salad.jpg',
    "creme caramel": 'https://i.ibb.co/NmKHh1c/creme-caramel.png',
    "tiramisu": 'https://i.ibb.co/tht2yqn/tiramisu.jpg',
    "chocolate mousse": 'https://i.ibb.co/3FV87mB/chocolate-mousse.png',
    "strawberry mousse": 'https://i.ibb.co/K7YmbXz/strawberry-mousse.jpg',
    "eclairs": 'https://i.ibb.co/s1W7Vbm/eclairs.jpg',
    "brownies": 'https://i.ibb.co/R0HpJ5K/brownies.jpg',
    "knafeh": 'https://i.ibb.co/PttTp1h/knafeh.jpg',
  };

  //map for drinks
  static final Map<String, String> stringToImageDrinksMap = {
    "water": 'https://i.ibb.co/3dbcH9J/water.jpg',
    "juice": 'https://i.ibb.co/xDTcCjW/juice.png',
    "coffee": 'https://i.ibb.co/1G64rTh/coffee.jpg',
    "tea": 'https://i.ibb.co/ySZss9C/tea.png',
    "soda": 'https://i.ibb.co/tbs4MDN/soda.jpg',
    "smoothie": 'https://i.ibb.co/2k2bbgW/smoothie.jpg',
    "hot chocolate": 'https://i.ibb.co/fvfyc49/hot-chocolate.png',
    "sahlab": 'https://i.ibb.co/LS6BFdw/sahlab.jpg',
    "qamar al din": 'https://i.ibb.co/0t35vcq/qamar-al-din.jpg',
    "mint lemonade": 'https://i.ibb.co/g3bCbk4/mint-lemonade.webp',
    "mojito": 'https://i.ibb.co/9TnqymL/mojito.jpg',
    "capuccino": 'https://i.ibb.co/wzdcPph/capuccino.jpg',
    "espresso": 'https://i.ibb.co/JKJz614/espresso.jpg',
  };
}
