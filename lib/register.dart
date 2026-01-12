import 'package:citywatchapp/API/registerAPi.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // CONTROLLERS
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController conpassword = TextEditingController();

  void _register() {
    final pass = password.text.trim();
    final confirm = conpassword.text.trim();
    final phoneNumber = phone.text.trim();

    // 📱 PHONE NUMBER VALIDATION (10 DIGITS)
    if (phoneNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Phone number must be exactly 10 digits"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 🔒 PASSWORD LENGTH CHECK
    if (pass.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password must be at least 8 characters long"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 🔒 PASSWORD MATCH CHECK
    if (pass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ✅ CALL API ONLY IF VALID
    Registerapi(
      Name: name.text.trim(),
      Phone: phoneNumber,
      Email: email.text.trim(),
      Password: pass,
      context: context,
    );

    debugPrint("REGISTER API CALLED");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // TITLE
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E3A8C),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Register to get started",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),

              const SizedBox(height: 40),

              _inputField(
                controller: name,
                label: "Full Name",
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 18),

              _inputField(
                controller: email,
                label: "Email",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 18),

              _inputField(
                controller: phone,
                label: "Phone Number",
                icon: Icons.phone_outlined,
                keyboard: TextInputType.phone,
              ),

              const SizedBox(height: 18),

              _inputField(
                controller: password,
                label: "Password",
                icon: Icons.lock_outline,
                obscure: true,
                
              ),

              const SizedBox(height: 18),

              _inputField(
                controller: conpassword,
                label: "Confirm Password",
                icon: Icons.lock_reset_outlined,
                obscure: true,
              ),

              const SizedBox(height: 30),

              // REGISTER BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E3A8C),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // LOGIN REDIRECT
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFF2E3A8C),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================
  // REUSABLE INPUT FIELD
  // ===============================
  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
    String? helper,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        helperText: helper,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
