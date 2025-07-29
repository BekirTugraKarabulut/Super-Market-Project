import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supermarketproject/pages/begenilenler.dart';
import 'package:supermarketproject/pages/bilgilerim.dart';

class Account extends StatefulWidget {

  var username;

  Account({required this.username});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_rounded , color: Colors.white,)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Hesap" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Lottie.asset("asset/UserAccount.json" , width: 200 , height: 200),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Begenilenler(username: widget.username))),
                  child: Container(
                    width: 250,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Beğendiklerim" , style: TextStyle(fontSize: 25),),
                        Icon(Icons.favorite ,color: Colors.red, size: 30,)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Bilgilerim(username: widget.username))),
                  child: Container(
                    width: 250,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: Text("Bilgilerim" , style: TextStyle(fontSize: 25),),
                        ),
                        Icon(Icons.account_circle ,color: Colors.black, size: 30,)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 320),
                child: Text("1987'den beri sizlerle" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
