# 🕌 Muslim Companion

A modern, **offline-first Muslim app** built with **Flutter**.  
Read the **Qur’an** and **Hadith**, listen to recitations from 5 imams, track prayer times with Adhan, find the Qibla, and use a digital Sebha — all **offline** after the first launch.

---

## ✨ Features

### 🟢 Splash & Onboarding
- Initial data download (cached locally with Hive)


<!-- Optional compact gallery under the banner -->
<p align="center">
  <img width="180" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-09-01 at 14 18 39" src="https://github.com/user-attachments/assets/87e84fdf-5385-499d-85f2-afcc18db59aa" />
  <img width="180" alt="Onboarding" src="https://github.com/user-attachments/assets/3b7d3c9b-050a-4ecc-9318-4c5306bcbb14" />
  <img width="180" alt="Screenshot_1756723778" src="https://github.com/user-attachments/assets/20e6f761-8573-495a-a528-c60ebbd98dcf" />
  <img width="180" alt="Screenshot_1756723775" src="https://github.com/user-attachments/assets/a86d698c-6cdd-453b-85ce-ffab8f919b0c" />
  <img width="180" alt="Screenshot_1756723773" src="https://github.com/user-attachments/assets/a81720c4-eaf8-4469-9361-ec5763a0447d" />
  <img width="180" alt="Screenshot_1756723771" src="https://github.com/user-attachments/assets/90dc796b-7fb0-4074-a4e9-1bbd739410e8" />
</p>

---

### 📖 Qur’an (القرآن)
- Read mushaf text with **auto-scroll**
- 5 reciters with **streaming**
- Adjustable font size and line height

<p align="center">
  <img width="180" alt="Quran" src="https://github.com/user-attachments/assets/19030590-b542-429b-a8f5-a3c05f4f31e2" />
<img width="180" alt="Screenshot_1756723809" src="https://github.com/user-attachments/assets/0deb8217-4b58-4fa2-b38c-09b73ce18fd8" />
</p>

---

### 📚 Hadith (الحديث)
- Browse hadith collections
- Built-in search

<!-- Replace placeholder if you have a dedicated Hadith screenshot -->
<p align="center">
  <img width="180" alt="Hadith" src="https://github.com/user-attachments/assets/caf4c6a4-9f43-4948-8b3e-6de02c64f830" />
<img width="180" alt="Screenshot_1756723823" src="https://github.com/user-attachments/assets/b5814516-9623-4794-a1fa-c3a5f58dee40" />
<img width="180" alt="Screenshot_1756723827" src="https://github.com/user-attachments/assets/f8c48d9b-2ba7-4a3d-9dc7-9c0be7943e14" />
</p>

---

### 🧭 Qibla Direction (القبلة)
- Interactive compass
- Magnetic declination adjustments

<p align="center">
  <img width="180" alt="Qibla" src="https://github.com/user-attachments/assets/305b3307-41ec-4a59-878e-5976ba40173d" />
</p>

---

### 🕌 Prayer Times & Adhan
- Daily prayer schedule
- Next prayer countdown
- Local Adhan notifications with audio

<!-- Optional compact gallery -->
<p align="center">
<img width="180" alt="Screenshot_1756723852" src="https://github.com/user-attachments/assets/9afbec41-0a8b-4c47-b279-0efdbb9e3352" />
  <img width="180" alt="PrayerTimes" src="https://github.com/user-attachments/assets/f92e96ea-9ed5-47ef-bb40-21a16d0841c9" />
  <img width="180" alt="Screenshot_1756723859" src="https://github.com/user-attachments/assets/f92e96ea-9ed5-47ef-bb40-21a16d0841c9" />
</p>

---

### 🔵 Sebha (السبحة)
- Digital tasbeeh counter
- Configurable target counts
- Haptic feedback support

<p align="center">
 <img width="180" alt="Screenshot_1756723833" src="https://github.com/user-attachments/assets/9a83a550-f935-4dcb-8b86-82993efc8cc0" />

</p>

---

### 💾 Offline-First
- Data fetched **once**, then cached with **Hive**
- Fast subsequent loads from local DB

### 🌍 Localization & 🎨 Theming
- **Languages:** Arabic (ar), English (en)
- **Themes:** Light & Dark

---

## 🧱 Tech Stack

- **Framework:** Flutter (Dart 3)
- **Local DB:** Hive (offline cache, user prefs)
- **Audio:** just_audio
- **Qibla:** flutter_compass + geolocator
- **Prayer Times:** adhan-dart / prayers_times
- **State Mgmt:**  Bloc
- **Routing:** ongenerate route
- **Localizations:** easy_localizations

---

## 🗂️ Project Structure

<p align="center">
  <img width="180" alt="Screenshot 2025-09-01 at 2 43 57 PM" src="https://github.com/user-attachments/assets/517cbc62-c775-482a-be1f-75bd5331f82b" />
</p>


---

## 🔊 Audio & Auto-Scroll
- Stream or download recitations
- Auto-scroll Qur’an reader synced with playback

## 🧭 Qibla & 📅 Prayer Times
- Qibla: device compass + location
- Prayer: schedule calculated locally
- Adhan: local notifications + audio

---

## 🛡️ Privacy
- Location used **only** for Qibla & prayer times  
- **No personal data** shared externally

---

## 🤝 Contributing

We welcome contributions! 🚀

1. **Fork** the repo  
2. Create a branch  
   ```bash
   git checkout -b feature/your-feature
