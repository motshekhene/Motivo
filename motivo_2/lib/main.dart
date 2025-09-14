import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD_m0cEiE3SEFOu9SEk-7vQ_vdbkFQ4WII",
      appId: "1:14753296809:android:af322b820b43bcdc5f94b8",
      messagingSenderId: "14753296809",
      projectId: "motivo-35d26",
      storageBucket: "motivo-35d26.firebasestorage.app",
    ),
  );

  runApp(const MotivoApp());
}

class MotivoApp extends StatelessWidget {
  const MotivoApp({super.key});

  static const Color primary = Color(0xFF5D4AC8);
  static const Color primaryLight = Color(0xFF7E6CE0);
  static const Color primaryDark = Color(0xFF3D2F91);
  static const Color background = Color(0xFFF5F7FA);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motivo',
      theme: ThemeData(
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          ),
        ),
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ------------------- WELCOME SCREEN -------------------

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SecondPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: UCurveClipper(),
                child: Container(
                  height: 320,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [MotivoApp.primary, MotivoApp.primaryDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 60,
                right: 30,
                child: Icon(Icons.lightbulb_outline,
                    size: 100, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 200),
            child: Column(
              children: [
                Text(
                  'Welcome to Motivo!',
                  style: GoogleFonts.pacifico(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: MotivoApp.primaryDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  'Founded by Sebetola Junior\nEst. 2025',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black54,
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

class UCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 80,
      size.width,
      size.height - 100,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ------------------- SECOND PAGE -------------------

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
        backgroundColor: MotivoApp.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose an option to continue:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 18),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? MotivoApp.primaryLight.withOpacity(0.2)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? MotivoApp.primary
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            options[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? MotivoApp.primaryDark
                                  : Colors.black87,
                            ),
                          ),
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color:
                                isSelected ? MotivoApp.primary : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 130,
                child: ElevatedButton(
                  onPressed: selectedIndex == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ThirdPage()),
                          );
                        },
                  child: const Text("Next"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- THIRD PAGE -------------------

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final List<String> goals = [
    "Academic Life",
    "Professional Life",
    "General",
    "Social relationships",
    "GOD",
  ];
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Motivation Category?"),
        backgroundColor: MotivoApp.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose an option to continue:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 18),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? MotivoApp.primaryLight.withOpacity(0.2)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? MotivoApp.primary
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            goals[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? MotivoApp.primaryDark
                                  : Colors.black87,
                            ),
                          ),
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color:
                                isSelected ? MotivoApp.primary : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 130,
                child: ElevatedButton(
                  onPressed: selectedIndex == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FourthPage(category: goals[selectedIndex!])),
                          );
                        },
                  child: const Text("Next"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- FOURTH PAGE -------------------
// (Repeat same expanded pattern as above)

class FourthPage extends StatefulWidget {
  final String category;
  const FourthPage({super.key, required this.category});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  final TextEditingController _usernameController = TextEditingController();
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Username"),
        backgroundColor: MotivoApp.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter a username you’d like to use:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),

            // 📝 Username Input Field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "e.g. MotivatedJunior",
                hintStyle: const TextStyle(color: Colors.black38),
                errorText: _errorText,
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: MotivoApp.primary, width: 2),
                ),
              ),
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    if (_usernameController.text.trim().isEmpty) {
                      setState(() {
                        _errorText = "Username cannot be empty";
                      });
                    } else {
                      setState(() {
                        _errorText = null;
                      });

                      // Navigate to FifthPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  FifthPage(
                              username: _usernameController.text.trim(),
                              category: widget.category,
                            
                      ),
                        ),
                      );
                    }
                  },
                  child: const Text("Next"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ------------------- FIFTH PAGE -------------------

class FifthPage extends StatelessWidget {
  final String username;
  final String category;

  const FifthPage({super.key,required this.username, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("You're all set!"),
        backgroundColor: MotivoApp.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.celebration, size: 100, color: MotivoApp.primary),
              const SizedBox(height: 20),
              Text(
                "Welcome to Motivo once again,$username!",
                style: GoogleFonts.poppins(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "You’re ready to start your motivational journey.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
  onPressed: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NotificationTimeScreen(
        username: username,
        category: category,
      ),
    ),
  ),
  child: const Text("Set Notification Time"),
),

            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- NOTIFICATION TIME SCREEN -------------------


class NotificationTimeScreen extends StatefulWidget {
  final String username;
  final String category;

  const NotificationTimeScreen({super.key, required this.username, required this.category});

  @override
  State<NotificationTimeScreen> createState() => _NotificationTimeScreenState();
}

class _NotificationTimeScreenState extends State<NotificationTimeScreen> {
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Notification Time"),
        backgroundColor: MotivoApp.primary,
      ),
      body: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    SizedBox(
      height: 200, // give it a fixed height
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: DateTime(
            2025, 1, 1, selectedTime.hour, selectedTime.minute),
        use24hFormat: true,
        onDateTimeChanged: (DateTime newDateTime) {
          setState(() {
            selectedTime = TimeOfDay(
              hour: newDateTime.hour,
              minute: newDateTime.minute,
            );
          });
        },
      ),
    ),
    const SizedBox(height: 30),
    ElevatedButton(
  onPressed: () async {
    try {
      // Save notification time to Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.username)
          .set({
        "username": widget.username,
        "category": widget.category,
        "hour": selectedTime.hour,
        "minute": selectedTime.minute,
        "streak": 0, // initialize daily streak
      });

      // Show a confirmation SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Motivation time set to ${selectedTime.format(context)}"),
          backgroundColor: MotivoApp.primary,
        ),
      );

      // Navigate to the interactive MotivationSetupPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MotivationSetupPage(
            username: widget.username,
            category: widget.category,
            notificationTime: selectedTime,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving data: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  child: const Text("Save"),
),

  ],
),

    );
  }
}
class MotivationSetupPage extends StatefulWidget {
  final String username;
  final String category;
  final TimeOfDay notificationTime;

  const MotivationSetupPage({
    super.key,
    required this.username,
    required this.category,
    required this.notificationTime,
  });

  @override
  State<MotivationSetupPage> createState() => _MotivationSetupPageState();
}

class _MotivationSetupPageState extends State<MotivationSetupPage> {
  String? motivationMessage;
  String challengeMessage = "";
  int streak = 0; // daily streak

  @override
  void initState() {
    super.initState();
    _fetchRandomMotivation();
    _generateDailyChallenge();
    _loadStreak();
  }

  Future<void> _fetchRandomMotivation() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("motivations")
        .doc(widget.category)
        .collection("texts")
        .get();

    final docs = snapshot.docs;
    if (docs.isEmpty) {
      setState(() {
        motivationMessage = "Stay motivated!";
      });
      return;
    }

    final randomDoc = (docs..shuffle()).first;
    setState(() {
      motivationMessage = randomDoc["text"];
    });
  }

  void _generateDailyChallenge() {
    final challenges = [
      "Write down one thing you'll do today to reach your goal.",
      "Send a motivational message to a friend.",
      "Take 5 minutes to visualize your ideal outcome.",
      "Reflect on one success from this week.",
      "List 3 small actions to improve yourself today."
    ];
    setState(() {
      challengeMessage = (challenges..shuffle()).first;
    });
  }

  Future<void> _loadStreak() async {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.username)
        .get();

    if (doc.exists && doc.data() != null) {
      setState(() {
        streak = doc.data()!['streak'] ?? 0;
      });
    }
  }

  Future<void> _incrementStreak() async {
    final docRef =
        FirebaseFirestore.instance.collection("users").doc(widget.username);
    final doc = await docRef.get();

    DateTime today = DateTime.now();
    String todayStr = "${today.year}-${today.month}-${today.day}";

    if (doc.exists && doc.data() != null) {
      final lastCompleted = doc.data()!['lastChallengeDate'] ?? "";
      if (lastCompleted == todayStr) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You've already completed today's challenge!"),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
    }

    // Increment streak
    setState(() {
      streak += 1;
    });

    // Update Firestore
    await docRef.update({
      'streak': streak,
      'lastChallengeDate': todayStr,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🎉 Celebration Icon
              Icon(Icons.celebration, size: 100, color: MotivoApp.primary),
              const SizedBox(height: 20),

              // 💬 Motivational message
              if (motivationMessage != null)
                Text(
                  motivationMessage!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              const SizedBox(height: 30),

              // 🔥 Daily Streak
              Text(
                "Your Daily Streak: $streak 🔥",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),

              // 📌 Daily Challenge
              Text(
                "Today's Challenge:",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                challengeMessage,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),

              // 🌐 Share Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const FaIcon(FontAwesomeIcons.whatsapp),
                    label: const Text("WhatsApp"),
                    onPressed: () async {
                      final text = Uri.encodeComponent(
                          motivationMessage ?? "Stay motivated!");
                      final url = Uri.parse("https://wa.me/?text=$text");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    icon: const FaIcon(FontAwesomeIcons.facebook),
                    label: const Text("Facebook"),
                    onPressed: () async {
                      final text = Uri.encodeComponent(
                          motivationMessage ?? "Stay motivated!");
                      final url = Uri.parse(
                          "https://www.facebook.com/sharer/sharer.php?u=&quote=$text");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.share),
                    label: const Text("Other"),
                    onPressed: () async {
                      final text = motivationMessage ?? "Stay motivated!";
                      final url =
                          Uri.parse("mailto:?subject=Motivation&body=$text");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // ✅ Mark Challenge Done (to increment streak)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: MotivoApp.primary,
                ),
                onPressed: _incrementStreak,
                child: const Text(
                  "I Completed Today's Challenge",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}