import 'package:flutter/material.dart';
import 'recipes_screen.dart';
import 'favorites_screen.dart';
import 'premium_screen.dart';
import 'sign_in_profile_screen.dart';
import 'recipe_detail_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _ingredientsController = TextEditingController();
  final Set<String> _bookmarkedTitles = {};

  final List<Map<String, dynamic>> _popularItems = [
    {
      'title': 'Lemony herb pasta',
      'tag': 'WEEKNIGHT',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '20 min',
      'rating': '4.9',
      'imageUrl':
          'https://images.unsplash.com/photo-1645112411341-6c4fd023714a?q=80&w=200&auto=format&fit=crop',
      'ingredients': [
        '200g spaghetti pasta',
        'Fresh lemon juice & zest',
        'Extra virgin olive oil',
        'Fresh basil & parmesan'
      ],
      'instructions': [
        'Boil pasta until al dente.',
        'Toss with olive oil, lemon zest, juice, and fresh herbs.',
        'Garnish with grated parmesan.'
      ],
    },
    {
      'title': 'Crispy chilli salmon',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '25 min',
      'rating': '4.7',
      'imageUrl':
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?q=80&w=200&auto=format&fit=crop',
      'ingredients': [
        '2 salmon fillets',
        'Chili oil & soy sauce',
        'Steamed jasmine rice'
      ],
      'instructions': [
        'Sear salmon skin-side down until crispy.',
        'Glaze with chili oil sauce.',
        'Serve hot over steamed jasmine rice.'
      ],
    },
  ];

  final Map<String, dynamic> _editorsPick = {
    'title': 'Harissa roast bowl',
    'tag': "EDITOR'S PICK",
    'tagColor': const Color(0xFFE05A47),
    'textColor': Colors.white,
    'time': '25 min',
    'rating': '4.9',
    'imageUrl':
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=600&auto=format&fit=crop',
    'ingredients': [
      '1 cup quinoa',
      '2 tbsp harissa paste',
      'Roasted chickpeas & sweet potato',
      'Tahini dressing & fresh parsley'
    ],
    'instructions': [
      'Roast chickpeas and sweet potato cubes with harissa paste at 200°C for 20 mins.',
      'Cook quinoa according to package instructions.',
      'Assemble bowl with quinoa, veggies, and drizzle tahini dressing.'
    ],
  };

  @override
  void dispose() {
    _ingredientsController.dispose();
    super.dispose();
  }

  void _searchIngredients() {
    final query = _ingredientsController.text.trim();
    if (query.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Finding recipes matching: "$query"...'),
          duration: const Duration(seconds: 2),
        ),
      );
      setState(() {
        _currentIndex = 1; // Switch to Recipes tab
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter ingredients to search!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildPantryPage(),
      const RecipesScreen(),
      const FavoritesScreen(),
      const PremiumScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF0D3E26),
          unselectedItemColor: Colors.black38,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store_outlined),
              activeIcon: Icon(Icons.local_grocery_store),
              label: 'Pantry',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              activeIcon: Icon(Icons.bookmark),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_membership_outlined),
              activeIcon: Icon(Icons.card_membership),
              label: 'Premium',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPantryPage() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Color(0xFF0D3E26), // Dark green background
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
                        'Goodmorning Maria',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'What are you looking for?',
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

            const SizedBox(height: 24),

            // Ingredient Search Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What ingredients do you have in\nyour kitchen?',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _ingredientsController,
                      onSubmitted: (_) => _searchIngredients(),
                      decoration: InputDecoration(
                        hintText: 'e.g. Chicken, Beef, Garlic, Pepper...',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.35),
                          fontSize: 15,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFFAF6F0),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: _searchIngredients,
                        icon: const Icon(Icons.search, color: Colors.white),
                        label: const Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFB81C),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Discover Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Discover',
                style: TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Discover Banner Card (Harissa roast bowl)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  final recipe = Recipe(
                    title: _editorsPick['title'],
                    tag: _editorsPick['tag'],
                    tagColor: _editorsPick['tagColor'],
                    textColor: _editorsPick['textColor'],
                    time: _editorsPick['time'],
                    rating: _editorsPick['rating'],
                    imageUrl: _editorsPick['imageUrl'],
                    ingredients:
                        List<String>.from(_editorsPick['ingredients']),
                    instructions:
                        List<String>.from(_editorsPick['instructions']),
                  );
                  showRecipeDetailSheet(context, recipe);
                },
                child: Container(
                  width: double.infinity,
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: NetworkImage(_editorsPick['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Editor's Pick Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE05A47),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "EDITOR'S PICK",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        // Title & Metadata
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _editorsPick['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _editorsPick['time'],
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Easy • ${_editorsPick['rating']} ★',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Popular this Week Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Popular this Week',
                style: TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Popular List Card Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: List.generate(_popularItems.length, (index) {
                    final item = _popularItems[index];
                    final title = item['title'] as String;
                    final isBookmarked = _bookmarkedTitles.contains(title);

                    return Column(
                      children: [
                        if (index > 0)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(color: Color(0xFFF0F0F0)),
                          ),
                        _buildPopularItem(
                          itemData: item,
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
    );
  }

  Widget _buildPopularItem({
    required Map<String, dynamic> itemData,
    required bool isBookmarked,
    required VoidCallback onBookmarkTap,
  }) {
    final recipe = Recipe(
      title: itemData['title'],
      tag: itemData['tag'],
      tagColor: itemData['tagColor'],
      textColor: itemData['textColor'],
      time: itemData['time'],
      rating: itemData['rating'],
      imageUrl: itemData['imageUrl'],
      ingredients: List<String>.from(itemData['ingredients']),
      instructions: List<String>.from(itemData['instructions']),
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
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: recipe.tagColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      recipe.tag,
                      style: TextStyle(
                        color: recipe.textColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.black38,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        recipe.time,
                        style: const TextStyle(
                          color: Colors.black38,
                          fontSize: 13,
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
