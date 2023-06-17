import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap_staff/app/repositories/auth_repository.dart';
import 'package:toiletmap_staff/app/ui/login/widget/login_appbar.dart';
import 'package:toiletmap_staff/app/utils/constants.dart';

import '../../models/accessToken/access_token.dart';
import '../../utils/Routes.dart';

class LoginMainScreen extends StatefulWidget {
  const LoginMainScreen({Key? key}) : super(key: key);

  @override
  State<LoginMainScreen> createState() => _LoginMainScreenState();
}

class _LoginMainScreenState extends State<LoginMainScreen> {
  final usernameController = TextEditingController();
  String password = "";
  bool isPasswordVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController.addListener(() => setState(() {
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoginAppbar(),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: buildUsername(),
                ),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: buildPassword(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60.h,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppColor.primaryColor1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r))),
                        onPressed: () async {
                          try {
                            if (usernameController.text.isEmpty || password.isEmpty) {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Chú ý'),
                                    content: const Text('Vui lòng nhập đủ thông tin!'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Xác nhận'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              AccessToken? accessToken = await AuthRepository().authLogin(usernameController.text, password);
                              if (accessToken != null ) {
                                Navigator.pushNamed(context, Routes.homeMainScreen);
                              } else {
                                throw Exception();
                              }
                            }
                          } catch (e) {
                            print(e);

                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Chú ý'),
                                  content: const Text('Đã có lỗi xảy ra!'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Xác nhận'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text("Đăng nhập", style: TextStyle(color: Colors.white),)
                    ),
                  ),
                ),
              ],
            ),
          )
        ));
  }

  Widget buildUsername() => TextField(
    controller: usernameController,
    decoration: InputDecoration(
      hintText: 'nhavesinhquan1',
      labelText: 'Tên đăng nhập',
      prefixIcon: Icon(Icons.person),

      suffixIcon: usernameController.text.isEmpty
        ? Container(width: 0,)
      : IconButton(
        icon: Icon(Icons.close),
        onPressed: () => usernameController.clear(),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r)
      ),
    ),
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.done,
  );

  Widget buildPassword() => TextField(
    onChanged: (value) => setState(() => this.password = value),
    onSubmitted: (value) => setState(() => this.password = value),
    decoration: InputDecoration(
      hintText: 'Mật khẩu...',
      labelText: 'Mật khẩu',
      prefixIcon: Icon(Icons.password),

      suffixIcon: IconButton(
        icon: isPasswordVisible
            ? Icon(Icons.visibility_off)
            : Icon(Icons.visibility),
        onPressed: () =>
            setState(() => isPasswordVisible = !isPasswordVisible),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r)
      ),
    ),
    obscureText: isPasswordVisible,
  );
}
