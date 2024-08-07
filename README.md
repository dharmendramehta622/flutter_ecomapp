```markdown
# Flutter Project

This is a Flutter project managed using Flutter Version Management (FVM).

## Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [FVM](https://fvm.app/docs/getting_started/installation)

## Getting Started

Follow these steps to set up and run the project:

### 1. Clone the Repository

```bash
git clone https://your_username:your_password@github.com/Hamro-Kura-Kani/flutter_attendo.git
cd flutter_attendo
```

### 2. Install FVM

If you haven't installed FVM yet, you can install it using the following command:

```bash
dart pub global activate fvm
```

### 3. Install Flutter Version

Use FVM to install the Flutter version specified for this project:

```bash
fvm install flutter_version
```

### 4. Use the Specified Flutter Version

Make sure to always use the FVM-managed Flutter version when running commands for this project:

```bash
fvm use flutter_version
```

### 5. Install Dependencies

Install the project dependencies:

```bash
fvm flutter pub get
```

### 6. Run the Project

You can now run the project using the FVM-managed Flutter:

```bash
fvm flutter run
```

## Project Structure

Project's structure is built using MVC architecture.

```plaintext
.
├── lib
│   ├── main.dart
│   └── ...
├── assets
│   ├── images
│   └── ...
├── test
│   └── ...
└── README.md
```

## Contributing

If you would like to contribute to this project, please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature-name`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some feature'`)
5. Push to the branch (`git push origin feature/your-feature-name`)
6. Create a new Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

##  BUILD APP BUNDLE
fvm flutter build appbundle --no-tree-shake-icons
fvm flutter build apk --no-tree-shake-icons
