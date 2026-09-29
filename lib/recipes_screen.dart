import 'package:flutter/material.dart';
import 'pages/sign_in_profile_screen.dart';
import 'recipe_detail_sheet.dart';

class RecipesScreen extends StatefulWidget {
  final String? initialSearchQuery;
  const RecipesScreen({super.key, this.initialSearchQuery});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String _selectedCategory = 'All';
  late String _searchQuery;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchQuery = widget.initialSearchQuery ?? '';
    _searchController = TextEditingController(text: _searchQuery);
  }

  final Set<String> _bookmarkedTitles = {'Avocado Egg Sourdough Toast'};

  final List<String> _categories = [
    'All',
    'Philippines',
    'Italy',
    'Japan',
    'Mexico',
    'Thailand',
    'India',
    'France',
    'USA',
    'Spain',
    'Greece',
    'Korea',
    'China',
    'Vietnam',
    'Brazil',
    'Argentina',
    'Jamaica',
    'Ethiopia',
    'Lebanon',
    'Morocco',
    'Turkey',
    'Germany',
    'United Kingdom',
    'Sweden',
    'Portugal',
    'Peru',
    'Cuba',
    'Indonesia',
    'South Africa',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
    'Dessert',
  ];

  final List<Map<String, dynamic>> _allRecipes = [
    // --- PHILIPPINES ---
    {
      'title': 'Classic Chicken Adobo',
      'category': 'Lunch',
      'country': 'Philippines',
      'tag': 'NATIONAL DISH',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '30 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1626509807253-2c09228a7e0a?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Chicken thighs & drumsticks', 'Soy sauce & cane vinegar', 'Garlic cloves', 'Bay leaves & whole peppercorns'],
      'instructions': ['Marinate chicken in soy sauce, vinegar, crushed garlic, bay leaves, and peppercorns.', 'Simmer in the marinade until chicken is tender.', 'Pan-fry the chicken until skin is golden brown, then reduce sauce over it.'],
    },
    {
      'title': 'Traditional Pork Sinigang',
      'category': 'Dinner',
      'country': 'Philippines',
      'tag': 'COMFORT FOOD',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '45 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1541529086526-db283c563270?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Pork belly chunks', 'Tamarind soup base (Sinigang mix)', 'Tomatoes & onions', 'Water spinach (kangkong) & radish'],
      'instructions': ['Boil pork belly with tomatoes and onions until tender and flavorful.', 'Stir in tamarind soup base and sliced daikon radish.', 'Add water spinach and long green beans just before serving hot.'],
    },
    {
      'title': 'Filipino Halo-Halo',
      'category': 'Dessert',
      'country': 'Philippines',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '15 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Sweetened bananas & jackfruit', 'Sweet red/white beans', 'Shaved ice & evaporated milk', 'Ube ice cream & leche flan'],
      'instructions': ['Layer assorted sweet fruits, beans, and macapuno strings in a tall glass.', 'Pack generously with finely shaved ice and drizzle with evaporated milk.', 'Top with a scoop of vibrant ube ice cream and a slice of leche flan.'],
    },

    // --- ITALY ---
    {
      'title': 'Neapolitan Margherita Pizza',
      'category': 'Dinner',
      'country': 'Italy',
      'tag': 'CHEF SPECIAL',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '30 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1604382355076-af4b0eb60143?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Pizza dough', 'San Marzano tomatoes', 'Fresh mozzarella', 'Fresh basil', 'Olive oil'],
      'instructions': ['Stretch dough into a round disk.', 'Spread crushed tomatoes and top with torn mozzarella.', 'Bake in a very hot oven until crust is charred and bubbly. Garnish with basil.'],
    },
    {
      'title': 'Classic Roman Carbonara',
      'category': 'Dinner',
      'country': 'Italy',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '20 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1612874742237-6526221588e3?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Spaghetti', 'Guanciale or pancetta', 'Fresh egg yolks', 'Pecorino Romano cheese', 'Black pepper'],
      'instructions': ['Boil spaghetti al dente.', 'Crisp guanciale in a pan.', 'Whisk egg yolks and grated Pecorino. Toss pasta with guanciale and remove from heat, then stir in egg mixture with pasta water for a creamy sauce.'],
    },
    {
      'title': 'Traditional Tiramisu',
      'category': 'Dessert',
      'country': 'Italy',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '30 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Savoiardi ladyfingers', 'Espresso coffee', 'Mascarpone cheese', 'Eggs & sugar', 'Cocoa powder'],
      'instructions': ['Dip ladyfingers briefly in espresso.', 'Layer with whipped mascarpone and egg mixture.', 'Dust generously with cocoa powder and chill for 4 hours before serving.'],
    },

    // --- JAPAN ---
    {
      'title': 'Tonkotsu Shoyu Ramen',
      'category': 'Dinner',
      'country': 'Japan',
      'tag': 'COMFORT FOOD',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '40 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Ramen noodles', 'Pork bone broth', 'Chashu pork slices', 'Soft-boiled ajitsuke tamago egg', 'Nori & green onions'],
      'instructions': ['Simmer rich broth with shoyu tare.', 'Cook noodles until springy.', 'Assemble bowls with broth, noodles, chashu, halved egg, and nori.'],
    },
    {
      'title': 'Chicken Teriyaki Donburi',
      'category': 'Lunch',
      'country': 'Japan',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '20 min',
      'rating': '4.7',
      'imageUrl': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Chicken thighs', 'Soy sauce, mirin, & sake', 'Sugar & ginger', 'Steamed rice & steamed broccoli'],
      'instructions': ['Pan-sear chicken thighs skin-side down.', 'Pour teriyaki sauce ingredients over chicken and simmer until glossy.', 'Serve sliced over a warm bowl of rice.'],
    },
    {
      'title': 'Matcha Mochi Daifuku',
      'category': 'Dessert',
      'country': 'Japan',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '25 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1579372786545-d24232daf58c?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Glutinous rice flour', 'Sugar & water', 'Matcha powder', 'Sweet red bean paste (anko)'],
      'instructions': ['Mix flour, sugar, and water, then steam or microwave until sticky and translucent.', 'Dust with cornstarch, flatten into discs, wrap around anko filling, and dust with matcha.'],
    },

    // --- MEXICO ---
    {
      'title': 'Authentic Carne Asada Tacos',
      'category': 'Dinner',
      'country': 'Mexico',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '25 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Flank or skirt steak', 'Lime juice, garlic, & cilantro', 'Corn tortillas', 'Onions & salsa'],
      'instructions': ['Marinate steak in citrus and garlic juice.', 'Grill over high heat until charred and juicy, then slice thin.', 'Serve on warm corn tortillas with diced onions and cilantro.'],
    },
    {
      'title': 'Homemade Guacamole & Totopos',
      'category': 'Snacks',
      'country': 'Mexico',
      'tag': 'VEGAN',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '10 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1585503418537-88c91d3d637a?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Ripe avocados', 'Limes, cilantro, & jalapeño', 'Diced tomatoes & red onion', 'Tortilla chips'],
      'instructions': ['Mash ripe avocados in a bowl.', 'Fold in freshly squeezed lime juice, chopped cilantro, diced tomatoes, onions, and salt.', 'Serve immediately with crispy corn tortilla chips.'],
    },
    {
      'title': 'Chicken Enchiladas Verdes',
      'category': 'Lunch',
      'country': 'Mexico',
      'tag': 'WEEKNIGHT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '35 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Shredded chicken', 'Salsa verde', 'Tortillas', 'Monterey Jack cheese & crema'],
      'instructions': ['Roll shredded chicken in tortillas.', 'Place in baking dish, cover with salsa verde and cheese.', 'Bake until bubbly and melted.'],
    },

    // --- THAILAND ---
    {
      'title': 'Pad Thai Goong',
      'category': 'Lunch',
      'country': 'Thailand',
      'tag': 'STREET FOOD',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '25 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1559847844-5315695dadae?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Rice noodles', 'Shrimp', 'Tamarind paste & fish sauce', 'Crushed peanuts, eggs, & bean sprouts'],
      'instructions': ['Soak rice noodles until pliable.', 'Stir-fry shrimp, push aside, scramble eggs, and toss in noodles with tamarind sauce.', 'Garnish with crushed peanuts and lime.'],
    },
    {
      'title': 'Authentic Green Curry',
      'category': 'Dinner',
      'country': 'Thailand',
      'tag': 'SPICY',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '30 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Green curry paste', 'Coconut milk', 'Chicken or vegetables', 'Thai basil & bamboo shoots'],
      'instructions': ['Fry green curry paste in coconut cream until fragrant.', 'Add chicken and remaining coconut milk, simmer until tender.', 'Add bamboo shoots and fresh Thai basil leaves.'],
    },
    {
      'title': 'Mango Sticky Rice',
      'category': 'Dessert',
      'country': 'Thailand',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '30 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1541832676-9b763b0239ab?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Glutinous rice', 'Coconut milk & sugar', 'Ripe mangoes', 'Toasted sesame seeds'],
      'instructions': ['Steam glutinous rice until tender.', 'Mix warm rice with sweetened coconut milk sauce.', 'Serve alongside sliced fresh ripe mangoes and sesame seeds.'],
    },

    // --- INDIA ---
    {
      'title': 'Butter Chicken (Murgh Makhani)',
      'category': 'Dinner',
      'country': 'India',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '35 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Marinated chicken pieces', 'Tomato puree & butter', 'Heavy cream & garam masala', 'Fenugreek leaves (kasuri methi)'],
      'instructions': ['Char marinated chicken pieces.', 'Simmer in a velvety spiced tomato and butter sauce with heavy cream.', 'Finish with crushed kasuri methi and cream swirl.'],
    },
    {
      'title': 'Chana Masala',
      'category': 'Lunch',
      'country': 'India',
      'tag': 'VEGAN',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '25 min',
      'rating': '4.7',
      'imageUrl': 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Chickpeas (garbanzo beans)', 'Onions, tomatoes, & ginger-garlic', 'Cumin, coriander, & turmeric', 'Fresh cilantro'],
      'instructions': ['Sauté onions and spices in oil until aromatic.', 'Add tomatoes and chickpeas, simmering until thick and savory.', 'Garnish with fresh cilantro.'],
    },
    {
      'title': 'Refreshing Mango Lassi',
      'category': 'Snacks',
      'country': 'India',
      'tag': 'REFRESHING',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '5 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1527661591475-527312dd65f5?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Ripe mango pulp', 'Plain yogurt', 'A touch of honey & cardamom'],
      'instructions': ['Blend mango pulp, yogurt, honey, and cardamom with ice until smooth.', 'Serve chilled in a tall glass.'],
    },

    // --- FRANCE ---
    {
      'title': 'Beef Bourguignon',
      'category': 'Dinner',
      'country': 'France',
      'tag': 'CHEF SPECIAL',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '60 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1534939561126-855b8675edd7?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Beef chuck cubes', 'Red wine (Burgundy)', 'Bacon lardons & pearl onions', 'Mushrooms & herbs de Provence'],
      'instructions': ['Brown beef and bacon.', 'Slow-braise with red wine, aromatic vegetables, and mushrooms until fork-tender.'],
    },
    {
      'title': 'Classic Croque Monsieur',
      'category': 'Breakfast',
      'country': 'France',
      'tag': 'WEEKNIGHT',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '15 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Sourdough bread', 'Gruyère cheese', 'Ham slices', 'Bechamel sauce'],
      'instructions': ['Layer ham and Gruyère between bread slices.', 'Top with rich bechamel sauce and extra cheese, then bake until golden and bubbly.'],
    },
    {
      'title': 'French Crème Brûlée',
      'category': 'Dessert',
      'country': 'France',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '40 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1470124182917-cc6e71b22ecc?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Heavy cream', 'Egg yolks', 'Vanilla bean', 'Granulated sugar'],
      'instructions': ['Whisk cream, egg yolks, sugar, and vanilla. Bake in ramekins in a water bath.', 'Chill, then torch sugar on top until caramelized into a crisp glass crust.'],
    },

    // --- USA ---
    {
      'title': 'Classic American Cheeseburger',
      'category': 'Lunch',
      'country': 'USA',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '20 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Beef patty', 'Cheddar cheese', 'Brioche bun', 'Lettuce, tomato, & special sauce'],
      'instructions': ['Grill beef patty to perfection and melt cheddar on top.', 'Assemble in a toasted brioche bun with crisp lettuce, tomato, and sauce.'],
    },
    {
      'title': 'Southern Fried Chicken',
      'category': 'Dinner',
      'country': 'USA',
      'tag': 'CRISPY',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '40 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Chicken pieces', 'Buttermilk marinade', 'Seasoned flour', 'Frying oil'],
      'instructions': ['Soak chicken in buttermilk, coat in seasoned flour, and deep-fry until golden brown and crispy.'],
    },
    {
      'title': 'New York Style Cheesecake',
      'category': 'Dessert',
      'country': 'USA',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '50 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Cream cheese', 'Graham cracker crust', 'Sugar, eggs, & sour cream', 'Vanilla extract'],
      'instructions': ['Press graham crust into pan, beat cream cheese filling until ultra-smooth.', 'Bake in water bath until set, chill thoroughly.'],
    },

    // --- SPAIN ---
    {
      'title': 'Authentic Spanish Paella Valenciana',
      'category': 'Dinner',
      'country': 'Spain',
      'tag': 'CHEF SPECIAL',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '45 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1534080564583-6be75777b70a?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Bomba rice', 'Saffron threads & chicken stock', 'Chicken, rabbit, & green beans', 'Paprika & olive oil'],
      'instructions': ['Brown meats in olive oil with vegetables.', 'Add rice, saffron-infused broth, and simmer without stirring to form the crispy socarrat crust.'],
    },
    {
      'title': 'Patatas Bravas with Spicy Tomato Sauce',
      'category': 'Snacks',
      'country': 'Spain',
      'tag': 'TAPAS',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '25 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1585325701166-39f20c9167d4?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Potatoes cubed', 'Spicy tomato bravas sauce', 'Garlic aioli', 'Olive oil'],
      'instructions': ['Deep-fry or roast potato cubes until golden and crispy.', 'Drizzle generously with spicy tomato bravas sauce and garlic aioli.'],
    },
    {
      'title': 'Traditional Spanish Churros with Chocolate',
      'category': 'Dessert',
      'country': 'Spain',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '25 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1624371414361-e675fd93bb8c?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Flour, water, & butter', 'Cinnamon sugar', 'Rich melted dark chocolate for dipping'],
      'instructions': ['Pipe choux pastry dough into hot oil and fry until golden and crispy.', 'Toss in cinnamon sugar and serve with thick warm melted chocolate.'],
    },

    // --- GREECE ---
    {
      'title': 'Classic Greek Moussaka',
      'category': 'Dinner',
      'country': 'Greece',
      'tag': 'BAKED',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '60 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1633383718081-22acfae6c5f2?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Eggplant slices', 'Minced lamb or beef ragout', 'Bechamel sauce', 'Parmesan cheese'],
      'instructions': ['Layer roasted eggplant slices and spiced meat sauce in a baking dish.', 'Top with a thick layer of creamy bechamel and bake until golden brown.'],
    },
    {
      'title': 'Authentic Greek Souvlaki with Tzatziki',
      'category': 'Lunch',
      'country': 'Greece',
      'tag': 'GREEK STREET',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '25 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Pork or chicken skewers', 'Pita bread', 'Tzatziki sauce (yogurt & cucumber)', 'Tomatoes & red onion'],
      'instructions': ['Grill marinated meat skewers until charred.', 'Wrap in warm pita bread with homemade tzatziki sauce, tomatoes, and sliced onions.'],
    },
    {
      'title': 'Traditional Greek Baklava',
      'category': 'Dessert',
      'country': 'Greece',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '50 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1519676867240-f03562e64548?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Filo pastry sheets', 'Chopped walnuts & pistachios', 'Butter', 'Honey and lemon syrup'],
      'instructions': ['Layer crisp buttery filo pastry sheets with spiced chopped nuts.', 'Bake until golden and pour fragrant warm honey-lemon syrup over it.'],
    },

    // --- KOREA ---
    {
      'title': 'Korean Kimchi Jjigae',
      'category': 'Dinner',
      'country': 'Korea',
      'tag': 'SPICY',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '30 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1583225224424-aa17296e57a3?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Aged kimchi', 'Pork belly slices', 'Tofu & scallions', 'Gochujang & garlic'],
      'instructions': ['Sauté pork belly and aged kimchi in sesame oil.', 'Add water, gochujang, and tofu, simmering until rich and deeply flavorful.'],
    },
    {
      'title': 'Crispy Korean Fried Chicken (Yangnyeom)',
      'category': 'Dinner',
      'country': 'Korea',
      'tag': 'CRISPY',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '35 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Chicken wings', 'Potato starch coating', 'Sweet and spicy gochujang glaze', 'Crushed peanuts'],
      'instructions': ['Double-fry chicken wings until shatteringly crispy.', 'Toss immediately in sticky sweet-and-spicy gochujang glaze and garnish with peanuts.'],
    },
    {
      'title': 'Sweet Korean Hotteok Pancakes',
      'category': 'Dessert',
      'country': 'Korea',
      'tag': 'STREET FOOD',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '30 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1541658016709-82535e94bc69?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Yeast dough', 'Brown sugar filling', 'Cinnamon & crushed walnuts'],
      'instructions': ['Stuff yeast dough with brown sugar, cinnamon, and nuts.', 'Press flat and pan-fry on a skillet until gooey and caramelized inside.'],
    },

    // --- CHINA ---
    {
      'title': 'Authentic Sichuan Mapo Tofu',
      'category': 'Dinner',
      'country': 'China',
      'tag': 'SPICY',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '25 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1546069901-d992a01015d9?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Silken tofu cubes', 'Minced pork', 'Sichuan peppercorns & chili bean paste', 'Scallions'],
      'instructions': ['Sauté minced pork with spicy doubanjiang paste and Sichuan peppercorns.', 'Add silken tofu cubes and simmer gently until thickened.'],
    },
    {
      'title': 'Cantonese Shrimp Dumplings (Har Gow)',
      'category': 'Lunch',
      'country': 'China',
      'tag': 'DIM SUM',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '40 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Shrimp filling', 'Translucent wheat starch wrapper', 'Bamboo shoots & sesame oil'],
      'instructions': ['Wrap plump seasoned shrimp filling in delicate translucent dough wrappers.', 'Steam in bamboo baskets until cooked through.'],
    },
    {
      'title': 'Traditional Red Bean Tangyuan',
      'category': 'Dessert',
      'country': 'China',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '20 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Glutinous rice flour balls', 'Sweet red bean paste', 'Ginger soup broth'],
      'instructions': ['Fill soft glutinous rice balls with sweet red bean paste.', 'Boil in water until they float and serve warm in sweet ginger soup.'],
    },

    // --- VIETNAM ---
    {
      'title': 'Authentic Beef Pho (Pho Bo)',
      'category': 'Dinner',
      'country': 'Vietnam',
      'tag': 'SOUP',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '60 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Rice noodles', 'Aromatic beef broth (star anise, cinnamon)', 'Sliced rare beef', 'Fresh herbs & bean sprouts'],
      'instructions': ['Simmer bone broth with charred ginger and aromatic spices for hours.', 'Pour over rice noodles and thinly sliced raw beef.', 'Serve with fresh herbs, lime, and chilies.'],
    },
    {
      'title': 'Vietnamese Crispy Spring Rolls (Nem Ran)',
      'category': 'Snacks',
      'country': 'Vietnam',
      'tag': 'CRISPY',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '30 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1541696432-82c6da8ce7bf?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Rice paper wrappers', 'Minced pork & glass noodles', 'Wood ear mushrooms', 'Nuoc cham dipping sauce'],
      'instructions': ['Roll savory pork and glass noodle filling in rice paper wrappers.', 'Deep-fry until ultra-crispy and golden. Serve with nuoc cham dipping sauce.'],
    },
    {
      'title': 'Vietnamese Iced Coffee (Ca Phe Sua Da)',
      'category': 'Snacks',
      'country': 'Vietnam',
      'tag': 'DRINK',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '5 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Dark roast Vietnamese coffee', 'Sweetened condensed milk', 'Ice cubes'],
      'instructions': ['Brew dark roast coffee through a metal drip filter over sweetened condensed milk.', 'Stir well and pour over a tall glass filled with ice.'],
    },

    // --- BRAZIL ---
    {
      'title': 'Traditional Brazilian Feijoada',
      'category': 'Dinner',
      'country': 'Brazil',
      'tag': 'NATIONAL DISH',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '60 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Black beans', 'Pork and beef cuts', 'Garlic, bay leaves, & orange', 'White rice & farofa'],
      'instructions': ['Slow-cook black beans with rich pork and beef cuts until thick and savory.', 'Serve hot accompanied by white rice, collard greens, and toasted farofa.'],
    },
    {
      'title': 'Brazilian Cheese Bread (Pão de Queijo)',
      'category': 'Snacks',
      'country': 'Brazil',
      'tag': 'GLUTEN FREE',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '20 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1541529086526-db283c563270?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Sour cassava flour (polvilho)', 'Minas cheese or parmesan', 'Milk, eggs, & oil'],
      'instructions': ['Mix cassava flour, grated cheese, milk, and eggs into a dough.', 'Roll into bite-sized balls and bake until puffy, chewy, and golden.'],
    },
    {
      'title': 'Sweet Brigadeiro Truffles',
      'category': 'Dessert',
      'country': 'Brazil',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '15 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1548839140-29a749e1cf4d?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Condensed milk', 'Cocoa powder & butter', 'Chocolate sprinkles'],
      'instructions': ['Cook condensed milk, cocoa powder, and butter in a pan until thick.', 'Cool, roll into small balls, and coat generously in chocolate sprinkles.'],
    },

    // --- ARGENTINA ---
    {
      'title': 'Authentic Argentine Asada Steak with Chimichurri',
      'category': 'Dinner',
      'country': 'Argentina',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '30 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1558030006-450675393462?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Ribeye or skirt steak', 'Fresh parsley, garlic, & oregano', 'Olive oil & red wine vinegar', 'Chili flakes'],
      'instructions': ['Grill steak to juicy perfection over open flame.', 'Blend fresh herb chimichurri with garlic, oil, and vinegar, and spoon generously over steak.'],
    },
    {
      'title': 'Traditional Beef Empanadas',
      'category': 'Lunch',
      'country': 'Argentina',
      'tag': 'BAKED',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '40 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Empanada dough discs', 'Minced beef, onions, & cumin', 'Hard-boiled egg & olives'],
      'instructions': ['Fill pastry discs with savory seasoned beef, onions, egg, and olives.', 'Crimp edges closed and bake or fry until golden brown.'],
    },
    {
      'title': 'Argentine Dulce de Leche Alfajores',
      'category': 'Dessert',
      'country': 'Argentina',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '35 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Cornstarch cookies', 'Dulce de leche filling', 'Desiccated coconut'],
      'instructions': ['Sandwich thick dulce de leche between delicate shortbread cookies.', 'Roll edges in shredded coconut for a classic South American treat.'],
    },

    // --- JAMAICA ---
    {
      'title': 'Jamaican Jerk Chicken',
      'category': 'Dinner',
      'country': 'Jamaica',
      'tag': 'SPICY',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '40 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Chicken pieces', 'Scotch bonnet peppers', 'Allspice, thyme, & green onions', 'Soy sauce & brown sugar'],
      'instructions': ['Marinate chicken in fiery jerk seasoning with scotch bonnets and allspice.', 'Grill or smoke until charred, tender, and smoky.'],
    },
    {
      'title': 'Jamaican Rice and Peas',
      'category': 'Lunch',
      'country': 'Jamaica',
      'tag': 'CARIBBEAN',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '30 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Kidney beans (peas)', 'Long-grain rice', 'Coconut milk', 'Scallion, thyme, & scotch bonnet'],
      'instructions': ['Simmer kidney beans with coconut milk, garlic, thyme, and scallion.', 'Add rice and steam until fluffy and infused with tropical coconut flavor.'],
    },
    {
      'title': 'Jamaican Beef Patties',
      'category': 'Snacks',
      'country': 'Jamaica',
      'tag': 'CRISPY',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '35 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Flaky turmeric pastry crust', 'Spiced ground beef filling', 'Curry powder & scotch bonnet'],
      'instructions': ['Encase flavorful curried minced beef in golden turmeric-tinted pastry dough.', 'Bake until flaky and crisp.'],
    },

    // --- ETHIOPIA ---
    {
      'title': 'Authentic Doro Wat (Ethiopian Chicken Stew)',
      'category': 'Dinner',
      'country': 'Ethiopia',
      'tag': 'SPICY',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '60 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Chicken pieces', 'Berbere spice blend', 'Lots of caramelized red onions', 'Niter kibbeh (spiced butter) & hard-boiled eggs'],
      'instructions': ['Caramelize onions without oil, then simmer slowly with niter kibbeh and pungent berbere spice.', 'Add chicken and hard-boiled eggs until rich and tender.'],
    },
    {
      'title': 'Ethiopian Injera with Misir Wat (Lentil Stew)',
      'category': 'Lunch',
      'country': 'Ethiopia',
      'tag': 'VEGAN',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '30 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Red lentils (misir)', 'Berbere spice & garlic', 'Teff flour injera flatbread'],
      'instructions': ['Simmer red lentils with berbere spices and aromatics into a thick stew.', 'Serve piled high on spongy fermented teff injera bread.'],
    },
    {
      'title': 'Ethiopian Spiced Coffee (Coffee Ceremony Brew)',
      'category': 'Snacks',
      'country': 'Ethiopia',
      'tag': 'DRINK',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '15 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Fresh green coffee beans', 'Cardamom or cloves', 'Jebena clay pot'],
      'instructions': ['Roast green coffee beans fresh over heat, grind, and brew slowly in a clay jebena pot with spices.', 'Serve with a pinch of salt or sugar.'],
    },

    // --- LEBANON ---
    {
      'title': 'Authentic Lebanese Chicken Shawarma',
      'category': 'Lunch',
      'country': 'Lebanon',
      'tag': 'MIDDLE EASTERN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '30 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Marinated chicken strips', 'Garlic toum sauce', 'Arabic flatbread', 'Pickled turnips'],
      'instructions': ['Marinate chicken in yogurt, garlic, lemon, and middle eastern spices.', 'Sear until caramelized and wrap in flatbread with garlicky toum and pickles.'],
    },
    {
      'title': 'Fresh Lebanese Tabbouleh Salad',
      'category': 'Lunch',
      'country': 'Lebanon',
      'tag': 'VEGAN',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '15 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1540420773420-3366772f4999?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Finely chopped parsley', 'Fresh mint & tomatoes', 'Fine bulgur wheat', 'Lemon juice & olive oil'],
      'instructions': ['Toss mountains of finely chopped fresh parsley and mint with tomatoes, onions, and soaked bulgur.', 'Dress brightly with lemon juice and extra virgin olive oil.'],
    },
    {
      'title': 'Lebanese Baklava Rolls',
      'category': 'Dessert',
      'country': 'Lebanon',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '40 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1519676867240-f03562e64548?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Filo dough', 'Cashews or pistachios', 'Orange blossom water syrup'],
      'instructions': ['Roll crushed nuts in flaky filo dough fingers.', 'Bake until golden and soak in fragrant orange blossom and rose water syrup.'],
    },

    // --- MOROCCO ---
    {
      'title': 'Moroccan Lamb Tagine with Apricots',
      'category': 'Dinner',
      'country': 'Morocco',
      'tag': 'CHEF SPECIAL',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '60 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Lamb shoulder chunks', 'Dried apricots & prunes', 'Ras el hanout spice', 'Almonds & honey'],
      'instructions': ['Slow-cook tender lamb with warming spices, dried fruit, and honey until meltingly soft and aromatic.'],
    },
    {
      'title': 'Moroccan Couscous with Roasted Vegetables',
      'category': 'Lunch',
      'country': 'Morocco',
      'tag': 'VEGAN',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '25 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Fluffy couscous', 'Roasted seasonal vegetables', 'Chickpeas & harissa paste'],
      'instructions': ['Fluff steaming couscous and top with spiced roasted vegetables, chickpeas, and a dollop of fiery harissa.'],
    },
    {
      'title': 'Moroccan Mint Tea & Almond Pastries',
      'category': 'Dessert',
      'country': 'Morocco',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '20 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Green tea & fresh spearmint', 'Sugar', 'Almond paste gazelle horns'],
      'instructions': ['Brew sweet Moroccan green tea with generous handfuls of fresh mint.', 'Serve alongside delicate almond-filled pastries.'],
    },

    // --- TURKEY ---
    {
      'title': 'Turkish Adana Kebab',
      'category': 'Dinner',
      'country': 'Turkey',
      'tag': 'GRILLED',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '30 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1558030006-450675393462?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Minced lamb', 'Red bell pepper flakes & sumac', 'Flatbread & grilled peppers'],
      'instructions': ['Hand-mince lamb with red pepper and spices, press onto wide iron skewers, and grill over hot coals.'],
    },
    {
      'title': 'Turkish Menemen',
      'category': 'Breakfast',
      'country': 'Turkey',
      'tag': 'BREAKFAST',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '15 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1525351484163-7529414344d8?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Eggs', 'Tomatoes & green peppers', 'Olive oil & butter', 'Crusty bread'],
      'instructions': ['Sauté diced tomatoes and peppers in butter and oil until soft, then gently scramble eggs right into the skillet.'],
    },
    {
      'title': 'Traditional Turkish Delight (Lokum)',
      'category': 'Dessert',
      'country': 'Turkey',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '40 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Starch & sugar syrup', 'Rosewater & pistachios', 'Powdered sugar coating'],
      'instructions': ['Simmer starch and sugar syrup until chewy and translucent, flavor with rosewater and fold in pistachios. Dust with powdered sugar.'],
    },

    // --- GERMANY ---
    {
      'title': 'German Bratwurst with Sauerkraut',
      'category': 'Dinner',
      'country': 'Germany',
      'tag': 'TRADITIONAL',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '25 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Bratwurst sausages', 'Fermented sauerkraut', 'Bavarian mustard', 'Pretzel roll'],
      'instructions': ['Pan-grill bratwurst sausages until browned and juicy.', 'Serve hot alongside tangy sauerkraut and sharp mustard.'],
    },
    {
      'title': 'Authentic German Soft Pretzels (Brezel)',
      'category': 'Snacks',
      'country': 'Germany',
      'tag': 'BAKED',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '35 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1579888944788-30f552025e46?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Pretzel dough', 'Lye or baking soda bath', 'Coarse salt'],
      'instructions': ['Twist dough into pretzel shapes, dip in a warm baking soda bath for that classic dark crust, sprinkle with coarse salt, and bake.'],
    },
    {
      'title': 'Traditional Black Forest Cake',
      'category': 'Dessert',
      'country': 'Germany',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '55 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Chocolate sponge cake', 'Tart cherries & kirsch', 'Whipped cream & chocolate shavings'],
      'instructions': ['Layer rich chocolate sponge with tart cherries, kirsch liqueur, and billows of fresh whipped cream.'],
    },

    // --- UNITED KINGDOM ---
    {
      'title': 'Classic British Fish and Chips',
      'category': 'Dinner',
      'country': 'United Kingdom',
      'tag': 'PUB CLASSIC',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '30 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1525351484163-7529414344d8?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Cod or haddock fillets', 'Crispy beer batter', 'Thick-cut potato chips', 'Mushy peas & tartar sauce'],
      'instructions': ['Coat fresh fish in light beer batter and fry until golden and crisp.', 'Serve with chunky chips, tartar sauce, and mushy peas.'],
    },
    {
      'title': 'Traditional English Breakfast',
      'category': 'Breakfast',
      'country': 'United Kingdom',
      'tag': 'BREAKFAST',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '20 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1533089860892-a7c6f0a88666?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Bacon & Cumberland sausages', 'Baked beans & fried eggs', 'Grilled tomatoes & toast'],
      'instructions': ['Fry bacon, sausages, eggs, and tomatoes in a skillet, serve alongside warm baked beans and toast.'],
    },
    {
      'title': 'British Sticky Toffee Pudding',
      'category': 'Dessert',
      'country': 'United Kingdom',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '40 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Moist date sponge cake', 'Warm sticky toffee sauce', 'Custard or vanilla ice cream'],
      'instructions': ['Bake moist sponge cake packed with finely chopped dates.', 'Drench generously in rich warm sticky toffee sauce.'],
    },

    // --- SWEDEN ---
    {
      'title': 'Swedish Meatballs with Lingonberry Jam',
      'category': 'Dinner',
      'country': 'Sweden',
      'tag': 'TRADITIONAL',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '30 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Ground beef and pork meatballs', 'Creamy brown gravy', 'Lingonberry jam & mashed potatoes'],
      'instructions': ['Pan-fry tender Swedish meatballs and simmer in rich cream gravy.', 'Serve with creamy mashed potatoes and sweet tart lingonberry jam.'],
    },
    {
      'title': 'Swedish Cinnamon Buns (Kanelbullar)',
      'category': 'Dessert',
      'country': 'Sweden',
      'tag': 'BAKED',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '45 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Cardamom yeast dough', 'Butter, cinnamon, & sugar filling', 'Pearl sugar topping'],
      'instructions': ['Knead cardamom-spiced dough, roll with cinnamon butter, twist into knots, and top with pearl sugar before baking.'],
    },
    {
      'title': 'Smoked Salmon Open-Face Sandwich (Smörgås)',
      'category': 'Breakfast',
      'country': 'Sweden',
      'tag': 'HEALTHY',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '10 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1525351484163-7529414344d8?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Crispbread or rye bread', 'Smoked salmon', 'Cream cheese & fresh dill', 'Cucumber ribbons'],
      'instructions': ['Layer cream cheese, smoked salmon, cucumber ribbons, and fresh dill on rustic crispbread.'],
    },

    // --- PORTUGAL ---
    {
      'title': 'Portuguese Peri-Peri Chicken',
      'category': 'Dinner',
      'country': 'Portugal',
      'tag': 'SPICY',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '35 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Butterflied chicken', 'African bird’s eye chili peri-peri sauce', 'Garlic & lemon'],
      'instructions': ['Marinate chicken in fiery peri-peri chili, garlic, and citrus sauce, then roast or grill until charred.'],
    },
    {
      'title': 'Traditional Pastel de Nata',
      'category': 'Dessert',
      'country': 'Portugal',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '40 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Puff pastry cups', 'Egg custard filling', 'Lemon zest & cinnamon'],
      'instructions': ['Fill crispy laminated pastry shells with rich egg custard, bake at high heat until blistered and caramelized on top.'],
    },
    {
      'title': 'Portuguese Caldo Verde Soup',
      'category': 'Lunch',
      'country': 'Portugal',
      'tag': 'SOUP',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '30 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1547592180-85f173990554?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Potatoes & onions', 'Chorizo sausage slices', 'Shredded collard greens (couve galega)'],
      'instructions': ['Purée potatoes and onions into a smooth broth, add sliced chorizo and ribbons of tender collard greens.'],
    },

    // --- PERU ---
    {
      'title': 'Authentic Peruvian Ceviche',
      'category': 'Lunch',
      'country': 'Peru',
      'tag': 'FRESH',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '20 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1535400255456-984241433b21?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Fresh raw fish cubes', 'Fresh lime juice (leche de tigre)', 'Red onion & ají limo chili', 'Boiled sweet potato & corn'],
      'instructions': ['Cure fresh raw fish in tart lime juice with onions and spicy ají limo.', 'Serve cold with sweet potato and Andean corn.'],
    },
    {
      'title': 'Peruvian Lomo Saltado',
      'category': 'Dinner',
      'country': 'Peru',
      'tag': 'STIR FRY',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '25 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Beef tenderloin strips', 'Red onions & tomatoes', 'Soy sauce & vinegar (wok stir-fry)', 'French fries'],
      'instructions': ['High-heat wok stir-fry beef strips with onions, tomatoes, soy sauce, and vinegar.', 'Toss with crispy french fries and serve over rice.'],
    },
    {
      'title': 'Traditional Alfajores Peruanos',
      'category': 'Dessert',
      'country': 'Peru',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '30 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Buttery cornstarch cookies', 'Manjar blanco (dulce de leche)', 'Powdered sugar'],
      'instructions': ['Sandwich rich manjar blanco between melt-in-your-mouth shortbread cookies, dust with powdered sugar.'],
    },

    // --- CUBA ---
    {
      'title': 'Cuban Sandwich (Cubano)',
      'category': 'Lunch',
      'country': 'Cuba',
      'tag': 'SANDWICH',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '15 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Cuban bread', 'Roast pork & ham', 'Swiss cheese, pickles, & yellow mustard'],
      'instructions': ['Layer roast pork, ham, Swiss cheese, and pickles between Cuban bread.', 'Press in a hot sandwich press until crispy and melted.'],
    },
    {
      'title': 'Traditional Cuban Ropa Vieja',
      'category': 'Dinner',
      'country': 'Cuba',
      'tag': 'COMFORT FOOD',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '50 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Shredded flank steak', 'Tomatoes, bell peppers, & onions', 'Garlic, cumin, & olives'],
      'instructions': ['Slow-simmer shredded beef in a savory spiced tomato, bell pepper, and onion sauce until tender.'],
    },
    {
      'title': 'Cuban Flan de Caramel',
      'category': 'Dessert',
      'country': 'Cuba',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '40 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1470124182917-cc6e71b22ecc?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Condensed and evaporated milk', 'Eggs & vanilla', 'Caramel syrup'],
      'instructions': ['Bake silky custard made from condensed milk and eggs in a caramel-coated mold, chill and invert to serve.'],
    },

    // --- INDONESIA ---
    {
      'title': 'Authentic Indonesian Nasi Goreng',
      'category': 'Dinner',
      'country': 'Indonesia',
      'tag': 'STREET FOOD',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '20 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1512058564366-18510be2db19?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Cold cooked rice', 'Sweet soy sauce (kecap manis)', 'Shrimp paste (trasi)', 'Fried egg & shallots'],
      'instructions': ['Stir-fry rice with sweet soy sauce, garlic, and shrimp paste.', 'Top with a sunny-side-up fried egg and crispy shallots.'],
    },
    {
      'title': 'Indonesian Chicken Satay with Peanut Sauce',
      'category': 'Lunch',
      'country': 'Indonesia',
      'tag': 'GRILLED',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '25 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Chicken skewers', 'Rich spiced peanut sauce', 'Soy sauce & lime marinade'],
      'instructions': ['Grill marinated chicken skewers over charcoal until smoky.', 'Serve drenched in creamy, savory peanut sauce.'],
    },
    {
      'title': 'Indonesian Klepon',
      'category': 'Dessert',
      'country': 'Indonesia',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '25 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Pandan-infused rice flour dough', 'Liquid palm sugar (gula melaka) core', 'Grated coconut coating'],
      'instructions': ['Boil pandan rice balls filled with molten palm sugar until they float.', 'Roll immediately in freshly grated coconut.'],
    },

    // --- SOUTH AFRICA ---
    {
      'title': 'South African Bobotie',
      'category': 'Dinner',
      'country': 'South Africa',
      'tag': 'NATIONAL DISH',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '45 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Spiced minced beef', 'Dried apricots & chutney', 'Egg and milk custard topping', 'Bay leaves'],
      'instructions': ['Bake spiced minced beef infused with curry, dried fruit, and chutney, topped with a savory egg custard crust.'],
    },
    {
      'title': 'Traditional South African Chakalaka',
      'category': 'Lunch',
      'country': 'South Africa',
      'tag': 'VEGAN',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '20 min',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Spiced vegetables & beans', 'Tomatoes, onions, & carrots', 'Curry powder & peppers'],
      'instructions': ['Sauté onions, peppers, carrots, and baked beans with aromatic curry spices into a tangy, spicy relish.'],
    },
    {
      'title': 'South African Melktert (Milk Tart)',
      'category': 'Dessert',
      'country': 'South Africa',
      'tag': 'SWEET TREAT',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '40 min',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1470124182917-cc6e71b22ecc?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Sweet pastry crust', 'Milky vanilla custard filling', 'Cinnamon dusting'],
      'instructions': ['Pour velvety vanilla milk custard into a baked pastry crust, dust generously with cinnamon.'],
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredRecipes {
    return _allRecipes.where((r) {
      final matchesCategory = _selectedCategory == 'All' ||
          r['category'] == _selectedCategory ||
          r['country'] == _selectedCategory;

      if (_searchQuery.isEmpty) {
        return matchesCategory;
      }

      final searchTerms = _searchQuery
          .toLowerCase()
          .split(RegExp(r'[,\\s]+'))
          .where((term) => term.isNotEmpty)
          .toList();

      if (searchTerms.isEmpty) {
        return matchesCategory;
      }

      final title = r['title'].toString().toLowerCase();
      final country = r['country'].toString().toLowerCase();
      final ingredients = (r['ingredients'] as List)
          .map((i) => i.toString().toLowerCase())
          .toList();

      final matchesSearch = searchTerms.any((term) =>
          title.contains(term) ||
          country.contains(term) ||
          ingredients.any((ing) => ing.contains(term)));

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final recipesToShow = _filteredRecipes;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF0D3E26),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search by category & diet',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Browse Recipes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInProfileScreen(),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white24,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search breakfast, snacks, baking...',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.35),
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Categories Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Categories Chips
              SizedBox(
                height: 38,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = category == _selectedCategory;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0D3E26)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF0D3E26)
                                : Colors.black.withOpacity(0.1),
                          ),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.black.withOpacity(0.7),
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  '$_selectedCategory Recipes',
                  style: const TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Recipes Container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: recipesToShow.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(
                            child: Text(
                              'No recipes found matching your search.',
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                        )
                      : Column(
                          children: List.generate(recipesToShow.length, (index) {
                            final r = recipesToShow[index];
                            final title = r['title'] as String;
                            final isBookmarked =
                                _bookmarkedTitles.contains(title);

                            return Column(
                              children: [
                                if (index > 0)
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Divider(color: Color(0xFFF0F0F0)),
                                  ),
                                _buildRecipeItem(
                                  recipeData: r,
                                  isBookmarked: isBookmarked,
                                  onBookmarkTap: () {
                                    setState(() {
                                      if (isBookmarked) {
                                        _bookmarkedTitles.remove(title);
                                      } else {
                                        _bookmarkedTitles.add(title);
                                      }
                                    });
                                  },
                                ),
                              ],
                            );
                          }),
                        ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeItem({
    required Map<String, dynamic> recipeData,
    required bool isBookmarked,
    required VoidCallback onBookmarkTap,
  }) {
    final recipe = Recipe(
      title: recipeData['title'],
      tag: recipeData['tag'],
      tagColor: recipeData['tagColor'],
      textColor: recipeData['textColor'],
      time: recipeData['time'],
      rating: recipeData['rating'],
      imageUrl: recipeData['imageUrl'],
      ingredients: List<String>.from(recipeData['ingredients']),
      instructions: List<String>.from(recipeData['instructions']),
    );

    return InkWell(
      onTap: () {
        showRecipeDetailSheet(context, recipe);
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                recipe.imageUrl,
                width: 76,
                height: 76,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 76,
                  height: 76,
                  color: const Color(0xFFE2F0D9),
                  child: const Center(
                    child: Icon(Icons.restaurant, size: 28, color: Color(0xFF0D3E26)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: recipe.tagColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      recipe.tag,
                      style: TextStyle(
                        color: recipe.textColor,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 13,
                        color: Colors.black38,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${recipe.time}  ·  ${recipe.rating} ★',
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onBookmarkTap,
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked ? const Color(0xFFE05A47) : Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
