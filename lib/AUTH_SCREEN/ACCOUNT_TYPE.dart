import 'package:flutter/material.dart';
import 'package:flutter_application_1/AUTH_SCREEN/Login.dart';

class ACCOUNT_TYPE extends StatefulWidget {
  const ACCOUNT_TYPE({super.key});

  @override
  State<ACCOUNT_TYPE> createState() => _ACCOUNT_TYPEState();
}

class _ACCOUNT_TYPEState extends State<ACCOUNT_TYPE> {
  String? selectedRole; // ✅ نوع الحساب المختار

  void showConfirmationDialog(String role) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "تأكيد الاختيار",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "هل أنت متأكد من اختيار هذا النوع من الحساب؟",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()),
                );
                setState(() {
                  selectedRole = role; // ✅ نحدث نوع الحساب المختار
                });
              },
              child: const Text(
                "نعم",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE7F6),
      body: Stack(
        children: [
          // الخلفية
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset('assets/images/welcome.png', fit: BoxFit.cover),
          ),

          // الحاوية البيضاء
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),

          // المحتوى الرئيسي
          // الحاوية البيضاء
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.29,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                // لو زاد المحتوى يصير قابل للتمرير
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.01,
                        right: MediaQuery.of(context).size.height * 0.02,

                        // 5% من عرض الشاشة
                        // vertical:  // 2% من ارتفاع الشاشة
                      ),
                      child: Text(
                        "الرجاء اختيار نوع الحساب ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    RoleCard(
                      imagePath: 'assets/images/doctor.png',
                      description: 'طبيب أسنان وتبحث عن حالات مرضى',
                      buttonText: 'طالب',
                      onTap: () {
                        // showConfirmationDialog("طالب");
                      },
                    ),
                    RoleCard(
                      imagePath: 'assets/images/doctor.png',
                      description: 'أم أن أسنانك تؤلمك وتبحث عن معالجة مجانية',
                      buttonText: 'مريض',
                      onTap: () {
                        showConfirmationDialog("مريض");
                      },
                    ),
                    RoleCard(
                      imagePath: 'assets/images/doctor.png',
                      description: 'طبيب أسنان وتبحث عن حالات مرضى',
                      buttonText: 'سفير',
                      onTap: () {
                        // showConfirmationDialog("سفير");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final String imagePath;
  final String description;
  final String buttonText;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.imagePath,
    required this.description,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 80, width: 80),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
