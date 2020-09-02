import 'package:flutter/material.dart';
import 'hexcolor.dart';
import 'movie.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final List<Movie> movieList = Movie.getMovies();

  final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I am legend",
    "300",
    "The Wolf of Wall street",
    "Intestellar",
    "Game of thrones",
    "Vikings"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index){
            return Stack(
                children: <Widget> [
                  Positioned(
                      child: movieCard(movieList[index], context)),
                  Positioned(
                    top: 10.0,
                      child: movieImage(movieList[index].images[0]))
                ]
            );
//            return Card(
//              color: Colors.white,
//              child: ListTile(
//                title: Text(movieList[index].title),
//                subtitle: Text("${movieList[0].title}"),
//                leading: CircleAvatar(
//                  child: Container(
//                    width: 200,
//                    height: 200,
//                    decoration: BoxDecoration(
//                      image: DecorationImage(
//                          image: NetworkImage(movieList[index].images[0]),
//                      fit: BoxFit.cover
//                      ),
//                      borderRadius: BorderRadius.circular(14.0)
//                    ),
//                  ),
//                ),
//                // onTap: () => debugPrint("Movie name: ${movies[index]}"),
//                onTap: () {
//                  Navigator.push(context, MaterialPageRoute(
//                      builder: (context) => MovieListViewDetails(
//                      movie: movieList[index],)));
//                },
//              ),
//            );
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60.0),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(movie.title, style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.white,
                        ),),
                      ),
                      Text("Rating: ${movie.imdbRating} / 10", style: mainTextStyle()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Released : ${movie.released}", style: mainTextStyle()),
                      Text(movie.runtime, style: mainTextStyle()),
                      Text(movie.rated, style: mainTextStyle()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => MovieListViewDetails(
              movie: movie,)));
    },
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(
        fontSize: 15.0,
        color: Colors.grey
    );
  }

  Widget movieImage(String imageUrl){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl ?? 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fimage.shutterstock.com%2Fimage-photo%2Fbright-spring-view-cameo-island-260nw-1048185397.jpg&imgrefurl=https%3A%2F%2Fwww.shutterstock.com%2Fsearch%2Fscenery&tbnid=PDxUM2uh-Nz6cM&vet=12ahUKEwiQ7eH-tLnrAhVXoUsFHYWzB90QMygCegUIARDRAQ..i&docid=MbJcJfLIhXEbLM&w=475&h=280&q=image&ved=2ahUKEwiQ7eH-tLnrAhVXoUsFHYWzB90QMygCegUIARDRAQ'),
          fit: BoxFit.cover
        ),
      ),
    );
  }

}

class MovieListViewDetails extends StatelessWidget {

  final Movie movie;

  const MovieListViewDetails({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text("Movies"),
      ),
        body: ListView(
          children: <Widget> [
            MovieDetailsThumbnail(thumbnail: movie.images[1],),
            MovieDetailsHeader(movie: movie,),
            HorizontalLine(),
            MovieCast(movie: movie,),
            HorizontalLine(),
            MovieExtraPoster(posters: movie.images,),
          ],
        ),
//      body: Center(
//        child: Container(
//          child: RaisedButton(
//            child: Text("Go back ${this.movie.director}"),
//            onPressed: () {
//              Navigator.pop(context);
//            },
//          ),
//        ),
//      ),
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {

  final String thumbnail;

  const MovieDetailsThumbnail({Key key, this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget> [
        Stack(
          alignment: Alignment.center,
          children: <Widget> [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Icon(Icons.play_circle_outline, size: 100, color: Colors.white,),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
          ),
          height: 80.0,
        ),
      ],
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {

  final Movie movie;

  const MovieDetailsHeader({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget> [
          MoviePoster(poster: movie.images[2].toString()),
          SizedBox(width: 16.0,),
          Expanded(child: MovieDetailsHeader2(movie: movie)),
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {

  final String poster;

  const MoviePoster({Key key, this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10.0));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width/4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class MovieDetailsHeader2 extends StatelessWidget {

  final Movie movie;

  const MovieDetailsHeader2({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Text("${movie.year} . ${movie.genre}".toUpperCase(), style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.indigo,
        ),),
        Text(movie.title, style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 32.0,
        ),),
        Text.rich(TextSpan(style: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w300,
        ),
        children: <TextSpan> [
          TextSpan(
            text:movie.plot
          ),
          TextSpan(
            text: "More...", style: TextStyle(
            color:Colors.cyan
          )
          )
        ]),
        )
      ],
    );
  }
}

class MovieCast extends StatelessWidget {

  final Movie movie;

  const MovieCast({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget> [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Directors", value: movie.director),
          MovieField(field: "Awards", value: movie.awards),
          MovieField(field: "Languages", value: movie.language)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {

  final String field;
  final String value;

  const MovieField({Key key, this.field, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Text("$field : ", style:  TextStyle(
          color: Colors.black38,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),),
        Expanded(
          child: Text(value, style: TextStyle(
            color: Colors.black,
            fontSize: 12.0,
            fontWeight: FontWeight.w300
          ),),
        ),
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieExtraPoster extends StatelessWidget {

  final List<String> posters;

  const MovieExtraPoster({Key key, this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text("More Movie Posters".toUpperCase(), style: TextStyle(
            fontSize: 14.0,
            color: Colors.black26,
          ),),
        ),
        Container(
          height: 200,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(posters[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 8.0,),
              itemCount: posters.length),
        ),
      ],
    );
  }
}
