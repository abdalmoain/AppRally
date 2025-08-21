import 'package:flutter/material.dart';
import 'package:flutter_application_1/Patient_Profile/Safeer_setting.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "يزن";
  String lastName = "الأحمد";
  double rating = 4.5; // تقييم الدكتور
  String aboutMe =
      'دكتور مختص في تقديم الرعاية الطبية بخبرة تتجاوز 10 سنوات، شغوف بخدمة المرضى وتقديم أفضل الحلول العلاجية، وأسعى دائمًا لمواكبة أحدث التطورات في مجال الطب.';

  // تعديل النبذة
  void _editAbout() {
    TextEditingController controller = TextEditingController(text: aboutMe);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("تعديل النبذة"),
          content: TextField(
            controller: controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "أدخل النبذة الجديدة...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // إغلاق بدون حفظ
              },
              child: Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  aboutMe = controller.text; // حفظ النبذة الجديدة
                });
                Navigator.pop(context);
              },
              child: Text("حفظ"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // صورة البروفايل
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/pic3.png'),
              ),
            ),
            SizedBox(height: 20),
            // الاسم
            Text(
              ' الدكتور $name $lastName',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'سفير عيادة ',
              style: TextStyle(color: Colors.deepPurple, fontSize: 16),
            ),
            SizedBox(height: 30),

            // الإحصائيات مع التقييم
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn('245', 'الحالات المشخصة'),
                  VerticalDivider(
                    color: Colors.deepPurple,
                    width: 20,
                    thickness: 1,
                  ),
                  _buildRatingColumn(rating, 'التقييم'),
                  VerticalDivider(
                    color: Colors.deepPurple,
                    width: 20,
                    thickness: 1,
                  ),
                  _buildStatColumn('516', 'Lessons'),
                ],
              ),
            ),

            SizedBox(height: 30),
            // أزرار الأكشن
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'تعديل البروفايل',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.deepPurple),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'مواعيدي',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),
            // أيقونات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconButton(Icons.settings, 'الاعدادات',(){
                  Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => Profile_Setting()),
      );
                }),
                _buildIconButton(Icons.bookmark_border, 'Saved',(){}),
                _buildIconButton(Icons.share, 'Share',(){}),
              ],
            ),

            SizedBox(height: 40),
            // قسم النبذة
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      'نبذة ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: _editAbout,
                      icon: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    aboutMe,
                    style: TextStyle(color: Colors.white, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.deepPurple, fontSize: 14)),
      ],
    );
  }

  Widget _buildRatingColumn(double rating, String label) {
    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.5;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < fullStars; i++)
              Icon(Icons.star, color: Colors.amber, size: 20),
            if (halfStar) Icon(Icons.star_half, color: Colors.amber, size: 20),
            for (int i = 0; i < (5 - fullStars - (halfStar ? 1 : 0)); i++)
              Icon(Icons.star_border, color: Colors.amber, size: 20),
          ],
        ),
        SizedBox(height: 4),
        Text(
          '$rating',
          style: TextStyle(color: Colors.deepPurple, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, String label,VoidCallback onTap) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 28),
          color: Colors.deepPurple,
          onPressed: onTap
        ),
        Text(label, style: TextStyle(color: Colors.deepPurple, fontSize: 12)),
      ],
    );
  }
}
