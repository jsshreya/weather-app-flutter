# 🌦️ SkyCast Weather App

A modern Flutter weather application that provides live weather information for different cities using the Open-Meteo API.

## 📱 Project Overview

SkyCast is a Flutter-based weather application developed as part of the Week 03 Minor Project.

The application allows users to search for different cities and view their current weather conditions in a simple and user-friendly interface.

The project demonstrates Flutter development, API integration, HTTP requests, JSON parsing, asynchronous programming, state management using `setState()`, and error handling.

---

## ✨ Features

### 🌤️ Current Weather
- City name
- Country
- Current temperature
- Weather condition
- Weather icon
- Feels-like temperature
- Humidity
- Wind speed

### 🔍 City Search
- Search weather by city name
- Dynamically update weather information
- Search history for recently searched cities

### 📅 5-Day Forecast
- Daily weather forecast
- Maximum temperature
- Minimum temperature
- Weather condition icons

### 🎨 User Interface
- Clean and modern interface
- Responsive mobile layout
- Weather-based background
- Light mode
- Dark mode
- Loading indicator

### ⚠️ Error Handling
- Invalid city name handling
- API/network error handling
- User-friendly error messages

---

## 🛠️ Technologies Used

- Flutter
- Dart
- HTTP
- REST API
- JSON
- Open-Meteo API

---

## 🌐 API Used

This project uses the **Open-Meteo API** for weather information.

Open-Meteo provides weather data based on geographical coordinates.

The application first uses the Open-Meteo Geocoding API to find the latitude and longitude of a searched city.

The coordinates are then used with the Open-Meteo Forecast API to retrieve the weather information.




## 📥 Download APK

[Download SkyCast Weather App APK](https://drive.google.com/file/d/1JM89eks5JxfCmHYOsEVQAjYcDS7KR6-y/view?usp=sharing)

### APIs Used

**Geocoding API**

```text
https://geocoding-api.open-meteo.com/
