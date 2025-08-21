import 'package:flutter/material.dart';
import 'package:flutter_application_1/URL.dart' as ApiConfig;
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Step 1 controllers (base data)
  final _usernameCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _passwordConfirmCtrl = TextEditingController();

  // Step 2 controllers (profile data)
  final _cityIdCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _complicationsCtrl = TextEditingController();

  final _pageController = PageController();

  bool _obscurePassword = true;
  bool _submittedStep1 = false;
  bool _submittedStep2 = false;

  final  baseUrl  = "${ApiConfig.baseUrl}/api/v1/user";

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _passwordConfirmCtrl.dispose();
    _cityIdCtrl.dispose();
    _locationCtrl.dispose();
    _ageCtrl.dispose();
    _complicationsCtrl.dispose();
    _pageController.dispose();
    super.dispose();
  }

  bool _validateStep1() {
    return _usernameCtrl.text.isNotEmpty &&
        _firstNameCtrl.text.isNotEmpty &&
        _lastNameCtrl.text.isNotEmpty &&
        _emailCtrl.text.isNotEmpty &&
        _phoneCtrl.text.isNotEmpty &&
        _passwordCtrl.text.length >= 8 &&
        _passwordCtrl.text == _passwordConfirmCtrl.text;
  }

  void _goToNextPage() {
    setState(() => _submittedStep1 = true);
    if (_validateStep1()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _submitFinal() async {
    setState(() => _submittedStep2 = true);

    final body = {
      "base": {
        "username": _usernameCtrl.text,
        "first_name": _firstNameCtrl.text,
        "last_name": _lastNameCtrl.text,
        "email": _emailCtrl.text,
        "phone_number": _phoneCtrl.text,
        "password": _passwordCtrl.text,
        "password_confirmation": _passwordConfirmCtrl.text,
      },
      "role": "patient",
      "profile": {
        "city_id": _cityIdCtrl.text,
        "location": _locationCtrl.text,
        "age": int.tryParse(_ageCtrl.text) ?? 0,
        "complications": _complicationsCtrl.text,
      }
    };

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // نجح التسجيل
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم التسجيل بنجاح ✅")),
        );
        Navigator.pushNamed(context, '/NavigationBarrr', arguments: data);
      } else {
        // فشل التسجيل
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("فشل التسجيل: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ في الاتصال: $e")),
      );
    }
  }

  InputDecoration _fieldDecoration({
    required IconData icon,
    required String hint,
    String? error,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      hintText: hint,
      filled: true,
      fillColor: Colors.deepPurple.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      errorText: error,
    );
  }

  Widget _buildStep1() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'معلومات الحساب',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _usernameCtrl,
              decoration: _fieldDecoration(
                icon: Icons.person,
                hint: 'اسم المستخدم',
                error: _submittedStep1 && _usernameCtrl.text.isEmpty
                    ? 'يرجى إدخال اسم المستخدم'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _firstNameCtrl,
              decoration: _fieldDecoration(
                icon: Icons.badge,
                hint: 'الاسم الأول',
                error: _submittedStep1 && _firstNameCtrl.text.isEmpty
                    ? 'يرجى إدخال الاسم الأول'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameCtrl,
              decoration: _fieldDecoration(
                icon: Icons.badge_outlined,
                hint: 'الاسم الأخير',
                error: _submittedStep1 && _lastNameCtrl.text.isEmpty
                    ? 'يرجى إدخال الاسم الأخير'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailCtrl,
              decoration: _fieldDecoration(
                icon: Icons.email,
                hint: 'البريد الإلكتروني',
                error: _submittedStep1 && _emailCtrl.text.isEmpty
                    ? 'يرجى إدخال البريد الإلكتروني'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: _fieldDecoration(
                icon: Icons.phone,
                hint: 'رقم الموبايل',
                error: _submittedStep1 && _phoneCtrl.text.isEmpty
                    ? 'يرجى إدخال رقم الموبايل'
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordCtrl,
              obscureText: _obscurePassword,
              decoration: _fieldDecoration(
                icon: Icons.lock,
                hint: 'كلمة المرور',
                error: _submittedStep1 && _passwordCtrl.text.length < 8
                    ? 'كلمة المرور قصيرة'
                    : null,
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() =>
                        _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordConfirmCtrl,
              obscureText: true,
              decoration: _fieldDecoration(
                icon: Icons.lock_outline,
                hint: 'تأكيد كلمة المرور',
                error: _submittedStep1 &&
                        _passwordConfirmCtrl.text != _passwordCtrl.text
                    ? 'كلمة المرور غير متطابقة'
                    : null,
              ),
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _goToNextPage,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'معلومات إضافية',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _cityIdCtrl,
              decoration: _fieldDecoration(
                icon: Icons.location_city,
                hint: 'المدينة (ID)',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationCtrl,
              decoration: _fieldDecoration(
                icon: Icons.map,
                hint: 'الموقع',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ageCtrl,
              keyboardType: TextInputType.number,
              decoration: _fieldDecoration(
                icon: Icons.calendar_today,
                hint: 'العمر',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _complicationsCtrl,
              decoration: _fieldDecoration(
                icon: Icons.info,
                hint: 'المضاعفات',
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _goToPreviousPage,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: _submitFinal,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Icon(Icons.check, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.asset('assets/images/pic2.png', fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.40,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(90),
                  topRight: Radius.circular(90),
                ),
              ),
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildStep1(),
                  _buildStep2(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
