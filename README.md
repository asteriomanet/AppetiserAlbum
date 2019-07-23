AppetiserAlbum Project
================

Mobile application AppertiserAlbum for client

## Description
A master-detail application, fetch and display data from given API.

## Persistence
CacheCoordinator class 
- Facilitates the caching data.
- Currently stored in keychain
- Persisted the retrieval of movie list and also the last visited date

## Architecture
- MVVM with decoration/delegation pattern.
- At the very least the separation of concern is demonstrated unlike MVC. 
- It will be an overkill for the design archeticture if we use VIPER in this small project.  
