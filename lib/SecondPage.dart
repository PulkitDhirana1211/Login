import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:exam/ThirdPage.dart';
class SecondP extends StatefulWidget {
  const SecondP({Key? key}) : super(key: key);

  @override
  _SecondPState createState() => _SecondPState();
}

class _SecondPState extends State<SecondP> {
  bool a=false;
  bool b=false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId="";
  @override
  void initState() {
    super.initState();
  }

  void verifyPhoneNumber() async {
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackBar('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };
    PhoneCodeSent codeSent=(String verificationId, int? resendToken)async{
      showSnackBar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };
/*    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showSnackBar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };
    */
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumberController.text,
          timeout: const Duration(seconds: 5),
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout, verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {  });
      a=true;
    } catch (e) {
      showSnackBar("Failed to Verify Phone Number: $e");
    }
  }
  void showSnackBar(String message) {
    // ignore: deprecated_member_us, deprecated_member_use
    final snackBar = SnackBar(content: Text(message));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );
      final User? user = (await _auth.signInWithCredential(credential)).user;
      showSnackBar("Successfully signed in. Now Click on Sign in to continue.");
      a=true;
      b=true;
    } catch (e) {
      showSnackBar("Failed to sign in. Please verify phone number first" + e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Phone Authentication"),
        ),
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Padding(padding: const EdgeInsets.all(8),
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(labelText: 'Phone number (+xx xxx-xxx-xxxx)'),
                  ),

                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 18),
                    child: ElevatedButton(
                      child: Text("Verify Number"),
                      onPressed: () async {
                        verifyPhoneNumber();
                      },
                    ),
                  ),
                  TextFormField(
                    controller: _smsController,
                    decoration: const InputDecoration(labelText: 'Verification code'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () async {
                          signInWithPhoneNumber();
                        },
                        child: Text("Verify")
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: Text("Sign in"),
                      onPressed: () async{
    if(b){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Sign In")));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Verify Phone Number first")));
    }
    //  Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => BottomNavigationBarController() ));
    //}
    //else
    //{
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Verify Phone Number first")));
    //}
                      //  if(b){
                        //  Navigator.of(context).push(MaterialPageRoute(
                           //   builder: (context) => BottomNavigationBarController() ));
                        //}
                        //else
                        //{
                          //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Verify Phone Number first")));
                        //}
                      },
                    ),
                  )
                ],
              )
          ),
        )
    );
  }

}
