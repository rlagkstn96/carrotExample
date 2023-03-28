import 'package:carrotexample/constants/common_size.dart';
import 'package:carrotexample/constants/shared_pref_keys.dart';
import 'package:carrotexample/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final inputBorder =
      OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

  TextEditingController _phoneNumberEditingController =
      TextEditingController(text: "010");

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  String? _verificationId;
  int? _forceResendingToken;

  static const Duration duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        return IgnorePointer(
          ignoring: _verificationStatus == VerificationStatus.verifying,
          child: Form(
            key: _formkey,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text('전화번호 로그인',
                    style: Theme.of(context).appBarTheme.titleTextStyle),
              ),
              body: Padding(
                padding: EdgeInsets.all(common_padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        ExtendedImage.asset(
                          'assets/imgs/padlock.png',
                          width: size.width * 0.15,
                          height: size.width * 0.15,
                        ),
                        SizedBox(width: common_small_padding),
                        Text(
                            '토마토마켓은 휴대폰 번호로 가입해요.\n번호는 안전하게 보관되며\n어디에도 공개되지 않아요.',
                            style: Theme.of(context).textTheme.subtitle1)
                      ],
                    ),
                    SizedBox(height: common_padding),
                    AnimatedContainer(
                      duration: duration,
                      child: TextFormField(
                        controller: _phoneNumberEditingController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          MaskedInputFormatter("000 0000 0000")
                        ],
                        decoration: InputDecoration(
                          focusedBorder: inputBorder,
                          border: inputBorder,
                        ),
                        validator: (phoneNumber) {
                          if (phoneNumber != null && phoneNumber.length == 13) {
                            //success
                            return null;
                          } else {
                            //error
                            return '전화번호가 잘못 입력 되었습니다.';
                          }
                        },
                      ),
                    ),
                    SizedBox(height: common_small_padding),
                    TextButton(
                        onPressed: () async {
                          if(_verificationStatus == VerificationStatus.codeSending) return;
                          _getAddress();
                          if (_formkey.currentState != null) {
                            bool passed = _formkey.currentState!.validate();
                            if (passed) {
                              String phoneNum =
                                  _phoneNumberEditingController.text;
                              phoneNum = phoneNum.replaceAll(' ', '');
                              phoneNum = phoneNum.replaceFirst('0', '');

                              FirebaseAuth auth = FirebaseAuth.instance;

                              setState(() {
                                _verificationStatus =
                                    VerificationStatus.codeSending;
                              });
                              await auth.verifyPhoneNumber(
                                phoneNumber: '+82$phoneNum',
                                forceResendingToken: _forceResendingToken,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) async {
                                  await auth.signInWithCredential(credential);
                                  logger.d('로그인 확인 : $credential');
                                },
                                verificationFailed:
                                    (FirebaseAuthException error) {
                                  logger.d(error.message);
                                  setState(() {
                                    _verificationStatus =
                                        VerificationStatus.none;
                                  });
                                },
                                codeSent: (String verificationId,
                                    int? forceResendingToken) async {
                                  setState(() {
                                    _verificationStatus =
                                        VerificationStatus.codeSent;
                                  });

                                  _verificationId = verificationId;
                                  _forceResendingToken = forceResendingToken;
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                              );
                            }
                          }
                        },
                        child: (_verificationStatus ==
                                VerificationStatus.codeSending)
                            ? SizedBox(
                                height: 26,
                                width: 26,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text('인증문자 발송')),
                    AnimatedOpacity(
                        opacity:
                            (_verificationStatus == VerificationStatus.none)
                                ? 0
                                : 1,
                        duration: duration,
                        curve: Curves.easeInOut,
                        child: SizedBox(height: common_padding)),
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: getVerificationHeight(_verificationStatus),
                      curve: Curves.easeInOut,
                      child: TextFormField(
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [MaskedInputFormatter("000000")],
                        decoration: InputDecoration(
                          focusedBorder: inputBorder,
                          border: inputBorder,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                        duration: Duration(seconds: 1),
                        height:
                            getVerificationButtonHeight(_verificationStatus),
                        curve: Curves.easeInOut,
                        child: TextButton(
                            onPressed: () {
                              attemptVerify();
                            },
                            child: (_verificationStatus ==
                                    VerificationStatus.verifying)
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text('인증'))),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double getVerificationHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSending:
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 60 + common_small_padding;
    }
  }

  double getVerificationButtonHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSending:
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 48;
    }
  }

  void attemptVerify() async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });
    await Future.delayed(Duration(seconds: 1));

    String smsCode = '123456';
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: _codeController.text);

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      logger.d('verification failed!!');
      SnackBar snackbar = SnackBar(content: Text('입력하신 코드가 틀렸습니다.'),);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });
  }

  _getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString(SHARED_ADDRESS) ?? "";
    double lat = prefs.getDouble(SHARED_LAT) ?? 0;
    double lng = prefs.getDouble(SHARED_LNG) ?? 0;
  }
}

enum VerificationStatus {
  none,
  codeSending,
  codeSent,
  verifying,
  verificationDone
}
