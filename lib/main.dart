import 'package:assignment_project/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


void main() {
  // Start the Flutter application
  runApp(const NineScreenApp());
}

// =========================================================================
// 1. Theme and App Setup
// =========================================================================

class NineScreenApp extends StatelessWidget {
  const NineScreenApp({super.key});

  // Primary color matching the deep blue in the image
  static const Color primaryBlue = Color(0xFF1976D2);

  @override
  Widget build(BuildContext context) {
    // Set up the app theme and routes using MaterialApp
    return MaterialApp(
      title: '9 Page UI Demo',
      theme: ThemeData(
        primaryColor: primaryBlue,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: primaryBlue),
        scaffoldBackgroundColor: Colors.grey.shade100, // Light gray background
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        // Default shape for rounded corners across the app
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        // Button styling
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 14),
            elevation: 0,
          ),
        ),
      ),
      initialRoute: '/', // Initial screen
      routes: {
        '/': (context) => const Screen1LanguageSelection(),
        '/signup': (context) => const Screen2SignUp(),
        '/otp': (context) => const Screen3OTPVerification(),
        '/login': (context) => const Screen4Login(),
        '/call_setup': (context) => const Screen5CallSetup(),
        '/dashboard_home': (context) => const Screen6DashboardHome(),
        '/settings': (context) => const Screen7Settings(),
        '/dashboard_chart': (context) => const Screen8DashboardChart(),
        '/account_menu': (context) => const Screen9AccountMenu(),
      },
      debugShowCheckedModeBanner: false, // Remove Flutter banner
    );
  }
}

// =========================================================================
// 2. Reusable Widgets
// =========================================================================

const Color primaryBlue = NineScreenApp.primaryBlue;

// Widget to build the application logo
Widget buildLogo() {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    child: Row(
      
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Use Image.asset or a fallback Text widget if asset is not found
        Image.asset(
          'assets/Logo.png',
          height: 40,
          errorBuilder: (context, error, stackTrace) => const Text('C',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: primaryBlue)),
        ),
        const SizedBox(width: 8),
        
      ],
    ),
  );
}

// Custom TextFormField Widget
class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        // Rounded outline border
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Icon(icon, color: Colors.grey),
        ),
      ),
    );
  }
}

// White Card Container (used in Signup/Login/OTP)
class WhiteCardContainer extends StatelessWidget {
  final Widget child;
  final double topMargin;

  const WhiteCardContainer({required this.child, this.topMargin = 20, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: topMargin),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: child,
    );
  }
}

// Bottom Navigation Bar Widget
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildNavIcon(Icons.home_outlined, 'Home', () => Navigator.pushNamed(context, '/dashboard_home')),
          buildNavIcon(Icons.folder_open_outlined, 'Lists', () => Navigator.pushNamed(context, '/dashboard_chart')),
          const SizedBox(width: 40), // Space for the FAB/Middle Button
          buildNavIcon(Icons.phone_outlined, 'Call', () => Navigator.pushNamed(context, '/call_setup')),
          buildNavIcon(Icons.calendar_today_outlined, 'Schedule', () => Navigator.pushNamed(context, '/account_menu')),
        ],
      ),
    );
  }

  Widget buildNavIcon(IconData icon, String label, VoidCallback onTap) {
    return IconButton(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.grey.shade700, size: 24),
          Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade700)),
        ],
      ),
      onPressed: onTap,
    );
  }
}

// =========================================================================
// 3. Screen 1: Language Selection
// =========================================================================

class Screen1LanguageSelection extends StatelessWidget {
  const Screen1LanguageSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Language'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: WhiteCardContainer(
              topMargin: 0, 
              child: ListView(
                padding: const EdgeInsets.only(top: 0),
                children: const [
                  LanguageOption(label: 'English', subLabel: 'Hi', isSelected: true),
                  LanguageOption(label: 'Hindi', subLabel: 'नमस्ते'),
                  LanguageOption(label: 'Bengali', subLabel: 'হ্যালো'),
                  LanguageOption(label: 'Kannada', subLabel: 'ನಮಸ್ಕಾರ'),
                  LanguageOption(label: 'Punjabi', subLabel: 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ'),
                  LanguageOption(label: 'Tamil', subLabel: 'வணக்கம்'),
                  LanguageOption(label: 'Telugu', subLabel: 'హలో'),
                  LanguageOption(label: 'French', subLabel: 'Bonjour'),
                  LanguageOption(label: 'Spanish', subLabel: 'Hola'),
                ],
              ),
            ),
          ),
          // 'Select' Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Screen 2: Sign Up
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('Select',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String label;
  final String subLabel;
  final bool isSelected;
  const LanguageOption(
      {required this.label, required this.subLabel, this.isSelected = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(subLabel, style: const TextStyle(color: Colors.grey)),
          trailing: Radio<bool>(
            value: true,
            groupValue: isSelected,
            onChanged: (bool? value) {
              // State update logic here
            },
            activeColor: Colors.black, // Selected color
          ),
          onTap: () {
            // Handle selection
          },
        ),
        const Divider(height: 1),
      ],
    );
  }
}

// =========================================================================
// 4. Screen 2: Sign Up
// =========================================================================

class Screen2SignUp extends StatelessWidget {
  const Screen2SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Light gray background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildLogo(), // Logo
              WhiteCardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome!',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text('Please register to continue',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 30),

                    // 1. Name Field
                    const CustomTextField(labelText: 'Name', icon: Icons.person_outline),
                    const SizedBox(height: 15),

                    // 2. Email Field
                    const CustomTextField(
                        labelText: 'Email address', icon: Icons.mail_outline),
                    const SizedBox(height: 15),

                    // 3. Password Field
                    const CustomTextField(
                        labelText: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true),
                    const SizedBox(height: 15),

                    // 4. Mobile Number Field (Custom Design from Image)
                    buildMobileNumberField(),
                    const SizedBox(height: 20),

                    // Terms and Conditions Checkbox
                    Row(
                      children: [
                        Checkbox(
                            value: true, // Demo value
                            onChanged: (val) {},
                            activeColor: primaryBlue),
                        Flexible(
                          child: Text.rich(
                            TextSpan(
                              text: 'I agree to the ',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey.shade600),
                              children: const [
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: TextStyle(
                                      color: primaryBlue,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to Screen 3: OTP Verification
                          Navigator.pushNamed(context, '/otp');
                        },
                        child: const Text('Sign Up',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Already have an account? Sign In
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Navigate to Screen 4: Login
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'Already have an account? ',
                            style: const TextStyle(color: Colors.black54),
                            children: const [
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                    color: primaryBlue, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Mobile Number Field with Country Code
  Widget buildMobileNumberField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          // Flag and Country Code (+91)
          Row(
            children: [
              const Text('🇮🇳', style: TextStyle(fontSize: 18)), // Indian Flag Placeholder
              const SizedBox(width: 8),
              Text('+91',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700)),
              const SizedBox(width: 8),
              Container(
                  width: 1, height: 20, color: Colors.grey.shade300), // Divider
              const SizedBox(width: 12),
            ],
          ),
          // WhatsApp Icon
          const Icon(Icons.call, color: Colors.green, size: 20),
          const SizedBox(width: 10),
          // Mobile Number Input
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Mobile number (WhatsApp)',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// 5. Screen 3: OTP Verification
// =========================================================================

class Screen3OTPVerification extends StatelessWidget {
  const Screen3OTPVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildLogo(),
              WhiteCardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Whatsapp OTP Verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please ensure that the email id mentioned is valid as we have sent an OTP to your email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 30),
                    // OTP Inpu Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          width: 45,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey.shade400),
                              ),
                              counterText: '',
                              contentPadding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < 5) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      '+91 7676288822?', // Placeholder number
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 50),
                    // Resend OTP
                    TextButton(
                      onPressed: () {},
                      child: Text.rich(
                        TextSpan(
                          text: "Didn't receive OTP code? ",
                          style: const TextStyle(color: Colors.black54),
                          children: const [
                            TextSpan(
                              text: 'Resend OTP',
                              style: TextStyle(
                                  color: primaryBlue, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Verify Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to Screen 4: Login
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text('Verify',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// 6. Screen 4: Login
// =========================================================================

class Screen4Login extends StatelessWidget {
  const Screen4Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildLogo(),
              WhiteCardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text('Please sign-in to continue',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 30),

                    // Email Field
                    const CustomTextField(
                        labelText: 'Email address', icon: Icons.mail_outline),
                    const SizedBox(height: 15),

                    // Password Field
                    const CustomTextField(
                        labelText: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true),
                    const SizedBox(height: 10),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?',
                            style: TextStyle(color: Colors.black54)),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to Screen 5: Call Setup
                          Navigator.pushNamed(context, '/call_setup');
                        },
                        child: const Text('Sign In',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Don't have an account? Sign Up
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Navigate to Screen 2: Sign Up
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(color: Colors.black54),
                            children: const [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                    color: primaryBlue, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// 7. Screen 5: Call Setup / Video Tutorial





class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl, super.key});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          isInitialized = true;
        });
        _controller.play(); // autoplay
      });
    _controller.setLooping(true); // loop the video
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
}

// ================== Screen 5 ==================
class Screen5CallSetup extends StatelessWidget {
  const Screen5CallSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Setup'),
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Blue Card Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.pink)),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello Swati',
                          style: TextStyle(color: Colors.white70, fontSize: 14)),
                      Text('Calley Personal',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),

            // Video Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'If you are here for the first time then ensure that you have uploaded the list to call from Calley Web Panel hosted on https://app.getcalley.com',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: const VideoPlayerWidget(
                        videoUrl:
                            'https://youtu.be/FtBzf8VgSUU?si=zAWvFg4OnCyZlaIA', 
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Call to Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  // WhatsApp Button
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.call, color: Colors.green, size: 30),
                  ),
                  const SizedBox(width: 15),
                  
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        
                        Navigator.pushNamed(context, '/dashboard_home');
                      },
                      child: const Text('Start Calling Now',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// =========================================================================
// 8. Screen 6: Dashboard Home
// =========================================================================

class Screen6DashboardHome extends StatelessWidget {
  const Screen6DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Placeholder for Drawer/Side Menu
          },
        ),
        actions: [
          IconButton(icon: const Icon(Icons.headset_mic_outlined), onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                // Navigate to Screen 7: Settings
                Navigator.pushNamed(context, '/settings');
              }),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.pink)),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello Swati',
                          style: TextStyle(color: Colors.white70, fontSize: 14)),
                      Text('Welcome to Calley!',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // 'Load Number to Call' Section
            const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8),
              child: Text('LOAD NUMBER TO CALL',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            
            // Load Number Card
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Visit https://app.getcalley.com to upload numbers that you wish to call using Calley Mobile App.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 10),
                    // Image Placeholder (Man with Headset)
                    Image.asset('assets/call_setup_image.png',
                        height: 200,
                        errorBuilder: (context, error, stackTrace) => Container(
                            height: 200,
                            color: Colors.transparent,
                            child: const Center(
                                child: Text('Image Placeholder',
                                    style: TextStyle(color: Colors.grey))))),
                    const SizedBox(height: 10),
                    // Start Calling Button (Similar to Screen 5)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.call,
                                color: Colors.green, size: 30),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/call_setup');
                              },
                              child: const Text('Star Calling Now',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Floating Action Button in the middle
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Main Action (e.g., Start/Stop Call)
        },
        backgroundColor: primaryBlue,
        shape: const CircleBorder(),
        child: const Icon(Icons.play_arrow, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Bottom Navigation Bar
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

// =========================================================================
// 9. Screen 7: Settings
// =========================================================================

class Screen7Settings extends StatelessWidget {
  const Screen7Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Profile Settings Card
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const CircleAvatar(
                    backgroundColor: primaryBlue,
                    child: Icon(Icons.person, color: Colors.white)),
                title: const Text('Profile Settings',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('View and update your personal details'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to Screen 9: Account Menu
                  Navigator.pushNamed(context, '/account_menu');
                },
              ),
            ),
          ),
          
          const Divider(height: 1),
          // App Language
          ListTile(
            leading: const Icon(Icons.language, color: Colors.grey),
            title: const Text('App Language'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate back to Screen 1: Language Screen
              Navigator.pushNamed(context, '/'); 
            },
          ),
          // Change Password
          ListTile(
            leading: const Icon(Icons.lock_outline, color: Colors.grey),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          
          const Divider(height: 1, indent: 16, endIndent: 16),
          
          // CALLING LISTS Section Header
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 5),
            child: Text('CALLING LISTS',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade600, fontSize: 12)),
          ),
          
          // Select Calling List
          ListTile(
            leading: const Icon(Icons.format_list_bulleted_outlined, color: Colors.grey),
            title: const Text('Select Calling List'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text('28/10', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            onTap: () {
              // Navigate to Screen 8: Dashboard Chart
              Navigator.pushNamed(context, '/dashboard_chart');
            },
          ),
          // New List
          ListTile(
            leading: const Icon(Icons.add_box_outlined, color: Colors.grey),
            title: const Text('New List'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// 10. Screen 8: Dashboard with Chart
// =========================================================================

class Screen8DashboardChart extends StatefulWidget {
  const Screen8DashboardChart({super.key});

  @override
  _Screen8DashboardChartState createState() => _Screen8DashboardChartState();
}

class _Screen8DashboardChartState extends State<Screen8DashboardChart> {
  List<dynamic> lists = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLists();
  }

  void fetchLists() async {
    try {
      final data = await ApiService.getLists(
          '68626f9497757cb741f449b0', 'dhrubo@yopmail.com');
      setState(() {
        lists = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: lists.length,
              itemBuilder: (context, index) {
                final list = lists[index];
                return ListTile(
                  title: Text(list['name'] ?? 'No Name'),
                  subtitle: Text('ID: ${list['_id']}'),
                  onTap: () async {
                    // Fetch list details on tap
                    final details = await ApiService.getListDetails(
                        list['_id'], 'dhrubo@yopmail.com');
                    print(details);
                    // You can navigate to a detail screen here
                  },
                );
              },
            ),
    );
  }
}


// =========================================================================
// 11. Screen 9: Account Menu
// =========================================================================

class Screen9AccountMenu extends StatelessWidget {
  const Screen9AccountMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // User Info Header
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: primaryBlue,
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Swati Sharma',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('swati.sharma@example.com',
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                  ],
                ),
              ],
            ),
          ),
          
          const Divider(height: 10, thickness: 10, color: Color(0xFFE0E0E0)),
          
          // Menu Options
          _buildMenuTile(context, Icons.person_outline, 'Edit Profile', () {}),
          _buildMenuTile(context, Icons.subscriptions_outlined, 'Subscription', () {}),
          _buildMenuTile(context, Icons.support_agent, 'Support', () {}),
          _buildMenuTile(context, Icons.star_border, 'Rate Us', () {}),
          
          const Divider(height: 1, indent: 16, endIndent: 16),
          
          _buildMenuTile(context, Icons.exit_to_app, 'Logout', () {
            // Logout logic, navigate to Login screen
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          }, iconColor: Colors.red),
        ],
      ),
    );
  }

  Widget _buildMenuTile(BuildContext context, IconData icon, String title, VoidCallback onTap, {Color iconColor = Colors.grey}) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
