import 'package:flutter/material.dart';
import 'package:match_aura/screens/home_screen.dart';


class InterestsPage extends StatefulWidget {
  const InterestsPage({super.key});
  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  final Set<String> _selected = {}; // Starts empty
  final Color primaryPurple = const Color(0xFFC033E6);

  final List<Map<String, dynamic>> items = [
    {"n": "Music", "i": Icons.music_note}, {"n": "Singing", "i": Icons.mic},
    {"n": "Gaming", "i": Icons.sports_esports_outlined}, {"n": "Art", "i": Icons.palette},
    {"n": "Travel", "i": Icons.flight}, {"n": "Gym", "i": Icons.fitness_center},
    {"n": "Hiking", "i": Icons.terrain}, {"n": "Pets", "i": Icons.pets},
    {"n": "Photography", "i": Icons.camera_alt_outlined},
    {"n": "Cooking", "i": Icons.restaurant_menu},
    {"n": "Reading", "i": Icons.menu_book}, {"n": "Movies", "i": Icons.movie},
    {"n": "Fashion", "i": Icons.checkroom}, {"n": "Sports", "i": Icons.sports_soccer},
    {"n": "Technology", "i": Icons.computer}, {"n": "Fitness", "i": Icons.sports_handball},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white.withOpacity(
                  0.9,
                ), 
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.purple,
                size: 18,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Your Interest", 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF9C27B0)),
                ),
                Text(
                  "Pick at least 3 things you love (${_selected.length}/3 selected)", 
                  style: TextStyle(
                    color: _selected.length < 3 ? Colors.redAccent : Colors.grey,
                    fontWeight: _selected.length < 3 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 30),
                
                Expanded(
                  child: GridView.builder(
                    itemCount: items.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2.5,
                    ),
                    itemBuilder: (context, index) {
                      return _chip(items[index]);
                    },
                  ),
                ),
                
                _buildConfirmButton("Continue"),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(Map<String, dynamic> item) {
    bool isSel = _selected.contains(item['n']);
    return GestureDetector(
      onTap: () => setState(() {
        isSel ? _selected.remove(item['n']) : _selected.add(item['n']);
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSel ? primaryPurple : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryPurple.withOpacity(0.4)),
          boxShadow: isSel 
              ? [BoxShadow(color: primaryPurple.withOpacity(0.2), blurRadius: 5, offset: const Offset(0, 3))] 
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item['i'], color: isSel ? Colors.white : primaryPurple, size: 20),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                item['n'], 
                style: TextStyle(
                  color: isSel ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton(String text) {
    bool canProceed = _selected.length >= 3;

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: canProceed ? primaryPurple : primaryPurple.withOpacity(0.5), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: canProceed ? 2 : 0,
        ),
        onPressed: () {
          if (canProceed) {
            // Navigate to Home
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            
          } else {
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Please select at least ${3 - _selected.length} more interest(s)"),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Text(
          text, 
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}