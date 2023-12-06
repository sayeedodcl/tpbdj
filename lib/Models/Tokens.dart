class Tokens{
   final String tokenss;



  Tokens(this.tokenss);

  Tokens.fromJson(Map<String, dynamic> json)
      : tokenss = json['token'];
    


}