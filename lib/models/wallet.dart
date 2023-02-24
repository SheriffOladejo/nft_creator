class Wallet {
  int id;
  String password;
  String address;
  String seed;

  Wallet({
    this.id,
    this.password,
    this.address,
    this.seed
  });

  factory Wallet.fromMap(Map<dynamic, dynamic> map) {
    return Wallet(
      id: map['id'] ?? '',
      password: map['title'] ?? '',
      address: map['password'] ?? '',
      seed: map['twenty_four'] ?? '',
    );
  }

  @override
  int compareTo(other) {
    var a = id;
    var b = other.id;

    if(b > a){
      return 1;
    }
    else if(a == b){
      return 0;
    }
    else{
      return -1;
    }
  }

}