# Netflix Movies and TV Shows Data Analysis using SQL


<p align="center">
  <img src="logo.png" width="200" alt="Project Logo">
</p>


##  📢 About This Project
This repository contains an **SQL-based Netflix Data Analysis** project. It involves working with a Netflix dataset to extract meaningful insights using SQL queries. The dataset includes details about movies, TV shows, ratings, genres, and more.

## 🎯 Objectives
✅ Perform data cleaning and transformation.  
✅ Analyze Netflix content distribution.  
✅ Extract insights about ratings, genres, and trends.  
✅ Practice SQL queries for data exploration.  

---

## 📂 Dataset Overview
The dataset consists of:
- 🎥 **Title** (Movie/TV Show Name)
- 📅 **Release Year**
- ⭐ **Ratings**
- 🎭 **Genres**
- 🌍 **Country of Production**
- 🕒 **Duration**
- 📌 **Type** (Movie/TV Show)
- 📜 **Description**

---

## 🏛 Database Schema
The following schema represents the structure of the Netflix dataset:

```sql
CREATE TABLE netflix_data (
    show_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    type VARCHAR(50) CHECK (type IN ('Movie', 'TV Show')),
    release_year INT,
    rating VARCHAR(50),
    duration VARCHAR(50),
    genre VARCHAR(255),
    country VARCHAR(255),
    description TEXT
);
```

---

## 📖 Table of Contents
🔹 [Queries Included](#-queries-included)  
🔹 [Setup Instructions](#-setup-instructions)  
🔹 [Usage](#-usage)  
🔹 [License](#-license)  

---

## 📝 Queries Included
📌 **Key SQL Queries Covered:**
- 📊 **Total number of movies and TV shows**  
- 🔝 **Top-rated Netflix content**  
- 🎭 **Most popular genres**  
- 🌍 **Country-wise content analysis**  
- 🏆 **Highest-rated movies and TV shows**  
- 📅 **Content release trends by year**  
- 🕵️‍♂️ **Exploring hidden insights with SQL functions**  

---

## 🚀 Usage
💡 Modify and test the queries in your preferred SQL environment.  
📊 Extend the dataset by adding more Netflix data.  
⚡ Optimize queries for better performance.  

---

## 📜 License
📌 This project is licensed under the **MIT License** – feel free to use and modify it.

📌 **🌟 Star this repo and follow for more SQL projects!** 🚀

---  
🎯 **Happy Querying!** 🎯



