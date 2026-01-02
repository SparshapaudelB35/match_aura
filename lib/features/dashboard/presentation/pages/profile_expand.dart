import 'package:flutter/material.dart';

class ProfileDetailExpandScreen extends StatelessWidget {
  const ProfileDetailExpandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            _buildHeaderImage(context), 

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    "Sophie Lama, 24",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8E24AA),
                    ),
                  ),
                  const SizedBox(height: 15),

                  _buildBioCard(),
                  const SizedBox(height: 25),

                  const Text(
                    "Interest",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildInterestGrid(),
                  const SizedBox(height: 25),

                  const Text(
                    "Gallery",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildGalleryGrid(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 450,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
            ),
            image: const DecorationImage(
              image: AssetImage('assets/images/imagedemo.jpg'),
              fit: BoxFit.contain,
            ),
            
          ),
        ),

        Positioned(
          top: 40,
          left: 20,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                border: Border.all(color: Colors.purple.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.purple,
                size: 18,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _circleButton(Icons.close, Colors.red, Colors.white),
              const SizedBox(width: 20),
              _circleButton(Icons.favorite, Colors.white, Colors.pink),
              const SizedBox(width: 20),
              _circleButton(Icons.star, Colors.white, Colors.purple),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circleButton(IconData icon, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Icon(icon, color: iconColor, size: 30),
    );
  }

  Widget _buildBioCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.deepPurple, Colors.purpleAccent],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bio",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _placeholderBar(0.9),
          const SizedBox(height: 8),
          _placeholderBar(0.6),
          const SizedBox(height: 8),
          _placeholderBar(0.7),
        ],
      ),
    );
  }

  Widget _placeholderBar(double widthFactor) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: 8,
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  Widget _buildInterestGrid() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _interestChip(Icons.music_note, "Music"),
        _interestChip(Icons.flight, "Traveling"),
        _interestChip(Icons.waves, "Swimming"),
        _interestChip(Icons.sports_soccer, "Football"),
      ],
    );
  }

  Widget _interestChip(IconData icon, String label) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            'https://via.placeholder.com/150',
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
