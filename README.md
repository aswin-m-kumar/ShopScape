# ShopScape 🛍️

ShopScape is a premium, modern e-commerce product listing application built with Flutter. It features a sleek dark-themed interface designed to provide a high-end shopping experience with smooth transitions and an intuitive layout.

## ✨ Features

- **Modern UI/UX**: Aesthetic dark mode design with custom typography (Plus Jakarta Sans & Inter).
- **Product Listing**: Dynamic product grid fetched from a REST API.
- **Detailed View**: Comprehensive product details with high-quality image caching.
- **State Management**: Efficient state handling using the `Provider` pattern.
- **Responsive Design**: Optimized for a seamless experience across different mobile devices.
- **Fast Performance**: Utilizes `cached_network_image` for smooth scrolling and reduced data usage.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Networking**: [http](https://pub.dev/packages/http)
- **Fonts**: [Google Fonts](https://pub.dev/packages/google_fonts)
- **Image Caching**: [Cached Network Image](https://pub.dev/packages/cached_network_image)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Latest stable version)
- Android Studio / VS Code with Flutter extensions
- A mobile emulator or physical device

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/aswin-m-kumar/ShopScape.git
   ```

2. **Navigate to the project directory:**
   ```bash
   cd ShopScape
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── models/         # Data models for products
├── providers/      # State management logic
├── services/       # API and networking services
├── screens/        # UI screens (Splash, Main, Details)
├── widgets/        # Reusable UI components
└── main.dart       # Entry point & theme configuration
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

Developed with ❤️ by [Aswin M Kumar](https://github.com/aswin-m-kumar)
