# Task Manager — Flutter + Spring Boot + PostgreSQL

A full-stack Task Manager desktop app built as an onboarding project.
It covers complete CRUD operations across three connected layers:
a Flutter desktop frontend, a Spring Boot REST API backend, and a PostgreSQL database.

## Tech Stack

| Layer | Technology |
| ------- | ----------- |
| Frontend | Flutter (Windows desktop) |
| Backend | Spring Boot 4.x (REST API) |
| Database | PostgreSQL 16+ |
| ORM | Spring Data JPA / Hibernate |

## How the three layers connect

Flutter (UI) ──HTTP/JSON──> Spring Boot (API) ──SQL/JDBC──> PostgreSQL (DB)

- Flutter talks to Spring over **HTTP + JSON**
- Spring talks to PostgreSQL over **SQL** (via JPA — no manual SQL needed)
- Flutter and PostgreSQL never talk directly

## Features

- View all tasks loaded from the database
- Add a new task
- Mark a task as done (checkbox with strikethrough)
- Delete a task
- All changes persist to PostgreSQL in real time

---

## Prerequisites — install these first

| # | Tool | Purpose | Download |
| --- | ------ | --------- | ---------- |
| 1 | JDK 21+ | Run Spring Boot | adoptium.net |
| 2 | Maven | Build the backend | (bundled with the project via mvnw) |
| 3 | PostgreSQL 16+ | The database | postgresql.org/download/windows |
| 4 | Flutter SDK | Build the app | docs.flutter.dev |
| 5 | Visual Studio 2022 (C++ workload) | Required for Flutter Windows builds | visualstudio.com |

After installing Flutter, run:

```bash
flutter doctor

