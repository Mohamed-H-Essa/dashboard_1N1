# Project Management Dashboard

A responsive Flutter dashboard application built with clean architecture principles and the BLoC pattern. This project serves as a foundation for building feature-rich project management tools with a focus on maintainability and scalability.

## Architecture Overview

This application follows a clean architecture approach with a modular structure, making it easy to extend and maintain. The architecture is designed to separate concerns and promote testability.

### Project Structure

```
lib/
├── core/                  # Core functionality and utilities
│   ├── constants/         # Application-wide constants
│   └── themes/            # Theme configuration
├── features/              # Feature-based modules
│   └── dashboard/         # Dashboard feature
│       ├── presentation/  # UI layer
│       │   ├── bloc/      # State management
│       │   ├── pages/     # Screen components
│       │   └── widgets/   # Reusable UI components
│       ├── domain/        # Business logic layer
│       └── data/          # Data access layer
└── main.dart              # Application entry point
```

### Key Architectural Principles

1. **Separation of Concerns**: Each layer has a specific responsibility:
   - Presentation: Handles UI and user interactions
   - Domain: Contains business logic and use cases
   - Data: Manages data access and repositories

2. **Dependency Rule**: Dependencies point inward, with inner layers having no knowledge of outer layers.

3. **Feature-First Organization**: Code is organized by feature rather than by layer, making it easier to navigate and maintain.

## State Management with BLoC

The application uses the BLoC (Business Logic Component) pattern for state management, which offers several advantages:

1. **Predictable State Changes**: All state changes follow a unidirectional data flow.
2. **Testability**: Business logic is separated from UI, making it easier to test.
3. **Reusability**: BLoCs can be reused across different UI components.

### BLoC Implementation

Each feature has its own BLoC that consists of:

- **Events**: Represent user actions or system events
- **States**: Represent the UI state at a given point in time
- **BLoC**: Processes events and emits new states

Example flow:
1. User taps a navigation item
2. UI dispatches a `NavigateToPageEvent`
3. `NavigationBloc` processes the event
4. `NavigationBloc` emits a new `NavigationState`
5. UI rebuilds based on the new state

## Responsive Design Approach

The application is designed to work seamlessly across different screen sizes:

1. **Responsive Framework**: Uses the `responsive_framework` package to define breakpoints and adapt layouts.

2. **Adaptive UI Components**:
   - On mobile devices (< 600px width): Shows a top navbar with hamburger menu, logo (left-aligned), settings, notifications, and user avatar
   - On larger screens: Displays a horizontal navbar with logo, navigation items, settings, notifications, and user profile

3. **Custom Navbar Implementation**:
   - Mobile: Hamburger menu opens a drawer with user profile and navigation items
   - Desktop: Horizontal navigation with selected item highlighting

4. **Breakpoints**:
   - MOBILE: 0-600px
   - TABLET: 601-900px
   - DESKTOP: 901-1200px
   - XL: 1201px+

## Navigation System

Navigation is handled through a dedicated BLoC:

1. **NavigationBloc**: Manages the current page index
2. **NavigationEvent**: Represents navigation actions
3. **NavigationState**: Holds the current page state

This approach allows for:
- Centralized navigation management
- Easy addition of new pages
- Persistence of navigation state across widget rebuilds

## Theming

The application includes a comprehensive theming system:

1. **Light and Dark Themes**: Full support for both light and dark mode
2. **Consistent Styling**: Centralized theme definitions ensure consistency
3. **Material 3**: Uses Material 3 design principles for modern UI

## Getting Started

### Prerequisites

- Flutter SDK (2.0.0 or higher)
- Dart SDK (2.12.0 or higher)

### Installation

1. Clone the repository
2. Install dependencies: `flutter pub get`
3. Run the application: `flutter run`

## Extending the Application

### Adding New Pages

1. Create a new widget in `lib/features/dashboard/presentation/pages/`
2. Add a new navigation item in `lib/core/constants/app_constants.dart`
3. Update the `_buildPageContent` method in `dashboard_page.dart` to include your new page

### Adding New Features

1. Create a new directory under `lib/features/`
2. Follow the same structure as the dashboard feature
3. Implement the necessary BLoCs, pages, and widgets
4. Integrate with the main application in `main.dart`

## Best Practices

1. **Keep UI and Logic Separate**: Use BLoC to separate business logic from UI
2. **Maintain Modularity**: Each feature should be self-contained
3. **Follow the Single Responsibility Principle**: Each class should have one responsibility
4. **Write Tests**: Cover BLoCs and critical UI components with tests
5. **Use Consistent Naming**: Follow Flutter/Dart naming conventions

## Future Enhancements

Potential areas for expansion:

1. **Authentication**: Add user authentication and authorization
2. **Data Persistence**: Implement local storage with Hive or SQLite
3. **API Integration**: Connect to backend services
4. **Advanced UI Components**: Add charts, calendars, and other project management tools
5. **Localization**: Add support for multiple languages
