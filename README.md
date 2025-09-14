# 🌟 MotivationMate

MotivationMate is a Flutter-based mobile app that delivers **daily motivational quotes** to users based on their selected category — helping them stay inspired and focused every day.  

## ✨ Features

- 📌 **Category-Based Motivation**  
  Users choose their motivation category (e.g., Study, Fitness, Work, Life) at signup, and receive daily quotes tailored to their choice.

- 🌍 **Multilingual Support**  
  MotivationMate supports multiple languages so users can receive motivation in the language they’re most comfortable with.  
  - Currently supported: **South African Official Languages plus Khelobedu**  
  - More languages can easily be added by extending the translations file.

- 🔔 **Push Notifications**  
  Daily motivation notifications are delivered even when the app is closed, so users never miss their daily dose of inspiration.

- 🗄️ **Firestore Integration**  
  Motivations are stored in **Firebase Firestore** for easy updating and management without redeploying the app.

- ⏰ **Time Zone Awareness**  
  Notifications are scheduled based on the user's local time zone to ensure they arrive at the right time of day.

- 🎨 **Clean UI**  
  Minimalistic and user-friendly design for a smooth experience.

## 🛠️ Tech Stack

- **Flutter** – Cross-platform UI framework  
- **Firebase Firestore** – Cloud database for storing motivational quotes  
- **Firebase Cloud Messaging (FCM)** – Push notifications  
- **timezone** package – For local time zone scheduling  
- **intl** package – For language localization and translation management  


git clone https://github.com/your-username/MotivationMate.git
cd MotivationMate
