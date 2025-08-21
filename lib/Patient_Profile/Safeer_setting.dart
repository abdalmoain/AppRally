import 'package:flutter/material.dart';



class Profile_Setting extends StatelessWidget {
  const Profile_Setting({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6A1B9A);

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // رأس الصفحة مع الإيضاح الدائري
            Center(
              child: Container(
                width: 170,
                height: 170,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/images/pic3.png"))
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.15),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.health_and_safety, // مكان الإيضاح (يمكن استبداله بصورة)
                    size: 72,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // البطاقة البيضاء بزوايا دائرية ومحتوى القائمة
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  children: const [
                    _SectionItem(
                      title: 'الحساب',
                      trailingIcon: Icons.person,
                    ),
                    _DividerSpace(),
                    _SectionItem(
                      title: 'List Project',
                      trailingIcon: Icons.list_alt_rounded,
                    ),
                    _DividerSpace(),
                    _SectionItem(
                      title: 'كلمة المرور',
                      trailingIcon: Icons.lock_outline,
                    ),
                    _DividerSpace(),
                    _SectionItem(
                      title: 'الايميل',
                      trailingIcon: Icons.mail_outline,
                    ),
                    _DividerSpace(),
                    _SectionItem(
                      title: 'الاعدادات',
                      trailingIcon: Icons.settings_outlined,
                    ),
                    _DividerSpace(),
                    _SectionItem(
                      title: 'Preferences',
                      trailingIcon: Icons.tune, // أيقونة التفضيلات
                    ),
                    SizedBox(height: 16),
                    _LogoutItem(),
                    SizedBox(height: 80), // فراغ أسفل قبل الشريط
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // الشريط السفلي المخصّص
   
    );
  }
}

class _SectionItem extends StatelessWidget {
  final String title;
  final IconData trailingIcon;

  const _SectionItem({
    required this.title,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      // في RTL السهم يكون على اليسار كما في الصورة
      leading: const Icon(Icons.chevron_left, color: Colors.black54),
      trailing: Icon(trailingIcon, color: Colors.black54),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, color: Colors.black87),
      ),
      onTap: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

class _DividerSpace extends StatelessWidget {
  const _DividerSpace();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsDirectional.only(start: 40),
      child: Divider(height: 8),
    );
  }
}

class _LogoutItem extends StatelessWidget {
  const _LogoutItem();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: const Icon(Icons.chevron_left, color: Colors.black54),
      trailing: const Icon(Icons.logout, color: Color(0xFFE53935)),
      title: const Text(
        'تسجيل الخروج',
        style: TextStyle(
          fontSize: 20,
          color: Color(0xFFE53935),
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}




