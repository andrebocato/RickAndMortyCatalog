# Rick and Morty Catalog

## Description
* "Rick and Morty Catalog" consists in a simple application with a list of the Rick And Morty TV show characters and detailed information about each one.
* Upon selection of a character, the users are sent to a detailed view that contains a character avatar, its name, location of origin among other data provided by the API.
* If users want to save a character card, a "Favorite" button is tapped and the character is saved on the "Favorites" tab.
* The Favorites tab contains all the characters a user has saved as favorite, ordered by ID.
* The settings tab contains a "Delete all" button that clears all Favorite characters, emptying the "Favorites" tab.

## Objectives
* This app was designed to be the final project for Udacity's iOS Developer Nanodegree.
* It was programmed in Swift 5 and uses MVC architecture.

## API and Persistence
* The data used in the app comes from the [Rick And Morty API](https://rickandmortyapi.com) and it is persisted through [Realm](https://realm.io).
* [CocoaPods](https://cocoapods.org) needs to be installed in order to use Realm.
* The documentation and guide for utilizing those tools can be found on their websites, linked above.

## Known issues
* LoadingView on characters list not centered.
* LoadingViews and EmptyViews do not change according to themes.

## TODOs
* Fix known bugs.
* Add long gesture recognizers for characters list and favorites.
* Add haptic feedback.
* Add loading animation in pagination.
* Add theme changes to navigation and tab bars.
