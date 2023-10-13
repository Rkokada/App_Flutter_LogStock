// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:logstock/src/constants/text_strings.dart';

// import '../../../controllers/otp_controller.dart';

// class OtpScreen extends StatelessWidget {
//   const OtpScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var otp;
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           padding: EdgeInsets.only(top: 20, left: 30, right: 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 tOtpTitle,
//                 style: GoogleFonts.montserrat(
//                     fontWeight: FontWeight.bold, fontSize: 55),
//               ),
//               Text(
//                 tOtpSubTitle,
//                 style: Theme.of(context).textTheme.headline5,
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Text(
//                 "$tOtpMessage suporte@suporte.com",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               OtpTextField(
//                 numberOfFields: 6,
//                 fillColor: Colors.black.withOpacity(0.1),
//                 filled: true,
//                 onSubmit: (code) {
//                   otp = code;
//                   Get.put(OTPController());

//                   OTPController.instance.verifyOTP(otp);
//                 },
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                     onPressed: () {
//                       return otp;
//                     },
//                     child: Text('Enviar'.toUpperCase())),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
