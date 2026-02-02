# Dynamic Dashboard

A Flutter-based dynamic dashboard application that demonstrates clean architecture principles, real-time data integration, and advanced UI patterns including drag-and-drop reordering functionality.

## Features

- **Authentication Flow**: Secure login with session persistence
- **Real-time Data**: Live stock prices via WebSocket connections
- **Weather Integration**: Current weather data with location services
- **News Feed**: Latest news articles from reliable sources
- **Customizable UI**: Drag-and-drop dashboard card reordering
- **Clean Architecture**: Separation of concerns with repository pattern
- **State Management**: BLoC pattern for predictable state management
- **Dependency Injection**: Injectable dependencies for testability

## Architecture

This project follows Clean Architecture principles with the following layers:
- **Presentation**: UI components and state management (BLoC)
- **Application**: Use cases and business logic
- **Domain**: Entities and repository interfaces
- **Infrastructure**: Data sources, models, and external service integrations

## Architectural Decisions

This section documents the key architectural decisions made during development and the rationale behind each choice.

### Clean Architecture Implementation
**Decision**: Adopted Clean Architecture with strict layer separation and dependency inversion.

**Rationale**: 
- **Testability**: Each layer can be tested in isolation with mocked dependencies
- **Maintainability**: Changes in external APIs or UI don't affect business logic
- **Scalability**: New features can be added without modifying existing code
- **Team Collaboration**: Clear boundaries enable parallel development across different layers

**Trade-offs**: Increased initial complexity and boilerplate code, but significantly improved long-term maintainability.

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

### Dependency Injection with Injectable
**Decision**: Used Injectable package with GetIt service locator for dependency management.

**Rationale**:
- **Loose Coupling**: Components depend on abstractions, not concrete implementations
- **Testing Isolation**: Easy to inject mocks and test doubles
- **Configuration Management**: Environment-specific implementations
- **Performance**: Lazy loading and singleton patterns where appropriate

**Alternative**: Manual dependency injection was rejected due to complexity and error-proneness.

### WebSocket Implementation for Real-time Data
**Decision**: Custom WebSocket service with connection pooling and automatic reconnection.

**Rationale**:
- **Real-time Requirements**: Stock prices need instant updates for accurate display
- **Resource Efficiency**: Single connection handles multiple symbol subscriptions
- **Resilience**: Automatic reconnection handles network interruptions gracefully
- **Lifecycle Management**: Proper subscription/unsubscription prevents memory leaks

**Technical Choices**:
- Connection state management with exponential backoff
- Message queuing during disconnection periods
- Proper disposal in widget lifecycle methods

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
- **Deep Linking**: Built-in support for web URLs and app links
- **Guard Logic**: Centralized authentication and authorization checks
- **State Management**: Integration with BLoC for navigation state

**Migration Path**: Easier transition to Flutter web and desktop platforms.

### Testing Strategy Architecture
**Decision**: Comprehensive testing pyramid with unit, widget, and integration tests.

**Testing Layers**:
- **Unit Tests**: Repository implementations, BLoCs, and utility functions
- **Widget Tests**: UI components and user interactions
- **Integration Tests**: End-to-end user workflows
- **Golden Tests**: UI consistency across different screen sizes

**Mock Strategy**: Injectable dependencies enable comprehensive mocking without complex setup.

### UI/UX Architectural Decisions
**Decision**: Material Design 3 with custom theme and responsive layout system.

**Rationale**:
- **Consistency**: Platform-native look and feel
- **Accessibility**: Built-in support for screen readers and high contrast
- **Responsiveness**: Adaptive layouts for different screen sizes
- **Animation**: Smooth transitions enhance user experience

**Custom Components**: Reusable widgets following atomic design principles.

### Error Handling Strategy
**Decision**: Centralized error handling with user-friendly error states.

**Implementation**:
- **Network Errors**: Retry mechanisms with exponential backoff
- **Validation Errors**: Real-time form validation with clear messaging
- **Business Logic Errors**: Graceful degradation with fallback options
- **Crash Prevention**: Try-catch blocks with proper logging

### Performance Optimization Decisions
**Decision**: Implemented lazy loading, image caching, and efficient list rendering.

**Strategies**:
- **Memory Management**: Proper disposal of streams and controllers
- **Network Efficiency**: Request deduplication and caching
- **UI Performance**: ListView.builder for large datasets
- **Background Processing**: Isolates for heavy computations

**Monitoring**: Performance profiling integrated into development workflow.

## AI Workflow

This section documents the AI-assisted development process and prompts used to build this application, demonstrating systematic architectural thinking and iterative development.

### Navigation Architecture
**Prompt**: "Design a declarative navigation system using go_router for a Flutter app with authentication guards. Implement route protection that redirects unauthenticated users from dashboard to login, handles deep links gracefully, and provides smooth transitions between splash, login, and dashboard screens. Consider session validation and route state management."

**Rationale**: This prompt focuses on architectural considerations beyond basic routing, emphasizing security, user experience, and state management.

### Repository Pattern Implementation
**Prompt**: "Architect a scalable repository pattern with clear separation of concerns for authentication services. Create abstract repository contracts, implement both local (SharedPreferences) and remote data sources, and design the architecture to support offline-first capabilities with cache invalidation strategies. Include proper error handling and data transformation layers."

**Rationale**: Demonstrates understanding of clean architecture, separation of concerns, and enterprise-level data management patterns.

### Dependency Injection Strategy  
**Prompt**: "Implement a robust dependency injection system that supports testing isolation, environment-specific configurations, and lazy loading. Make SharedPreferences injectable to enable mock implementations during testing and support for different storage backends without tight coupling."

**Rationale**: Shows consideration for testability, maintainability, and flexible architecture design.

### Session Management System
**Prompt**: "Design a comprehensive session management system that handles authentication state persistence, automatic session validation on app lifecycle changes, secure token storage, and graceful session expiration handling. Implement state restoration that survives app restarts and background/foreground transitions."

**Rationale**: Focuses on security, user experience, and complex state management scenarios.

### Data Modeling with Code Generation
**Prompt**: "Generate robust data models using Freezed that implement immutability, equality, serialization, and proper null safety. Create corresponding domain entities with clear boundaries between data transfer objects and business entities. Ensure models support JSON serialization, copying with modifications, and pattern matching for exhaustive state handling."

**Example JSON**: Weather API response structure
**Rationale**: Emphasizes type safety, immutability, and clean separation between data and domain layers.

### News Integration Architecture
**Prompt**: "Build a news data pipeline that integrates with NewsAPI, implements proper error boundaries, supports pagination, caching strategies, and offline fallbacks. Design the architecture to support multiple news sources with a unified interface, and implement proper API key management and rate limiting considerations."

**API Endpoint**: `https://newsapi.org/v2/top-headlines?country=au&apiKey={apiKey}&pageSize=3`
**Rationale**: Demonstrates understanding of external API integration, error handling, and scalable data architectures.

### Real-time Data Streaming
**Prompt**: "Implement a WebSocket-based real-time data streaming system for financial data using best practices for connection management, automatic reconnection, subscription lifecycle management, and memory-efficient data handling. Design the system to handle multiple symbol subscriptions, connection failures, and background/foreground app state changes gracefully."

**WebSocket URL**: `wss://ws.finnhub.io?token={token}`
**Symbols**: BINANCE:BTCUSDT, BINANCE:ETHUSDT, BINANCE:SOLBTC, BINANCE:XRPUSDT
**Rationale**: Shows understanding of complex real-time systems, lifecycle management, and resilient network programming.

### Advanced UI Interactions
**Prompt**: "Create an intuitive drag-and-drop dashboard system with the following UX requirements: toggle between view and edit modes, provide visual feedback (shake animations) during edit mode, implement smooth reordering animations, persist user preferences, and ensure accessibility compliance. Use state management patterns that support optimistic UI updates and rollback capabilities for failed operations."

**Technical Requirements**:
- Visual edit mode indication (shake animations)
- Persistent order storage in SharedPreferences  
- State management via dashboard_action BLoC
- Smooth transitions and haptic feedback

**Rationale**: Demonstrates understanding of complex UI state management, user experience design, and accessibility considerations.

### Testing Strategy
**Prompt**: "Generate comprehensive unit test suites for repository classes that cover success cases, error scenarios, edge cases, and mock implementations. Implement tests for dependency injection, async operations, stream handling, and state transitions. Ensure tests are maintainable, isolated, and provide meaningful coverage metrics."

**Rationale**: Shows commitment to code quality, maintainability, and professional development practices.

## Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK 
- iOS/Android development environment

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Configure API keys in your environment
4. Run `flutter run` to start the application

### API Keys Required
- NewsAPI key for news integration
- Finnhub API key for stock price data
- Weather API key for weather services

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
