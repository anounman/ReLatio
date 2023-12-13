

// generateToken(id) async {
//   final responce = await http.post(
//       Uri.parse("https://fefb-202-142-80-18.ngrok.io/steamToken"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "id": id,
//         "Authorization": authToken,
//       }));
//   if (responce.statusCode == 200) {
//     debugPrint("TOKEN:${responce.body}");
//     return responce.body;
//   } else {
//     return "";
//   }
// }
