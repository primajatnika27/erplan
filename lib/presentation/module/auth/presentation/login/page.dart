import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/repository_impl/auth_repository_impl.dart';
import '../../../../../helper/flushbar.dart';
import '../../../../core/app.dart';
import '../../../../widget/block_loader.dart';
import 'bloc.dart';

class AuthLoginPage extends StatefulWidget {
  @override
  _AuthLoginPageState createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  late AuthLoginBloc _authLoginBloc;

  late bool isObscurePassword;

  @override
  void initState() {
    _authLoginBloc = AuthLoginBloc(
      repository: AuthRepositoryImpl(
        client: App.main.clientAuth,
        fcmToken: App.main.firebaseToken,
      ),
    );

    isObscurePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authLoginBloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthLoginBloc, AuthLoginState>(
            bloc: _authLoginBloc,
            listener: (context, state) async {
              if (state is AuthLoginLoadingState) {
                FocusScope.of(context).requestFocus(FocusNode());
                showDialog(
                  context: context,
                  builder: (_) => BlockLoader(),
                );
              } else if (state is AuthLoginFailedState) {
                Navigator.of(context).pop();
                showFlushbar(context, state.message);
              } else if (state is AuthLoginGoState) {
                App.main.accessToken = state.accessToken;
                try {
                  Modular.to.pushReplacementNamed('/home/');
                } catch (e) {
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(30, 37, 43, 1),
          ),
          backgroundColor: Color.fromRGBO(30, 37, 43, 1),
          body: Form(
            key: _authLoginBloc.formKey,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 250.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 20.w),
                                  child: Text(
                                    "Username",
                                    style: TextStyle(
                                      color: Color.fromRGBO(120, 125, 131, 1),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _authLoginBloc.phoneController,
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
                                Padding(
                                  padding: EdgeInsets.only(right: 20.w),
                                  child: Text(
                                    "Password",
                                    style: TextStyle(
                                      color: Color.fromRGBO(120, 125, 131, 1),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        _authLoginBloc.passwordController,
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
                                Text(
                                  "Haven't registered yet?",
                                  style: TextStyle(
                                    color: Color.fromRGBO(120, 125, 131, 1),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Modular.to.pushNamed('/auth/register');
                                  },
                                  child: Text("Register"),
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
                              _authLoginBloc.signIn();
                            },
                            child: Text(
                              'Sign In',
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
