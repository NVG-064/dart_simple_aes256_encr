import 'package:dart_simple_aes256_encr/message.dart';
import 'package:dart_simple_aes256_encr/person.dart';
import 'dart:io';

void main(List<String> arguments) {
  List<Person> persons = [];
  List<Message> messages = [];
  var currentSelect = -1;
  var currentAccount = 0;
  var idUser = 0;

  print("\x1B[2J\x1B[0;0H");
  print('Welcome');
  sleep(Duration(seconds: 3));
  print("\x1B[2J\x1B[0;0H");

  for (;;) {
    print(
        'Hi, ${(currentAccount > 0) ? "${persons[currentAccount - 1].getName(currentAccount)}(${persons[currentAccount - 1].id})." : "Anonymous. Please select account first"}\nHave a nice day\n');
    print('============== MAIN MENU ==============\n');
    print('${(currentSelect == 1) ? "->" : "  "} 1: Send Message');
    print('${(currentSelect == 2) ? "->" : "  "} 2: Read Message\n');
    print('${(currentSelect == 3) ? "->" : "  "} 3: Account\n');
    print('${(currentSelect == 0) ? "->" : "  "} 0: Exit\n');
    print('Select: ');
    var input = stdin.readLineSync();

    switch (input) {
      case '1':
        currentSelect = 1;
        int? to;
        Message message = Message();
        message.initialize();
        // messages.add(message);

        for (;;) {
          print("\x1B[2J\x1B[0;0H");
          print('Enter User ID to send the message');
          to = int.parse(stdin.readLineSync()!);
          if (to <= 0 || to > persons.length || to == currentAccount) {
            to = currentAccount;
            print('Please enter a valid User ID');
          } else {
            break;
          }
        }

        print('Write your message below:');
        var userMessage = stdin.readLineSync()!;
        message.tempMessage = userMessage;

        // message.generateMac(message.secretKey, message.tempMessage.codeUnits);
        // message.doEncrypt(message.secretKey, message.tempMessage.codeUnits,
        //     message.nonce, message.cipherAlgorithm);
        message.sendMessage(message.tempMessage, currentAccount, to);
        messages.add(message);

        // For debugging purpose
        print(messages[currentAccount].mac.bytes);
        print(messages[currentAccount].tempMessage);
        messages[currentAccount].extractSecretKey();
        print(messages[currentAccount].macAlgorithm);
        print(messages[currentAccount].mac);
        print(messages[currentAccount].cipherAlgorithm);
        print(messages[currentAccount].from);
        print(messages[currentAccount].to);
        print(messages[currentAccount].tempMac);
        print(persons[currentAccount].secretKey);

        break;

      case '2':
        currentSelect = 2;
        break;

      case '3':
        currentSelect = 3;
        bool state = true;

        while (state == true) {
          print("\x1B[2J\x1B[0;0H");
          print(
        'Hi, ${(currentAccount > 0) ? "${persons[currentAccount - 1].getName(currentAccount)}(${persons[currentAccount - 1].id})." : "Anonymous. Please select account first"}\nHave a nice day\n');
          print('============== ACCOUNT ==============\n');
          print('1: Show All Account\n');
          print('2: Add Account');
          print('3: Select Account\n');
          print('0: Exit');
          input = stdin.readLineSync();

          switch (input) {
            case '1':
              if (persons.isNotEmpty) {
                print("\x1B[2J\x1B[0;0H");
                print('ID: NAME\n=========================');
                persons.forEach((element) {
                  print('${element.id}: ${element.getName(element.id)}');
                });
              } else {
                print("\x1B[2J\x1B[0;0H");
                print('Please add account first');
              }
              sleep(Duration(seconds: 3));
              break;

            case '2':
              idUser++;
              print("\x1B[2J\x1B[0;0H");
              print('Enter the name: ');
              var name = stdin.readLineSync();
              Person person = Person(name, idUser);
              persons.add(person);
              break;

            case '3':
              print("\x1B[2J\x1B[0;0H");
              print('Select User ID: ');

              // Exception still unhandled
              int? thisCurrentAccount = int.parse(stdin.readLineSync()!);
              if (thisCurrentAccount <= 0 ||
                  thisCurrentAccount > persons.length) {
                thisCurrentAccount = currentAccount;
                print('Please enter a valid User ID');
              } else {
                currentAccount = thisCurrentAccount;
              }
              sleep(Duration(seconds: 2));
              break;

            case '0':
              state = false;
              break;

            default:
              break;
          }
        }
        break;

      case '0':
        print("\x1B[2J\x1B[0;0H");
        print('Thank you');
        sleep(Duration(seconds: 3));
        exit(0);
      default:
        break;
    }

    print("\x1B[2J\x1B[0;0H");
  }
}
