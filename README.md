

# Movie DB: Movies Mobile App

This is a mobile app that shows the most popular movies from [The Movie DB](https://www.themoviedb.org/).
<p align="center">
  <img src="https://github.com/mapacheverdugo/moviedb-app/assets/16374322/1c576d9a-4c20-486d-bb9c-c2f47178df7d" width="300" >
  <img src="https://github.com/mapacheverdugo/moviedb-app/assets/16374322/65bd1a22-2e63-44b0-b7a0-05415e909c09" width="300" >
</p>

## Features

- List movies by popularity and rating
- Search movies by title
- See details of a movie
- Local watchlist of movies
- Works offline
- BloC pattern
- Dependency injection with GetIt
- Clean architecture
- Unit tests

## How to run

1. Clone this repository
2. Edit the parameter `apiKey` from the class `TheMovieDbConstants` in the file `lib/core/constants/constants.dart` with your API key from [The Movie DB](https://www.themoviedb.org/)
3. Run `flutter pub get`
4. Run `flutter run`

## Suggested improvements:

- Add the TV series section; on the main page, two additional chips could be created, "Top Rated (TV)" and "Popular (TV)", along with that, it would be necessary to simply replicate the code used to display these categories in movies and convert the MovieEntity in something like MediaEntity and use it for both types of media content.
- Implement unit tests for local data sources: since I used a local database that I had never used before and that has a particular way of writing unit tests.
- Add the rating feature: it would be very similar to the watchlist feature but with fewer use cases since there is no screen to view the rated movies.
- Implement infinite scrolling: since BloCs are supporting pagination with the "Load More" button, all the necessary variables already exist.
