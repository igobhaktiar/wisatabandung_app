import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisatabandung/model/tourism_place.dart';

var informationTextStyle = const TextStyle(fontFamily: 'Poppins');

class DetailScreen extends StatelessWidget{

  final TourismPlace place;


  const DetailScreen({Key? key, required this.place }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        if (constraints.maxWidth > 800){
          return DetailWebPage (place: place);
        } else {
          return DetailMobilePage(place: place);
        }
      },
    );
  }
}

class FavoriteButton extends StatefulWidget{
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {

  bool isFavorite = false;

  @override
  Widget build(BuildContext context){
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: (){
        setState(() {
          isFavorite =! isFavorite;
        });
      },
    );
  }
}

class DetailMobilePage extends StatelessWidget{
  final TourismPlace place;

  const DetailMobilePage({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(place.imageAsset),
                    SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                child:  IconButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    icon: const
                                    Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )
                                ),
                              ),
                              const FavoriteButton()
                            ],
                          ),

                        )

                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: Text(place.name,
                    textAlign:  TextAlign.center,
                    style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>    [
                      Column(
                        children: <Widget>[
                          const Icon(Icons.calendar_today),
                          const SizedBox(height: 8.0),
                          Text(
                            place.openDays,
                            style: informationTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const Icon(Icons.access_time),
                          const SizedBox(height: 8.0),
                          Text(
                            place.openTime,
                            style: informationTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const Icon(Icons.monetization_on),
                          const SizedBox(height: 8.0),
                          Text(
                            place.ticketPrice,
                            style: informationTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    place.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16.0, fontFamily: 'Poppins'
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child:
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: place.imageUrls.map((url){
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(url),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}


class DetailWebPage extends StatefulWidget {
  final TourismPlace place;

  const DetailWebPage ({Key? key, required this.place}) : super(key: key);

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 64,
        ),
        child: Center(
          child: SizedBox(
            width: 1440,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                const Text(
                  'Wisata Bandung',
                  style:
                  TextStyle(fontSize: 32.0,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child:
                      Column(
                        children: [
                          ClipRRect(
                            child:  Image.asset(widget.place.imageAsset),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          const SizedBox(height: 16),
                          Scrollbar(
                            controller: _scrollController,
                            child: Container(
                              height: 150,
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ListView(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                children: widget.place.imageUrls.map((url){
                                 return Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(10),
                                     child: Image.network(url),
                                   ),
                                 );
                                }).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                      widget.place.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0,)
                                  ),
                                ),
                                Row (
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        const Icon(Icons.calendar_today),
                                        const SizedBox(width: 8.0),
                                        Text(widget.place.openDays, style: informationTextStyle),
                                      ],
                                    ),
                                    const FavoriteButton(),
                                  ],
                                ), Row(
                                  children: <Widget>[
                                    const Icon(Icons.access_time),
                                    const SizedBox(width: 8.0),
                                    Text(widget.place.openTime, style: informationTextStyle),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.monetization_on),
                                    const SizedBox(width: 8.0),
                                    Text(widget.place.ticketPrice, style: informationTextStyle),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text(
                                    widget.place.description,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
}