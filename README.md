# 📋 Task Manager — Full-Stack App (Flutter + Spring Boot + PostgreSQL)

A full-stack **Task Manager** desktop application built as an internship onboarding project.
It demonstrates a complete **CRUD** workflow across three connected layers: a **Flutter**
desktop frontend, a **Spring Boot** REST API backend, and a **PostgreSQL** database.

The goal of this project was to understand — hands-on — how the three classic layers of a
modern application actually talk to each other.

---

## 🧠 How the three layers connect

```
┌──────────────┐   HTTP + JSON    ┌──────────────┐   SQL (JPA/JDBC)   ┌──────────────┐
│   Flutter    │ ───────────────> │ Spring Boot  │ ─────────────────> │  PostgreSQL  │
│  (Frontend)  │ <─────────────── │  (Backend)   │ <───────────────── │  (Database)  │
│   the UI     │  request/response │   the API    │     rows of data   │   storage    │
└──────────────┘                  └──────────────┘                    └──────────────┘
```

- **Flutter ↔ Spring Boot** communicate over **HTTP**, exchanging data as **JSON**.
- **Spring Boot ↔ PostgreSQL** communicate over **SQL**, handled automatically by **Spring Data JPA / Hibernate** (no manual SQL written).
- The frontend never touches the database directly — all access goes through the API. This keeps the system clean, secure, and maintainable.

**The full journey of one action:** tap a checkbox → Flutter sends `PUT /api/tasks/1` →
Spring converts the JSON to a Java object → Hibernate runs `UPDATE task SET done=true WHERE id=1`
→ PostgreSQL updates the row → Spring returns JSON → Flutter redraws the row.

---

## 🗂️ Repository structure

```
task-manager-flutter/
├── frontend/     → Flutter desktop app (the UI)
│   └── lib/main.dart           → all the app logic & screens
├── backend/      → Spring Boot REST API
│   ├── src/main/java/...        → Task entity, repository, controller
│   └── src/main/resources/application.properties
└── README.md
```

---

## 🛠️ Tech Stack

| Layer     | Technology                          |
|-----------|-------------------------------------|
| Frontend  | Flutter (Dart) — Windows desktop    |
| Backend   | Spring Boot 3.x / 4.x (REST API)    |
| Database  | PostgreSQL 16+                       |
| ORM       | Spring Data JPA / Hibernate         |
| Build     | Maven (backend), Flutter (frontend) |

---

## ✨ Features

- 📥 **Read** — view all tasks, loaded live from the database
- ➕ **Create** — add a new task from the app
- ✅ **Update** — mark a task as done (with a strikethrough effect)
- 🗑️ **Delete** — remove a task
- 💾 All changes persist instantly to PostgreSQL

---

## 🌐 API Endpoints

| Method   | Endpoint           | Description       |
|----------|--------------------|-------------------|
| `GET`    | `/api/tasks`       | Get all tasks     |
| `POST`   | `/api/tasks`       | Create a new task |
| `PUT`    | `/api/tasks/{id}`  | Update a task     |
| `DELETE` | `/api/tasks/{id}`  | Delete a task     |

A task is represented as JSON:
```json
{ "id": 1, "title": "Buy milk", "done": false }
```

---

## 🚀 Getting Started

### Prerequisites

Install these first:

| Tool                          | Purpose                                | Link             |
|-------------------------------|----------------------------------------|------------------|
| JDK 21+                       | Run the Spring Boot backend            | adoptium.net     |
| PostgreSQL 16+                | The database (includes pgAdmin GUI)    | postgresql.org   |
| Flutter SDK                   | Build & run the app                    | docs.flutter.dev |
| Visual Studio 2022 (C++)      | Required to build Flutter Windows apps | visualstudio.com |

After installing Flutter, verify your setup:
```bash
flutter doctor
```

---

### 1️⃣ Database setup

1. Install PostgreSQL and remember the password you set for the `postgres` user.
2. Open **pgAdmin**.
3. Create a new database named **`taskdb`**.

---

### 2️⃣ Run the backend

```bash
cd backend
```

Open `src/main/resources/application.properties` and set your database password:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/taskdb
spring.datasource.username=postgres
spring.datasource.password=YOUR_POSTGRES_PASSWORD
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

Then run the app:
```bash
./mvnw spring-boot:run
```

The backend starts on **http://localhost:8080**. On first run, Hibernate automatically
creates the `task` table from the `Task` entity (thanks to `ddl-auto=update`).

**Quick test** (PowerShell):
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/tasks" -Method Post -ContentType "application/json" -Body '{"title":"Test task","done":false}'
Invoke-RestMethod -Uri "http://localhost:8080/api/tasks"
```

---

### 3️⃣ Run the frontend

> ⚠️ Keep the backend running — the app calls it live.

```bash
cd frontend
flutter pub get
flutter run -d windows
```

The app window opens and loads your tasks from the database.

---

## 🧩 Key code highlights

**Backend — the REST controller** (`backend/src/main/java/.../TaskController.java`)
maps HTTP verbs to database operations. With Spring Data JPA, the repository provides
all CRUD methods (`findAll`, `save`, `deleteById`) without writing any SQL.

**Frontend — the network layer** (`frontend/lib/main.dart`) uses Dart's `http` package
with `async`/`await` to call the API, `jsonDecode`/`jsonEncode` to handle JSON, and
`setState()` to refresh the UI whenever the data changes.

---

## 📚 What I learned

- How a **frontend, backend, and database** connect and communicate in a real app
- Building a **REST API** with Spring Boot and mapping objects to tables with **JPA**
- Consuming an API from **Flutter** using HTTP and JSON
- The full **request → logic → database → response** lifecycle
- Packaging and running a multi-part application end to end

This is an early, foundational project — but it made the entire stack "click."

---

## 👤 Author

**Abdalla Eid**
Engineering Intern @ Ghanem
