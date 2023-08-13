class Belonging {
  String title = '';
  int time = 0;
  int quantity = 1;
  String description = '';

  fromData(data) {
    title = data['title'];
    time = data['time'];
    quantity = data['quantity'];
    description = data['description'];

    return this;
  }
}
