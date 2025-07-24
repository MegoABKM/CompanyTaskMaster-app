# CompanyTaskMaster: A Comprehensive Management Platform

![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue.svg?style=for-the-badge&logo=flutter)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/YourLinkedInProfile/)

A comprehensive, cross-platform solution built with Flutter for end-to-end company and project management. This application is designed to bridge the gap between high-level management and on-the-ground employees, providing a unified and real-time environment for collaboration, task tracking, and financial oversight.

---

## 📸 App Showcase

A picture is worth a thousand words. Here’s a glimpse into CompanyTaskMaster's powerful and intuitive interface.

*(**Instructions:** Replace the placeholder links below with direct links to your screenshots or GIFs. You can upload them directly to your GitHub repository and get a link.)*

| Login & Roles                                                                              | Manager Dashboard                                                                          | Project Workspace (Scrum)                                                                  |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| ![Login & Roles](https://via.placeholder.com/300x600.png?text=Login+%26+Role+Selection)     | ![Manager Dashboard](https://via.placeholder.com/300x600.png?text=Manager+Dashboard)       | ![Project Workspace](https://via.placeholder.com/300x600.png?text=Scrum+Board)               |
| **Finance Dashboard**                                                                      | **Employee Dashboard**                                                                     | **Kanban Board**                                                                           |
| ![Finance Dashboard](https://via.placeholder.com/300x600.png?text=Finance+Dashboard)       | ![Employee Dashboard](https://via.placeholder.com/300x600.png?text=Employee+Dashboard)     | ![Kanban Board](https://via.placeholder.com/300x600.png?text=Kanban+Board)                   |

---

## ✨ Key Features

This application is packed with features designed for real-world business scenarios, catering to both managers and employees.

### 🏢 Core & Company Management
- **Full Authentication Suite:** Secure user registration, login, password reset, and email verification.
- **Dual Role System:** Distinct interfaces and permissions for **Managers** and **Employees**.
- **Company Lifecycle Management:** Managers can create, view, update, and delete their company profile.
- **Unique Company ID System:** Employees can request to join a specific company using its unique ID.
- **Request Management:** Managers have a dedicated dashboard to approve or reject employee join requests.
- **Team Management:** View all associated employees and managers within a company.

### 🚀 Advanced Project & Task Management
- **Dynamic Project Creation:** Define project names, budgets, deadlines, and priorities.
- **Dual Project Methodologies:** Choose between **Scrum** (for iterative development) or **Kanban** (for continuous workflow).
- **Scrum Board:**
    - Create and manage **Sprints** with defined goals and timelines.
    - Organize tasks in a **Backlog** and assign them to specific sprints.
    - Visualize sprint progress through a dedicated workspace.
- **Kanban Board:**
    - Visualize workflow with columns for **Pending**, **In Progress**, and **Completed** tasks.
    - Easily track the status of all project tasks at a glance.
- **Comprehensive Task Creation:**
    - Define task titles, descriptions, start/due dates, priority, and status.
    - Create and manage nested **sub-tasks** for detailed work breakdown.
    - Attach files and documents to tasks.
- **Team Collaboration:**
    - Assign multiple employees to specific tasks and projects.
    - "Nudge" employees with a gentle reminder notification.

### 💰 Integrated Finance Tracking
- **Company-Level Accounting:** Track overall company **Income** and **Expenses** (overhead).
- **Project-Level Accounting:** Track project-specific **Revenue** and **Costs**.
- **Automated Financial Dashboard:**
    - Instantly calculate key metrics like **Total Revenue**, **Total Costs**, and **Overall Net Profit**.
    - Analyze profitability with **Gross Profit Margin** and **Net Profit Margin**.
    - View profitability summaries for each individual project.

### 👤 User Experience & General Features
- **Multi-Language Support:** Fully localized for both English and Arabic, with a flexible architecture to add more languages.
- **Dynamic Theming:** Seamlessly switch between **Light and Dark modes**.
- **Customizable Accent Colors:** Users can personalize the app's primary and secondary colors to their preference.
- **Real-time Push Notifications:** Built with **Firebase Cloud Messaging (FCM)** to deliver instant updates for new tasks, status changes, and join requests.
- **Responsive UI:** The interface is designed to adapt to various screen sizes and orientations.

---

## 🛠️ Technical Stack & Architecture

- **Platform:** Flutter (Cross-platform for Android & iOS)
- **State Management:** GetX (A powerful and lightweight solution for state, dependency, and route management).
- **Architecture:** Follows clean architecture principles, separating UI (Views), Business Logic (Controllers), and Data (Models, Data Sources).
- **Backend:** PHP with a MySQL Database.
- **Real-time Notifications:** Firebase Cloud Messaging (FCM).
- **Localization:** `get` package for internationalization.

---

## 🚀 Getting Started

To run this project locally, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/MegoABKM/CompanyTaskMaster-app.git
    cd CompanyTaskMaster-app/Frontend 
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the app:**
    ```bash
    flutter run
    ```
    *(Note: You will need a running instance of the PHP backend for the app to function correctly.)*

---

## 👤 Contact

Created by **[Your Name Here]** - feel free to connect with me!

- **LinkedIn:** [https://www.linkedin.com/in/YourLinkedInProfile/](https://www.linkedin.com/in/YourLinkedInProfile/)
- **Portfolio:** *(Optional: Add a link to your portfolio website here)*

---

## 📜 License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.
