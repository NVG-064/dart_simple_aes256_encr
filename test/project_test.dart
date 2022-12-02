import 'package:dart_simple_aes256_encr/person.dart';

void main() {
  List<Person> persons = [];
  Person person = Person("Budi", 0);
  Person person2 = Person("Budi", 1);
  persons.add(person);
  persons.add(person2);
  persons.forEach((element) {
    print(element.id);
  });
}
