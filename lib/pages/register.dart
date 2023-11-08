import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:happyclean/pages/login.dart';
import 'package:happyclean/controllers/user_controller.dart';
import 'package:happyclean/colors.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController usernameCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 250,
              child: Stack(children: <Widget>[
                Positioned(
                    child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/bg2.png'),
                          fit: BoxFit.fill)),
                ))
              ]),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Daftar Akun",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: scColor)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFieldContainer(
              child: TextField(
                cursorColor: pmColor,
                controller: nameCtr,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.notes_rounded,
                      color: pmColor,
                    ),
                    hintText: "nama",
                    border: InputBorder.none),
              ),
            ),
            TextFieldContainer(
              child: TextField(
                cursorColor: pmColor,
                controller: usernameCtr,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: pmColor,
                    ),
                    hintText: "username",
                    border: InputBorder.none),
              ),
            ),
            TextFieldContainer(
              child: TextField(
                cursorColor: pmColor,
                controller: passwordCtr,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: pmColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(
                        !_showPassword
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: pmColor,
                      ),
                    ),
                    hintText: "passsword",
                    border: InputBorder.none),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: pmColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(300, 40)),
              onPressed: () {
                UserControl.register(
                    name: nameCtr.text,
                    username: usernameCtr.text,
                    password: passwordCtr.text,
                    context: context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: ((context) => Login())));
              },
              child: Text(
                "DAFTAR",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: Text.rich(
                TextSpan(
                  style: TextStyle(color: scColor),
                  children: [
                    const TextSpan(text: "Sudah Punya Akun? "),
                    TextSpan(
                      text: "Login Sekarang",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: pmColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: lightColor, borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}
