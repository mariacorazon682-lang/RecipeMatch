import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Auth.dart';
import '../widget_tree.dart';
import '../recipes_screen.dart';
import '../favorites_screen.dart';
import '../premium_screen.dart';
import 'sign_in_profile_screen.dart';
import '../recipe_detail_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _ingredientsController = TextEditingController();
  final Set<String> _bookmarkedTitles = {};
  String _searchQuery = '';
  final List<String> _availableIngredients = [];
  bool _isCommonPantryExpanded = false;
  String _selectedPantryCategory = 'All';

  final List<Map<String, String>> _pantryItems = [
    {'name': 'Pork', 'tagalog': 'Baboy', 'emoji': '🥩', 'category': 'Meat & Seafood'},
    {'name': 'Chicken', 'tagalog': 'Manok', 'emoji': '🍗', 'category': 'Meat & Seafood'},
    {'name': 'Beef', 'tagalog': 'Baka', 'emoji': '🥩', 'category': 'Meat & Seafood'},
    {'name': 'Fish', 'tagalog': 'Bangus', 'emoji': '🐟', 'category': 'Meat & Seafood'},
    {'name': 'Ground Pork', 'tagalog': 'Giniling', 'emoji': '🥩', 'category': 'Meat & Seafood'},
    {'name': 'Egg', 'tagalog': 'Itlog', 'emoji': '🥚', 'category': 'Meat & Seafood'},
    {'name': 'Hotdog', 'tagalog': 'Red Hotdog', 'emoji': '🌭', 'category': 'Meat & Seafood'},
    {'name': 'Tofu', 'tagalog': 'Tokwa', 'emoji': '🧈', 'category': 'Meat & Seafood'},
    {'name': 'Garlic', 'tagalog': 'Bawang', 'emoji': '🧄', 'category': 'Vegetables & Aromatics'},
    {'name': 'Onion', 'tagalog': 'Sibuyas', 'emoji': '🧅', 'category': 'Vegetables & Aromatics'},
    {'name': 'Tomato', 'tagalog': 'Kamatis', 'emoji': '🍅', 'category': 'Vegetables & Aromatics'},
    {'name': 'Ginger', 'tagalog': 'Luya', 'emoji': '🫚', 'category': 'Vegetables & Aromatics'},
    {'name': 'Eggplant', 'tagalog': 'Talong', 'emoji': '🍆', 'category': 'Vegetables & Aromatics'},
    {'name': 'Kangkong', 'tagalog': 'Water Spinach', 'emoji': '🥬', 'category': 'Vegetables & Aromatics'},
    {'name': 'String Beans', 'tagalog': 'Sitaw', 'emoji': '🫛', 'category': 'Vegetables & Aromatics'},
    {'name': 'Squash', 'tagalog': 'Kalabasa', 'emoji': '🎃', 'category': 'Vegetables & Aromatics'},
    {'name': 'Chayote', 'tagalog': 'Sayote', 'emoji': '🍐', 'category': 'Vegetables & Aromatics'},
    {'name': 'Cabbage', 'tagalog': 'Repolyo', 'emoji': '🥬', 'category': 'Vegetables & Aromatics'},
    {'name': 'Potato', 'tagalog': 'Patatas', 'emoji': '🥔', 'category': 'Vegetables & Aromatics'},
    {'name': 'Carrot', 'tagalog': 'Karot', 'emoji': '🥕', 'category': 'Vegetables & Aromatics'},
    {'name': 'Green Chili', 'tagalog': 'Siling Haba', 'emoji': '🌶', 'category': 'Vegetables & Aromatics'},
    {'name': 'Malunggay', 'tagalog': 'Moringa', 'emoji': '🍃', 'category': 'Vegetables & Aromatics'},
    {'name': 'Soy Sauce', 'tagalog': 'Toyo', 'emoji': '🏺', 'category': 'Sauces & Mixes'},
    {'name': 'Vinegar', 'tagalog': 'Suka', 'emoji': '🧪', 'category': 'Sauces & Mixes'},
    {'name': 'Fish Sauce', 'tagalog': 'Patis', 'emoji': '🐟', 'category': 'Sauces & Mixes'},
    {'name': 'Sinigang Mix', 'tagalog': 'Sampalok Mix', 'emoji': '🍋', 'category': 'Sauces & Mixes'},
    {'name': 'Coconut Milk', 'tagalog': 'Gata', 'emoji': '🥥', 'category': 'Sauces & Mixes'},
    {'name': 'Shrimp Paste', 'tagalog': 'Bagoong', 'emoji': '🦐', 'category': 'Sauces & Mixes'},
    {'name': 'Tomato Sauce', 'tagalog': 'Tomato Paste', 'emoji': '🥫', 'category': 'Sauces & Mixes'},
    {'name': 'Peanut Butter', 'tagalog': 'Mani', 'emoji': '🥜', 'category': 'Carbs & Pantry'},
  ];

  void _toggleIngredient(String name) {
    setState(() {
      final existingIndex = _availableIngredients.indexWhere(
          (i) => i.toLowerCase() == name.toLowerCase());
      if (existingIndex >= 0) {
        _availableIngredients.removeAt(existingIndex);
      } else {
        _availableIngredients.add(name);
      }
    });
  }

  void _addCombo(String comboName, List<String> ingredients) {
    setState(() {
      for (final item in ingredients) {
        if (!_availableIngredients.any((i) => i.toLowerCase() == item.toLowerCase())) {
          _availableIngredients.add(item);
        }
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $comboName ingredients!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildComboChip(String label, List<String> ingredients) {
    return ActionChip(
      label: Text(label),
      onPressed: () => _addCombo(label, ingredients),
      backgroundColor: const Color(0xFFFFF8E7),
      side: const BorderSide(color: Color(0xFFFFBB16), width: 1),
      labelStyle: const TextStyle(
        color: Color(0xFFE67300),
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  void _addIngredient() {
    final text = _ingredientsController.text.trim();
    if (text.isNotEmpty) {
      final parts = text.split(',');
      setState(() {
        for (final p in parts) {
          final trimmed = p.trim();
          if (trimmed.isNotEmpty && !_availableIngredients.contains(trimmed)) {
            _availableIngredients.add(trimmed);
          }
        }
        _ingredientsController.clear();
      });
    }
  }



  void _searchRecipes() {
    if (_ingredientsController.text.trim().isNotEmpty) {
      _addIngredient();
    }

    final query = _availableIngredients.join(', ');
    if (query.isNotEmpty) {
      setState(() {
        _searchQuery = query;
        _currentIndex = 1; // Switch to Recipes tab
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Searching recipes for: $query'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      final fallbackQuery = _ingredientsController.text.trim();
      if (fallbackQuery.isNotEmpty) {
        setState(() {
          _searchQuery = fallbackQuery;
          _currentIndex = 1;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please add or type ingredients to search!')),
        );
      }
    }
  }

  final List<Map<String, dynamic>> _masterPool = [
    {
      'title': 'Harissa roast bowl',
      'tag': "EDITOR'S PICK",
      'tagColor': const Color(0xFFE05A47),
      'textColor': Colors.white,
      'time': '25 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=600&auto=format&fit=crop',
      'ingredients': ['1 cup quinoa', '2 tbsp harissa paste', 'Roasted chickpeas & sweet potato', 'Tahini dressing & fresh parsley'],
      'instructions': ['Roast chickpeas and sweet potato cubes with harissa paste at 200°C for 20 mins.', 'Cook quinoa according to package instructions.', 'Assemble bowl with quinoa, veggies, and drizzle tahini dressing.'],
    },
    {
      'title': 'Lemony herb pasta',
      'tag': 'WEEKNIGHT',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '20 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1645112411341-6c4fd023714a?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['200g spaghetti pasta', 'Fresh lemon juice & zest', 'Extra virgin olive oil', 'Fresh basil & parmesan'],
      'instructions': ['Boil pasta until al dente.', 'Toss with olive oil, lemon zest, juice, and fresh herbs.', 'Garnish with grated parmesan.'],
    },
    {
      'title': 'Crispy chilli salmon',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '25 min',
      'rating': '4.7',
      'imageUrl': 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['2 salmon fillets', 'Chili oil & soy sauce', 'Steamed jasmine rice'],
      'instructions': ['Sear salmon skin-side down until crispy.', 'Glaze with chili oil sauce.', 'Serve hot over steamed jasmine rice.'],
    },
    {
      'title': 'Neapolitan Margherita Pizza',
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
      'title': 'Tonkotsu Shoyu Ramen',
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
      'title': 'Authentic Carne Asada Tacos',
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
      'title': 'Pad Thai Goong',
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
      'title': 'Butter Chicken (Murgh Makhani)',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '35 min',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?q=80&w=200&auto=format&fit=crop',
      'ingredients': ['Marinated chicken pieces', 'Tomato puree & butter', 'Heavy cream & garam masala', 'Fenugreek leaves (kasuri methi)'],
      'instructions': ['Char marinated chicken pieces.', 'Simmer in a velvety spiced tomato and butter sauce with heavy cream.', 'Finish with crushed kasuri methi and cream swirl.'],
    },
  ];

  late Map<String, dynamic> _editorsPick;
  late List<Map<String, dynamic>> _popularItems;

  @override
  void initState() {
    super.initState();
    _randomizeWeeklyRecipes();
  }

  void _randomizeWeeklyRecipes() {
    final now = DateTime.now();
    final weekNumber = (now.difference(DateTime(now.year, 1, 1)).inDays / 7).floor();
    final random = Random(weekNumber);

    final pool = List<Map<String, dynamic>>.from(_masterPool);
    pool.shuffle(random);

    _editorsPick = pool[0];
    _editorsPick['tag'] = "EDITOR'S PICK";
    _editorsPick['tagColor'] = const Color(0xFFE05A47);
    _editorsPick['textColor'] = Colors.white;

    _popularItems = [pool[1], pool[2]];
  }

  @override
  void dispose() {
    _ingredientsController.dispose();
    super.dispose();
  }



  Future<void> _openCamera() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final scanned = ['chicken breast', 'garlic', 'tomato', 'olive oil'];
        setState(() {
          for (final item in scanned) {
            if (!_availableIngredients.contains(item)) {
              _availableIngredients.add(item);
            }
          }
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ingredients scanned and added from photo!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening camera: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildPantryPage(),
      RecipesScreen(initialSearchQuery: _searchQuery),
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
                        () {
                          final email = Auth().currentUser?.email;
                          if (email != null && email.contains('@')) {
                            final rawName = email.split('@').first;
                            if (rawName.isNotEmpty) {
                              return 'Goodmorning ${rawName[0].toUpperCase()}${rawName.substring(1)}';
                            }
                          }
                          return 'Goodmorning Maria';
                        }(),
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
                      if (Auth().currentUser != null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Sign Out'),
                            content: const Text('Are you sure you want to sign out?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await Auth().signOut();
                                  if (!context.mounted) return;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WidgetTree(),
                                    ),
                                  );
                                },
                                child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInProfileScreen(),
                          ),
                        );
                      }
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
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _ingredientsController,
                            onSubmitted: (_) => _addIngredient(),
                            decoration: InputDecoration(
                              hintText: 'e.g. Chicken, garlic, soy sauce...',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.35),
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFAF6F0),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0xFFFFBB16),
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0xFFFFBB16),
                                  width: 1.5,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.camera_alt, color: Color(0xFFFFBB16)),
                                tooltip: 'Scan ingredients with camera',
                                onPressed: _openCamera,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _addIngredient,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF2F2F2),
                              foregroundColor: const Color(0xFF1E1E1E),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: const Text(
                              '+ Add',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _searchRecipes,
                        icon: const Icon(Icons.search, color: Colors.white),
                        label: const Text(
                          'Search Recipes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE67300),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    if (_availableIngredients.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'YOUR AVAILABLE INGREDIENTS (${_availableIngredients.length})',
                            style: const TextStyle(
                              color: Color(0xFFE67300),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _availableIngredients.clear();
                              });
                            },
                            child: const Text(
                              '🗑 Clear all',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _availableIngredients.map((ingredient) {
                          return Chip(
                            label: Text(
                              '$ingredient ×',
                              style: const TextStyle(
                                color: Color(0xFF1E1E1E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            backgroundColor: const Color(0xFFFFF3CD),
                            side: const BorderSide(color: Color(0xFFFFBB16), width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onDeleted: () {
                              setState(() {
                                _availableIngredients.remove(ingredient);
                              });
                            },
                            deleteIcon: const SizedBox.shrink(),
                          );
                        }).toList(),
                      ),
                    ],

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              _isCommonPantryExpanded = !_isCommonPantryExpanded;
                            });
                          },
                          icon: const Icon(Icons.shopping_basket_outlined, size: 16, color: Color(0xFFE67300)),
                          label: Text(
                            _isCommonPantryExpanded
                                ? 'Hide Common Pantry ▴'
                                : '+ Add Common Filipino Pantry ▾',
                            style: const TextStyle(
                              color: Color(0xFFE67300),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFF8E7),
                            side: const BorderSide(color: Color(0xFFFFBB16), width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              '💡 Tip: Separate ingredients with commas (e.g. pork, garlic, kangkong)',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 10,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (_isCommonPantryExpanded) ...[
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFFFF3CD), thickness: 1.5),
                      const SizedBox(height: 12),

                      // Quick Kitchen Combos
                      const Text(
                        '✨ QUICK KITCHEN COMBOS (1-CLICK TEST)',
                        style: TextStyle(
                          color: Color(0xFFE67300),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildComboChip('+ Adobo Combo', ['Pork', 'Chicken', 'Garlic', 'Soy Sauce', 'Vinegar']),
                            const SizedBox(width: 8),
                            _buildComboChip('+ Sinigang Staples', ['Pork', 'Sinigang Mix', 'Tomato', 'Onion', 'Kangkong', 'String Beans']),
                            const SizedBox(width: 8),
                            _buildComboChip('+ Ginisang Monggo', ['Garlic', 'Onion', 'Tomato', 'Pork', 'Malunggay']),
                            const SizedBox(width: 8),
                            _buildComboChip('+ Pancit Merienda', ['Chicken', 'Garlic', 'Onion', 'Cabbage', 'Carrot', 'Soy Sauce']),
                            const SizedBox(width: 8),
                            _buildComboChip('+ Tortang Talong', ['Eggplant', 'Egg', 'Garlic', 'Onion']),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Tap items to add or remove from your kitchen:',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Category Tabs
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: ['All', 'Meat & Seafood', 'Vegetables & Aromatics', 'Sauces & Mixes', 'Carbs & Pantry'].map((cat) {
                            final isCatSelected = _selectedPantryCategory == cat;
                            return Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: ChoiceChip(
                                label: Text(cat),
                                selected: isCatSelected,
                                onSelected: (sel) {
                                  if (sel) {
                                    setState(() {
                                      _selectedPantryCategory = cat;
                                    });
                                  }
                                },
                                selectedColor: const Color(0xFF1E1E1E),
                                backgroundColor: const Color(0xFFF2F2F2),
                                labelStyle: TextStyle(
                                  color: isCatSelected ? Colors.white : Colors.black87,
                                  fontSize: 12,
                                  fontWeight: isCatSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Pantry Item Chips
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _pantryItems.where((item) {
                          return _selectedPantryCategory == 'All' ||
                              item['category'] == _selectedPantryCategory;
                        }).map((item) {
                          final name = item['name']!;
                          final tagalog = item['tagalog']!;
                          final emoji = item['emoji']!;
                          final isSelected = _availableIngredients.any(
                              (i) => i.toLowerCase() == name.toLowerCase());

                          return InkWell(
                            onTap: () => _toggleIngredient(name),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFFFF3CD) : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFFFFBB16) : Colors.black12,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(emoji, style: const TextStyle(fontSize: 14)),
                                  const SizedBox(width: 4),
                                  Text(
                                    '$name ($tagalog)',
                                    style: TextStyle(
                                      color: isSelected ? const Color(0xFF1E1E1E) : Colors.black87,
                                      fontSize: 12,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    isSelected ? Icons.check : Icons.add,
                                    size: 14,
                                    color: isSelected ? const Color(0xFFE67300) : Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
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
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: const Color(0xFFE2F0D9),
                  child: const Center(
                    child: Icon(Icons.restaurant, size: 28, color: Color(0xFF0D3E26)),
                  ),
                ),
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
