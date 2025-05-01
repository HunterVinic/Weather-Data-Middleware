# 🌤️ Weather Middleware System

A **Flutter-based IoT middleware system** that collects, filters, formats, and forwards weather data from public APIs. It displays the data in a user-friendly interface and stores it in Firebase Firestore for further analysis.

---

## 📦 Features

- 🔄 Scheduled or manual weather data fetching
- ✅ Data filtering and validation (e.g., temperature, humidity)
- 📊 Display in UI as graphs and cards
- ☁️ Data pushed to Firebase Firestore
- 🧰 Built using Flutter and REST API integration

---

## 📌 Project Overview

This system aims to:
- Fetch weather data from [weatherapi.com](https://www.weatherapi.com/)
- Process the data in-app (filter, validate, format)
- Display it through charts and widgets in a Flutter mobile UI
- Store formatted results into Firebase Firestore (`/weather_logs`)

---

## 🛠️ System Architecture


---

## 📦 Technology Stack

| Component       | Technology                |
|----------------|----------------------------|
| UI Framework    | Flutter                    |
| API Source      | weatherapi.com             |
| Communication   | HTTP (REST)                |
| Database        | Firebase Firestore         |
| Scheduling      | Dart Timer / Cron pattern  |

---

## 🚀 Getting Started

### ✅ Prerequisites

- Flutter SDK (≥ 3.x.x)
- Dart SDK
- Firebase Project with Firestore enabled
- weatherapi.com API Key
- Android Studio / Xcode / VS Code

---

## ⚙️ Installation

1. **Clone the project:**

   ```bash
   git clonehttps://github.com/HunterVinic/Weather-Data-Middleware.git
   cd weather-middleware-flutter

2. **Install dependencies:**
   ```bash
   flutter pub get
   

3. ** 🔧 Firebase Setup: **

### 1. Create Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add Project"** → Name it: `IoT Weather App`
3. Follow the prompts to complete the setup.
4. Enable FireStore.

### 2. Register Android App

1. Click **"Add App"** → Choose **Android**
2. Enter the following:
    - **Package name**: *(Find it in your `android/app/build.gradle` under `applicationId`)*
    - **App nickname**: *(Optional)*
3. Click **Register App**
4. Download the `google-services.json` file and past it on android/app/
5. Open your `android/build.gradle` (Project-level) and **add the following plugin in the `plugins` block**:
```groovy
plugins {
    id 'com.android.application' version '8.4.0' apply false
    id 'com.google.gms.google-services' version '4.4.2' apply false 
}
```
6. Open your android/app/build.gradle (App-level) and do the following:
   Apply the Google services plugin at the bottom of the file:
```groovy 
apply plugin: 'com.google.gms.google-services'
```

4. ** API Setup **
   1. Go to https://www.weatherapi.com/ and create an account
   2. Generate an API key and replace it in data_fetcher.dart

5. Run the App



## 📜 License

This project is a course submission for the [AT83.01 Internet of Things Technology and Design](https://www.ait.ac.th/) course at the Asian Institute of Technology. It is licensed for academic use only and cannot be used for commercial purposes without prior permission.

Student: Sheshehang Limbu  
Student ID: 125111  
Submission Date: 3rd May 2025
