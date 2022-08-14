import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/repository_impl/auth_repository_impl.dart';
import '../../../../../helper/flushbar.dart';
import '../../../../core/app.dart';
import '../../../../widget/block_loader.dart';
import 'bloc.dart';

class AuthRegistrationPage extends StatefulWidget {
  const AuthRegistrationPage({Key? key}) : super(key: key);

  @override
  State<AuthRegistrationPage> createState() => _AuthRegistrationPageState();
}

class _AuthRegistrationPageState extends State<AuthRegistrationPage> {
  late AuthRegisterBloc _authRegisterBloc;

  late bool isObscurePassword;
  late bool isObscureRePassword;

  @override
  void initState() {
    _authRegisterBloc = AuthRegisterBloc(
      repository: AuthRepositoryImpl(
        client: App.main.clientAuth,
        fcmToken: App.main.firebaseToken,
      ),
    );

    isObscurePassword = true;
    isObscureRePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authRegisterBloc,
      child: BlocListener<AuthRegisterBloc, AuthRegisterState>(
        listener: (context, state) async {
          if (state is AuthRegisterLoadingState) {
            FocusScope.of(context).requestFocus(FocusNode());
            showDialog(
              context: context,
              builder: (_) => BlockLoader(),
            );
          } else if (state is AuthRegisterFailedState) {
            Navigator.of(context).pop();
            showFlushbar(context, state.message, isError: true);
          } else if (state is AuthRegisterGoState) {
            try {
              await Future.delayed(Duration(seconds: 1));
              Modular.to.navigate('/auth/login');
            } catch (e) {
              Navigator.of(context).pop();
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Form(
            key: _authRegisterBloc.formKey,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 150.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Username",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller:
                                        _authRegisterBloc.usernameController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input username',
                                      hintStyle: TextStyle(
                                        fontSize: 16.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'username is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller:
                                        _authRegisterBloc.emailController,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input email',
                                      hintStyle: TextStyle(
                                        fontSize: 16.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'email is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Password",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller:
                                        _authRegisterBloc.passwordController,
                                    obscureText: isObscurePassword,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Input password',
                                      hintStyle: TextStyle(
                                        fontSize: 16.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 14.w, minHeight: 16.h),
                                      suffixIcon: isObscurePassword
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isObscurePassword = false;
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: Color.fromRGBO(
                                                    120, 125, 131, 1),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isObscurePassword = true;
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove_red_eye,
                                                color: Color.fromRGBO(
                                                    120, 125, 131, 1),
                                              ),
                                            ),
                                      suffixIconConstraints: BoxConstraints(
                                          minWidth: 14.w, minHeight: 16.h),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'password is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Text(
                                      "Re-Password",
                                      style: TextStyle(
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller:
                                        _authRegisterBloc.rePasswordController,
                                    obscureText: isObscurePassword,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                      ),
                                      hintText: 'Retype password',
                                      hintStyle: TextStyle(
                                        fontSize: 16.sp,
                                        color: Color.fromRGBO(120, 125, 131, 1),
                                      ),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 14.w, minHeight: 16.h),
                                      suffixIcon: isObscureRePassword
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isObscureRePassword = false;
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: Color.fromRGBO(
                                                    120, 125, 131, 1),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isObscureRePassword = true;
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove_red_eye,
                                                color: Color.fromRGBO(
                                                    120, 125, 131, 1),
                                              ),
                                            ),
                                      suffixIconConstraints: BoxConstraints(
                                          minWidth: 14.w, minHeight: 16.h),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 150, 213, 1),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'password is required.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25.h),
                            Row(
                              children: [
                                Text(
                                  "You have account?",
                                  style: TextStyle(
                                    color: Color.fromRGBO(120, 125, 131, 1),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Modular.to.navigate('/auth/login');
                                  },
                                  child: Text("Login"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35.h),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Color.fromRGBO(43, 49, 56, 1),
                          padding: EdgeInsets.symmetric(
                            vertical: 20.h,
                            horizontal: 16.w,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith(
                                (states) => EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 10.w,
                                ),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r)),
                              ),
                            ),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              _authRegisterBloc.register();
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
