import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:happyclean/components/navbar.dart';
import 'package:happyclean/controllers/user_controller.dart';
import 'package:happyclean/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              height: 350,
              child: Stack(children: <Widget>[
                Positioned(
                    child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/bg1.png'),
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
                "Masuk",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F908B))),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFieldContainer(
              child: TextField(
                cursorColor: pmColor,
                controller: usernameCtr,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color(0xFF50CDD1),
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
                    icon: const Icon(
                      Icons.lock,
                      color: Color(0xFF50CDD1),
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
                  backgroundColor: const Color(0xFF50CDD1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(300, 40)),
              onPressed: () {
                UserControl.login(
                    username: usernameCtr.text,
                    password: passwordCtr.text,
                    context: context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: ((context) => const Navbar())));
              },
              child: Text(
                "MASUK",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/register');
              },
              child: Text.rich(
                TextSpan(
                  style: TextStyle(color: scColor),
                  children: [
                    const TextSpan(text: "Belum Punya Akun? "),
                    TextSpan(
                      text: "Daftar Sekarang",
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
          color: const Color(0xFFBFFCFF),
          borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}
