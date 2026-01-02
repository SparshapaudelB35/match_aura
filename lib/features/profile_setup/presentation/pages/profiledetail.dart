import 'package:flutter/material.dart';
import 'package:match_aura/features/profile_setup/presentation/pages/gender.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  DateTime? selectedDate;

  // Function to handle Date Picking
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFC033E6);

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9C27B0),
              ),
            ),
            const SizedBox(height: 40),

            // Profile Picture Section
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor, width: 1),
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            // First Name Field
            TextField(
              decoration: InputDecoration(
                labelText: "First Name",
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Last Name Field
            TextField(
              decoration: InputDecoration(
                labelText: "Last Name",
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Birth Date Picker Button
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: primaryColor,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      selectedDate == null
                          ? "Choose Birth Date"
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Bio",
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 60),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectGenderPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
