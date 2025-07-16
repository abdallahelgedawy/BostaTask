# 🎬 BostaTask - Mini Movie Explorer

BostaTask is an iOS app that displays a list of movies fetched from The Movie Database (TMDb). The user can scroll through movies, view detailed information, and mark favorites.

## 📱 Features

- Infinite scrolling of movies
- Movie details screen (title, poster, release date, overview)
- Favorite toggle per movie
- Pull-to-refresh support
- Error handling with retry option
- Clean and responsive UI using UIKit

---

## 🏗 Architecture

The app is built using **MVVM + Clean Architecture** with **dependency injection** and **async/await** for network handling.

### Layers:

- **Presentation**: UIKit ViewControllers and Views
- **ViewModel**: Bridges the view and domain layer
- **Domain**: Entities and use cases
- **Data**: DTOs and API services
---

## 🧠 Design Decisions & Trade-offs

- **No third-party DI framework**: Chose manual dependency injection for simplicity and testability in a small project.
- **Alamofire instead of URLSession**: To simplify request/response handling and focus on architecture.
- **No Snapshot Testing**: Testing is skipped in this version to focus on architecture and networking.
---


## 🧪 Future Improvements

- Add persistence for favorites
- Unit testing ViewModels
- UI testing
- Localization and accessibility

---

## 🔗 API Reference

- [The Movie Database (TMDb)](https://developers.themoviedb.org/3)

---

## 👨‍💻 Author

Abdallah Elgedawy – [GitHub Profile](https://github.com/abdallahelgedawy)

