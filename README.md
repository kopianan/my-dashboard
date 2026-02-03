# Dynamic Dashboard

A Flutter-based dynamic dashboard application that demonstrates clean architecture principles, real-time data integration, and advanced UI patterns including drag-and-drop reordering functionality.

## Features

- **Authentication Flow**: Secure login with session persistence
- **Real-time Data**: Live stock prices via WebSocket connections
- **Weather Integration**: Current weather data with location services
- **News Feed**: Latest news articles from reliable sources
- **Customizable UI**: Drag-and-drop dashboard card reordering 

## Demo Video

Watch the application in action:

[🎥 Dynamic Dashboard Demo Video](https://drive.google.com/file/d/1YwbOUdBiIEDe4gP6hC76Yaug6CiI4Rj2/view?usp=sharing)

*Click the link above to view a comprehensive demonstration of the app's features and functionality.* 

## Architecture

This project follows Clean Architecture principles with the following layers:
- **Presentation**: UI components and state management (BLoC)
- **Application**: Use cases and business logic
- **Domain**: Entities and repository interfaces
- **Infrastructure**: Data sources, models, and external service integrations

## Architecture Decisions

In this project, I decided to adopt Domain-Driven Design (DDD) architecture in Flutter. The primary reason is that DDD allows clearer domain configuration and enables domain sharing across multiple features, which improves scalability and long-term maintainability.

Another advantage of this approach is that it does not introduce excessive boilerplate, while still keeping the codebase highly testable.

For state management, I use Bloc, with Cubit for simpler features. Cubit fits well for lightweight use cases and aligns naturally with the MVVM pattern, allowing a clean separation between presentation and business logic.

For navigation, I use go_router. While Flutter's native Navigator could have been sufficient, go_router has become part of my standard project setup. It simplifies routing configuration and prepares the application for future requirements such as dynamic link handling.

I use Freezed as a code generator for both models and domain entities. Since DDD relies heavily on entities and immutable data structures, Freezed is a suitable choice to reduce boilerplate while ensuring type safety and consistency.

For dependency management, I use get_it combined with injectable to handle dependency injection in a structured and scalable way.

For local data storage, I currently use SharedPreferences, as the data usage in this project is still relatively simple and does not yet require a more complex persistence solution.
 
### BLoC Pattern for State Management
**Decision**: Used BLoC (Business Logic Component) pattern with Cubit for simpler state management scenarios.

**Rationale**:
- **Predictable State**: Unidirectional data flow makes debugging easier
- **Reactive Programming**: Streams provide excellent real-time data handling
- **Testing**: Business logic is completely separated from UI components
- **Performance**: Efficient rebuilding of only affected widgets

**Alternatives Considered**: Provider, Riverpod, GetX
**Why BLoC**: Better suited for complex state management with async operations and real-time data streams.

### Repository Pattern with Abstract Interfaces
**Decision**: Implemented abstract repository contracts with concrete implementations for local and remote data sources.

**Rationale**:
- **Dependency Inversion**: High-level modules don't depend on low-level modules
- **Flexibility**: Can switch between different data sources without changing business logic
- **Offline-First**: Seamless fallback to cached data when network is unavailable
- **Testing**: Easy to mock data sources for unit tests

**Implementation**: Separate repositories for Authentication, News, Weather, and Stock Price data.
 
### WebSocket Implementation for Real-time Data
**Decision**: Custom WebSocket service with connection pooling and automatic reconnection. Here i'm using ws to watch stock price ticker
 
### Freezed for Immutable Data Models
**Decision**: Generated immutable data classes using Freezed package.

**Rationale**:
- **Immutability**: Prevents accidental state mutations and related bugs
- **Performance**: Structural equality and hashCode generation
- **Developer Experience**: Automatic toString, copyWith, and pattern matching
- **Type Safety**: Sealed classes for exhaustive state handling

**Code Generation Trade-off**: Build-time dependency accepted for improved runtime safety and developer productivity.

### SharedPreferences for Local Storage
**Decision**: Used SharedPreferences for session management and user preferences.

**Rationale**:
- **Simplicity**: Key-value storage sufficient for current requirements
- **Cross-platform**: Consistent behavior across iOS and Android
- **Performance**: Fast read/write operations for small data sets
- **Native Integration**: Leverages platform-specific secure storage

**Future Considerations**: May migrate to Hive or SQLite for complex data relationships.

### Go Router for Navigation
**Decision**: Implemented declarative routing with Go Router package.

**Rationale**:
- **Type Safety**: Named routes with compile-time validation 
- **State Management**: Integration with BLoC for navigation state

**Migration Path**: Easier transition to Flutter web and desktop platforms.

### Testing Strategy Architecture
**Decision**: Comprehensive testing pyramid with unit, widget, and integration tests.

**Testing Layers**:
- **Unit Tests**: Repository implementations, BLoCs, and utility functions
- **Widget Tests**: UI components and user interactions 

**Mock Strategy**: Injectable dependencies enable comprehensive mocking without complex setup.
 
## AI Workflow  

This section documents the AI-assisted development process and prompts used to build this application, demonstrating systematic architectural thinking and iterative development.

### Navigation Architecture
*Prompt*: "Design a declarative navigation system using go_router for a Flutter app with authentication guards. Implement route protection that redirects unauthenticated users from dashboard to login, handles deep links gracefully, and provides smooth transitions between splash, login, and dashboard screens. Consider session validation and route state management."

*Rationale*: This prompt focuses on architectural considerations beyond basic routing, emphasizing security, user experience, and state management.

### Repository Pattern Implementation
*Prompt*: "Architect a scalable repository pattern with clear separation of concerns for authentication services. Create abstract repository contracts, implement both local (SharedPreferences) and remote data sources, and design the architecture to support offline-first capabilities with cache invalidation strategies. Include proper error handling and data transformation layers."

*Rationale*: Demonstrates understanding of clean architecture, separation of concerns, and enterprise-level data management patterns.

### Dependency Injection Strategy  
*Prompt*: "Implement a robust dependency injection system that supports testing isolation, environment-specific configurations, and lazy loading. Make SharedPreferences injectable to enable mock implementations during testing and support for different storage backends without tight coupling."

*Rationale*: Shows consideration for testability, maintainability, and flexible architecture design.

### Session Management System
*Prompt*: "Design a comprehensive session management system that handles authentication state persistence, automatic session validation on app lifecycle changes, secure token storage, and graceful session expiration handling. Implement state restoration that survives app restarts and background/foreground transitions."

*Rationale*: Focuses on security, user experience, and complex state management scenarios.

### Data Modeling with Code Generation
*Prompt*: "Generate robust data models using Freezed that implement immutability, equality, serialization, and proper null safety. Create corresponding domain entities with clear boundaries between data transfer objects and business entities. Ensure models support JSON serialization, copying with modifications, and pattern matching for exhaustive state handling."

**Example JSON**: Weather API response structure
*Rationale*: Emphasizes type safety, immutability, and clean separation between data and domain layers.

### News Integration Architecture
*Prompt*: "Build a news data pipeline that integrates with NewsAPI, implements proper error boundaries, supports pagination, caching strategies, and offline fallbacks. Design the architecture to support multiple news sources with a unified interface, and implement proper API key management and rate limiting considerations."

**API Endpoint**: `https://newsapi.org/v2/top-headlines?country=au&apiKey={apiKey}&pageSize=3`
*Rationale*: Demonstrates understanding of external API integration, error handling, and scalable data architectures.

### Real-time Data Streaming
*Prompt*: "Implement a WebSocket-based real-time data streaming system for financial data using best practices for connection management, automatic reconnection, subscription lifecycle management, and memory-efficient data handling. Design the system to handle multiple symbol subscriptions, connection failures, and background/foreground app state changes gracefully."

**WebSocket URL**: `wss://ws.finnhub.io?token={token}`
**Symbols**: BINANCE:BTCUSDT, BINANCE:ETHUSDT, BINANCE:SOLBTC, BINANCE:XRPUSDT
*Rationale*: Shows understanding of complex real-time systems, lifecycle management, and resilient network programming.

 
### Testing Strategy
*Prompt*: "Generate comprehensive unit test suites for repository classes that cover success cases, error scenarios, edge cases, and mock implementations. Implement tests for dependency injection, async operations, stream handling, and state transitions. Ensure tests are maintainable, isolated, and provide meaningful coverage metrics."

*Rationale*: Shows commitment to code quality, maintainability, and professional development practices.

## Getting Started

### Prerequisites
- Flutter SDK 3.38.9 (Channel stable) or higher
- Dart SDK (included with Flutter)
- iOS/Android development environment
  - **Android**: Android SDK version 35.0.1 or higher
  - **iOS**: Xcode 26.0 or higher (for iOS development)
- Chrome browser (for web development)

### Environment Configuration

This project uses environment variables to securely manage API keys and configuration settings. Before running the application, you need to set up your environment variables.

#### 1. Create Environment File
Copy the example environment file:
```bash
cp .env.example .env
```

#### 2. Configure API Keys
Edit the `.env` file with your actual API keys:

```env
# API Keys - Replace with your actual keys
OPENWEATHER_API_KEY=your_openweather_api_key_here
NEWS_API_KEY=your_news_api_key_here
FINNHUB_API_KEY=your_finnhub_api_key_here

# API Base URLs (usually don't need to change)
OPENWEATHER_BASE_URL=https://api.openweathermap.org/data/2.5
NEWS_API_BASE_URL=https://newsapi.org/v2
FINNHUB_WS_URL=wss://ws.finnhub.io

# App Configuration
APP_NAME=Dynamic Dashboard
APP_VERSION=1.0.0
DEBUG_MODE=true
```

#### 3. Get Your API Keys
`.env` will send together in the email.

### Installation
1. Clone the repository
2. Set up environment variables (see above)
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application

### API Keys Required
- **OpenWeather API**: Weather data integration
- **News API**: Latest news articles  
- **Finnhub API**: Real-time stock price data

## Test Users

For testing the authentication functionality, you can use these pre-configured test accounts:

| Email | Password | Name |
|-------|----------|------|
| `test1@example.com` | `password123` | John Doe |
| `test2@example.com` | `password456` | Jane Smith |
| `admin@dashboard.com` | `admin123` | Admin User |
| `demo@demo.com` | `demo123` | Demo User |

### How to Test
1. Launch the application
2. Navigate to the login screen
3. Use any of the above credentials to log in
4. Explore the dashboard functionality

**Note**: These are mock accounts for development and testing purposes only. In a production environment, implement proper user authentication and password security.
 
## Testing
Run the test suite with:
```bash
flutter test
flutter test --coverage
```

## Contributing
This project demonstrates clean architecture and best practices. Contributions should follow the established patterns and include appropriate tests.

## Resources

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)
