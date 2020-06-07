import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './services/usermanagement.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.teal,
      body: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 200),
          Container(
            width: 200,
            child: Image.asset('lib/images/rupeelogin.png'),
          ), SizedBox(height: 20),
          Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration:
                              InputDecoration(border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(25.0),)),
        filled: true,fillColor: Colors.white,hintText: 'Enter PhoneNumber(+91)'),
                          onChanged: (val) {
                            setState(() {
                              this.phoneNo = "+91"+val;
                            });
                          },
                        ),
                      )),
                  codeSent
                      ? Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(25.0),)),
        filled: true,fillColor: Colors.white,hintText: 'Enter OTP'),
                            onChanged: (val) {
                              setState(() {
                                this.smsCode = val;
                              });
                            },
                          ))
                      : Container(),
                      SizedBox(height: 15,),
                  Padding(
                      padding: EdgeInsets.only(left: 120.0, right: 120.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000)),
                        child: RaisedButton(elevation: 5,color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            child: Center(
                                child:
                                    codeSent ? Text('Verify',style: TextStyle(color:Colors.teal,fontSize: 20.0),) : Text('Send OTP',style: TextStyle(color:Colors.teal,fontSize: 20.0),)),
                            onPressed: () {
                              codeSent
                                  ? AuthService()
                                      .signInWithOTP(smsCode, verificationId)
                                  : verifyPhone(phoneNo);
                            }),
                      ))
                ],
              )),SizedBox(height: 250,),
        Text('MyKharcha',style: TextStyle(color:Colors.white70,fontSize: 20,fontWeight: FontWeight.bold),)],
      ),
    ));
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
