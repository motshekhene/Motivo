import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MotivoApp());
}


class MotivoApp extends StatelessWidget {
  const MotivoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motivo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SecondPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Curved header background
          Stack(
            children: [
              ClipPath(
                clipper: UCurveClipper(),
                child: Container(
                  height: 320,
                  color: const Color.fromARGB(255, 58, 99, 146),
                ),
              ),
              const Positioned(
                top: 60,
                right: 30,
                child: Icon(
                  Icons.lightbulb_outline,
                  size: 100,
                  color: Color.fromARGB(255, 8, 1, 22),
                ),
              ),
            ],
          ),

          // Main content below the curve
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 200),
            child: Column(
              children: [
                Text(
                  'Welcome to Motivo!',
                  style: GoogleFonts.pacifico(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 8, 8, 8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  'Founded by Sebetola Junior\nEst. 2025',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom clipper for a U-shaped curve
class UCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at top left
    path.lineTo(0, size.height - 100);

    // U-shaped curve
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 80,
      size.width,
      size.height - 100,
    );

    // Complete the path
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final List<String> options = [
    "Friend/Family",
    "Instagram",
    "Facebook",
    "Twitter",
    "Advertisement",
    "Other",
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How did you hear about Motivo?"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Choose an option to continue.",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20), // space between text and options
            // Options list below
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color.fromARGB(255, 150, 151, 185) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color.fromARGB(255, 87, 4, 231) : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 76, 8, 233),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            options[index],
                            style: TextStyle(
                              fontSize: 18,
                              color: isSelected ? const Color.fromARGB(255, 8, 3, 16) : Colors.black87,
                            ),
                          ),
                          isSelected
                              ? const Icon(Icons.check_box, color: Color.fromARGB(255, 51, 47, 112))
                              : const Icon(Icons.check_box_outline_blank, color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
  width: 200,
  child: ElevatedButton(
    onPressed: selectedIndex == null
        ? null
        : () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ThirdPage()),
            );
          },
    child: const Text('Next'),
  ),
),

          ],
        ),
      ),
    );
  }

}

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final List<String> options = [
    "12-16",
    "17-21",
    "22-29",
    "30-45",
    "45-55",
    "56+",
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "How old are you?",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20), // space between text and options
            // Options list below
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color.fromARGB(255, 150, 151, 185) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color.fromARGB(255, 87, 4, 231) : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 76, 8, 233),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            options[index],
                            style: TextStyle(
                              fontSize: 18,
                              color: isSelected ? const Color.fromARGB(255, 8, 3, 16) : Colors.black87,
                            ),
                          ),
                          isSelected
                              ? const Icon(Icons.check_box, color: Color.fromARGB(255, 51, 47, 112))
                              : const Icon(Icons.check_box_outline_blank, color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
  width: 200,
  child:ElevatedButton(
    onPressed: selectedIndex == null
        ? null
        : () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FourthPage()),
            );
          },
    child: const Text('Next'),
  ),

),
          ],
        ),
      ),
    );
  }
}

class FourthPage extends StatefulWidget {
  const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'What do you prefer being called?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your name will be displayed in your daily quotes',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username',
              ),
            ),
            const Spacer(),  // pushes button to the bottom
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FifthPage()),
                  );
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FifthPage extends StatefulWidget {
  const FifthPage({super.key}); // fixed typo: 'FIfthPage' → 'FifthPage'

  @override
  State<FifthPage> createState() => _FifthPageState(); // fixed space in class name
}

class _FifthPageState extends State<FifthPage> { // fixed state class name
  final List<String> options = [
    "School",
    "Relationships",
    "Professional Life",
    "Family",          // fixed typo: "'Fanily" → "Family"
    "Financial Goals",
    "Self-Care",
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select an Area"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, // Align left for text and options
          children: [
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Which area motivates you most?",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20), // space between text and options
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromARGB(255, 150, 151, 185)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color.fromARGB(255, 87, 4, 231)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 76, 8, 233).withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            options[index],
                            style: TextStyle(
                              fontSize: 18,
                              color: isSelected
                                  ? const Color.fromARGB(255, 8, 3, 16)
                                  : Colors.black87,
                            ),
                          ),
                          isSelected
                              ? const Icon(Icons.check_box,
                                  color: Color.fromARGB(255, 51, 47, 112))
                              : const Icon(Icons.check_box_outline_blank,
                                  color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: selectedIndex == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SixthPage()),
                        );
                      },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class SixthPage extends StatefulWidget {
  const SixthPage({super.key}); 

  @override
  State<SixthPage> createState() => _SixthPageState(); // fixed space in class name
}

class _SixthPageState extends State<SixthPage> { // fixed state class name
  final List<String> options = [
    "English",
    "Khelobedu",
    "isiZulu",
    "Sepedi",          
    "isiXhosa",
    "Tsonga",
    "Venda",
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select an Area"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, // Align left for text and options
          children: [
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "In which language would you like your motivations?",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20), 
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromARGB(255, 150, 151, 185)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color.fromARGB(255, 87, 4, 231)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 76, 8, 233).withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            options[index],
                            style: TextStyle(
                              fontSize: 18,
                              color: isSelected
                                  ? const Color.fromARGB(255, 8, 3, 16)
                                  : Colors.black87,
                            ),
                          ),
                          isSelected
                              ? const Icon(Icons.check_box,
                                  color: Color.fromARGB(255, 51, 47, 112))
                              : const Icon(Icons.check_box_outline_blank,
                                  color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: selectedIndex == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationTimeScreen()),
                        );
                      },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class NotificationTimeScreen extends StatefulWidget {
  const NotificationTimeScreen({super.key});

  @override
  State<NotificationTimeScreen> createState() => _NotificationTimeScreenState();
}

class _NotificationTimeScreenState extends State<NotificationTimeScreen> {
  TimeOfDay? _selectedTime;

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? const TimeOfDay(hour: 8, minute: 0),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB8C6EC), Color(0xFFF5F7FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Top curve decoration
                ClipPath(
                  clipper: TopCurveClipper(),
                  child: Container(
                    height: 120,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),

                const SizedBox(height: 40),
                const Text(
                  "Pick Your Daily Motivation Time",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4AC8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your daily boost awaits!",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 80),

                // Time picker card
                GestureDetector(
                  onTap: _pickTime,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.access_time, size: 30, color: Color(0xFF5D4AC8)),
                        const SizedBox(width: 20),
                        Text(
                          _selectedTime == null
                              ? 'Tap to Pick Time'
                              : _selectedTime!.format(context),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D4AC8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Next button
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedTime == null
                          ? Colors.grey[400]
                          : const Color.fromARGB(255, 107, 92, 196),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _selectedTime == null
                        ? null
                        : () {
                            // TODO: Save selected time
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NextPage()),
                            );
                          },
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Top curve clipper
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height + 40, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Placeholder next page
class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Next Page')),
    );
  }
}
