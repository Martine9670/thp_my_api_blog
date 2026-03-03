# My API Blog 🚀

A robust Ruby on Rails REST API designed to serve as a backend for a modern blogging platform.

## 🛠 Features

* **User Authentication:** Fully secured with Devise and Devise-JWT.
* **Articles:** CRUD operations with ownership protection.
* **Comments:** Logic allowing users to comment on articles.
* **Photos:** Resource management for image URLs.
* **Security:** CORS enabled and JWT revocation strategy.

## ⚙️ Tech Stack

* **Framework:** Ruby on Rails 8.x (API Mode)
* **Database:** SQLite3
* **Auth:** Devise + JWT

---

## 🚀 Getting Started

### 1. Installation
`bundle install`

### 2. Database Setup
`rails db:migrate`

### 3. Run the Server
`rails server`

---

## 🛤 Main API Endpoints

| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| GET | /articles | List all articles | No |
| POST | /articles | Create article | Yes |
| POST | /comments | Add comment | Yes |
| POST | /photos | Add photo URL | Yes |
| DELETE | /articles/:id | Delete article | Yes (Owner) |

---

**Author:** Martine PINNA
