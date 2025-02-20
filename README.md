
# Stream Lab

**Experience the power of real-time communication.**

Stream Lab is a cross-platform application designed to streamline testing and experimentation with Socket.IO connections and events. It is built using **Flutter**, enabling support for web, mobile, and desktop platforms. By leveraging the **Flutter Bloc architecture** for state management and **Hive** for local data storage, Stream Lab empowers developers to create and manage multiple Socket.IO connections seamlessly across platforms.

## Key Features

- **Multiple Connection Support**: Create and manage multiple Socket.IO connections, saving them locally for quick access across platforms.
- **Custom Connection Configurations**: Easily configure connection names, server URLs, headers, and authentication data.
- **Event Emitters and Listeners**: Add, edit, and manage multiple event emitters and listeners to test various real-time scenarios.
- **Flexible Data Handling**: Edit event emitters with support for JSON, Text, or no data, ensuring comprehensive testing.
- **Enable/Disable Listeners**: Focus testing on specific interactions by toggling event listeners.
- **Cross-Platform Support**: Available for web, mobile, and desktop, providing developers with flexibility in testing across environments.

## Why Stream Lab?

Developers often face challenges testing various connection scenarios and event emissions when working with Socket.IO. Stream Lab resolves these challenges with:

- A **user-friendly interface** for seamless navigation and setup.
- **Efficient data management** using Hive for local storage.
- Comprehensive testing features for real-time communication across multiple platforms.

## How It Works

1. **Set Up Connections**

   - Define connection names and server URLs.
   - Configure headers and authentication data.

2. **Manage Events**

   - Add emitters to simulate events with custom data.
   - Set up listeners to monitor real-time events.

3. **Experiment & Test**
   - Enable or disable listeners to test specific scenarios.
   - Validate and refine your Socket.IO implementation with ease.

## Vision

Stream Lab simplifies the complexities of working with Socket.IO by offering a comprehensive, developer-friendly platform. Its innovative approach enables:

- Effortless experimentation with real-time connections.
- Detailed debugging for stable and efficient implementations.
- Quick switching between multiple saved configurations.
- Flexibility to test across different platforms.

## Built With

- **Flutter**: For a robust, cross-platform application supporting web, mobile, and desktop.
- **Flutter Bloc**: Ensures responsive and interactive state management.
- **Hive**: Provides lightweight and efficient local data storage.

## Accessibility & Optimization

Stream Lab is designed with a commitment to:

- **Accessibility**: Intuitive layouts and tooltips for effortless navigation.
- **Performance**: Optimized to handle multiple connections and events smoothly.

## Installation

Follow these steps to set up Stream Lab on your local machine:

1. Clone the repository:

   ```bash
   git clone https://github.com/vishnucprasad/stream_lab
   cd stream_lab
   ```

2. Install Flutter dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app on your preferred platform:

   For **Web**:
   ```bash
   flutter run -d chrome
   ```

   For **Desktop (Linux/Windows)**:
   ```bash
   flutter run -d <target-platform>
   ```

   Ensure you have Flutter set up for the desired platform. Refer to [Flutter’s documentation](https://docs.flutter.dev/get-started) for more details.

## Contributing

We welcome contributions! Please check out the [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines on how to get started.

## Issues

If you encounter any issues or have suggestions for improvements, please refer to the [Issues](./ISSUES.md) section.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
