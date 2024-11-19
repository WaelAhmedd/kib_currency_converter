# kib_currency_converter_task

A new Flutter project.

## Getting Started

# Instructions to Build the Project
To successfully build and run the application, follow these steps:

### 1.Clone the Repository
Clone this repository to your local machine:
git clone <repository-url>

### 2.Install Dependencies
Run the following command to install the required dependencies:
flutter pub get

### 3.Create a .env File
The project relies on a .env file to securely manage API keys. Create a .env file in the root directory of the project and add your apiKey in the following format:
API_KEY=your_api_key_here

### 4.Generate Hive Adapters (If Required)
If you face any issues related to Hive database adapters, ensure you run the build_runner command to generate the necessary adapter files:
flutter pub run build_runner build --delete-conflicting-outputs

# Adapted Design Patterns and App Architecture

## Architecture Overview

The app follows a **Clean Architecture** approach, a widely recognized software architecture pattern that enforces clear separation of concerns. This structure ensures scalability, testability, and maintainability. The architecture consists of the following layers:

## Core Module
- Contains **shared resources and utilities** that are used across all features of the app.
- Focused on providing **common functionality**, such as app-wide constants, error handling utilities, and shared modules like dependency injection.

---

## Feature-Specific Structure
Each feature now has its own **Data**, **Domain**, and **Presentation** layers, including all feature-specific logic such as data sources, repositories, and repository implementations. These components are not shared across features, ensuring a clear and focused responsibility within each feature.

### Feature Modules
For example, in the **Home Feature**:
- **Data Layer**:
 - Fully encapsulated within each feature module.
- Includes:
  - **Data Sources**: Handles feature-specific API calls, database operations, or other data fetching logic.
  - **Repository Implementations**: Implements the interfaces defined in the Domain layer.
  - **UI-Specific Models**: Structures that transform raw data into models usable by the UI.
- **Domain Layer**:
- **Feature-Specific Business Logic**: Each feature has its own Domain layer to encapsulate its business rules.
- **Repository Interfaces**: Defined per feature and serve as contracts for the Data layer.
- **Use Cases**:
  - Act as the only entry point to business logic from the Presentation layer.
  - Reusable within the feature, ensuring a clean separation of concerns.
- **Presentation Layer**:
  - Manages the **UI widgets/screens** for the feature.
  - Utilizes state management tools such as **Cubits** to handle the state of the UI.

---


## Why This Architecture?

This separation ensures that changes in one layer do not impact others unnecessarily.

### Testability
- The **Domain layer** is free of UI or framework dependencies, making it highly testable.
- Repository interfaces allow mocking of data sources, enabling comprehensive testing of business logic and presentation layers.

### Scalability
- Each feature has its own structure, making it easy to add new features without affecting existing ones.
- Shared logic in the **Core module** prevents duplication across features.

### Reusability
- Shared data models and utilities (e.g., `Result`, `NetworkModule`) ensure consistency and reusability.
- Use Cases in the **Domain layer** can be used across multiple features.

### Dependency Inversion Principle
- High-level modules (e.g., Presentation Layer) do not depend on low-level modules (e.g., API services) directly.
- Instead, they rely on abstractions (interfaces), making the app loosely coupled and more adaptable to changes.

---

## Design Patterns Used

### Repository Pattern
- Separates the Data layer from the Business Logic.
- Repository interfaces in the Domain layer define the contract, while implementations in the Data layer handle the actual data fetching (e.g., from API or database).

### Use Case Pattern
- Encapsulates individual pieces of business logic in the Domain layer.
- Simplifies interactions between the Presentation and Data layers.

### Cubit for State Management
- Lightweight state management library that is part of the **Bloc ecosystem**.
- Ensures predictable state transitions and clean separation of UI logic from business logic.

### Dependency Injection
- Uses **injectable** for dependency injection.
- Provides loose coupling by resolving dependencies at runtime, ensuring flexibility and testability.

### Mapper Pattern
- Converts API or database models into UI-friendly models in the Data layer.
- Simplifies the Presentation layer by delivering preformatted data.

# Repository Design: Separation of Responsibilities

In the app, we have three distinct repositories:

## 1. CountryRepo

### Responsibilities
- Fetches country data from the API.

### Reason for Separation
The responsibility of **CountryRepo** is isolated to managing country data only. This decoupling ensures:
- **Clear responsibility boundaries.**
- The flexibility to change the data source for countries (e.g., a new API or a local database) without impacting the rest of the app.

For example:
- While the currency API provides some country-related information, it might not be accurate or comprehensive. 
- Therefore, a dedicated API for countries is used, and this repository ensures that any logic related to countries is handled separately.

---

## 2. CurrencyRepo

### Responsibilities
- Fetches currency data.
- Fetches conversion rates between currencies.
- Fetches historical conversion rates for a specified date range.

### Reason for Separation
Currency-related logic is independent of country-specific logic. By keeping this logic in a separate repository, we ensure:
- All currency-related data and functions (including conversion rates and historical rates) are **centralized**.
- Responsibilities are **decoupled** from other repositories, avoiding unnecessary overlap.

---

## 3. CurrencyWithCountryRepo

### Responsibilities
- Combines country and currency data.
- Saves the combined data (CurrencyWithCountry) into the database.
- Fetches the combined data from the database.

### Reason for Separation
The combination of country and currency data introduces a new layer of abstraction. Instead of mixing this logic into **CountryRepo** or **CurrencyRepo**, it is managed in a dedicated repository to:
- **Centralize operations** related to `CurrencyWithCountry`.
- Ensure clear separation between **raw data fetching** (from APIs) and **data transformation** (combining countries and currencies).
- Maintain flexibility if future changes require combining data from different sources (e.g., a new API for either countries or currencies).

---

## Why Separate Country and Currency Repositories?

### Decoupling Responsibilities
- The **CountryRepo** is solely responsible for fetching country data, ensuring that it does not need to access currency-related functions.
- The **CurrencyRepo** focuses on managing currency data and its related operations, like conversion rates and historical data.

### Scalability and Maintainability
- **Clear separation** makes the codebase easier to scale and maintain. For example:
  - If a new feature requires extending the functionality of countries (e.g., adding regions or population data), this can be added to **CountryRepo** without touching other repositories.


# Adapted Image Loader Library

## Library Used: `cached_network_image`

### Why `cached_network_image`?

The `cached_network_image` library was chosen for loading and displaying images in the app due to the following reasons:

---

### **1. Caching for Improved Performance**
- Automatically caches images locally, reducing the need to fetch the same image multiple times from the network.
- Significantly enhances the app's performance, especially when dealing with:
  - Large images.
  - Frequently accessed images like country flags in the currency converter.

---


### **2 Efficient Memory Usage**
- Employs efficient memory management techniques to load images.
- Ensures smooth performance even on devices with limited resources.

---

### **3. Community Support**
- `cached_network_image` is a well-maintained and widely used library in the Flutter ecosystem.
- Benefits from active community support and regular updates.

---

## Example Usage in the App
- The library is used to display **country flags** in the dropdown menus for currency selection.
- By caching these images:
  - The app ensures a **fast and seamless user experience**.
  - Performance remains optimal even when switching between screens or running the app offline.

# Used Database in the App

## Database Used: **Hive**

### Why Hive?

#### **1. Lightweight and Fast**
- Hive is a lightweight NoSQL database optimized for Flutter apps.
- Offers high performance with quick read/write operations.
- Ideal for storing app data like `CurrencyWithCountry` for offline usage.

---

#### **2. Offline Support**
- Ensures data persistence for currencies and countries.
- Allows the app to function seamlessly without an internet connection.

---

#### **3. No Boilerplate Code**
- Hive eliminates the need for extensive boilerplate code.
- Simplifies defining and managing data models using **type adapters**.

---

#### **4. Easy Integration**
- Integrates seamlessly with Flutter projects with minimal configuration.

---

## Use Case in the App

### **Data Stored**
- Combined `CurrencyWithCountry` data:
  - Currency name.
  - Country name.
  - Flag URL.

---

## Why Not a Relational Database?

### **1. Simple Data Structure**
- The data being managed (e.g., `CurrencyWithCountry`) has a relatively simple structure.
- Does not require complex relationships or joins that relational databases excel at handling.

### **2. No Complex Queries Needed**
- The app primarily performs straightforward operations:
  - Fetching, storing, and retrieving data.
- SQL queries or relationships between multiple tables are unnecessary.


