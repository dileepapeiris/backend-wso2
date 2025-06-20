<h1 align="center" id="title">Participant Management System using Ballerina and MySQL</h1>

<p id="description">
The Participant Management System is a backend API service developed using Ballerina and MySQL. It is designed to efficiently manage participant data using their NIC (National Identity Card) number. The system provides secure and well-structured endpoints to perform standard CRUD operations (Create, Read, Update, Delete) on participant records.
</p>

---

## ✅ Prerequisites

- Ballerina
- MySQL Database

---

## 📁 Project Structure

BACKEND-WSO2/
├── MODULES/
│ └── database/
│ ├── client.bal
│ ├── db_functions.bal
│ ├── db_queries.bal
│ └── types.bal
├── Resources/
│ └── database/
│ └── database.sql
├── services.bal
├── types.bal
└── Config.toml


---

## 📌 API Endpoints

| Action                | Method | Endpoint                                                     |
|-----------------------|--------|---------------------------------------------------------------|
| ➕ Add Participant     | POST   | `http://localhost:9090/addParticipant`                        |
| 📄 View All           | GET    | `http://localhost:9090/getAll`                                |
| ❌ Delete by NIC      | DELETE | `http://localhost:9090/deleteParticipantByNIC`                |
| ❌ Delete by Name     | DELETE | `http://localhost:9090/deleteParticipantByName`               |
| 🔍 Search by NIC      | GET    | `http://localhost:9090/getParticipantByNicNumber`             |
| 🔍 Search by Name     | GET    | `http://localhost:9090/getParticipantByName`                  |
| 🔁 Update by NIC      | PUT    | `http://localhost:9090/updateParticipantByNicNumber`          |

---

## 🚀 Project Setup Instructions

1. **Create the Database Table**

   Execute the following SQL command to create the `participant` table:

   ```sql
   CREATE TABLE `participant` (
     `participant_id` int NOT NULL AUTO_INCREMENT,
     `name` varchar(255) NOT NULL,
     `nic_number` varchar(255) NOT NULL,
     `email` varchar(255) DEFAULT NULL,
     `created_by` varchar(60) NOT NULL,
     UNIQUE KEY `unique_nic` (`nic_number`),
     PRIMARY KEY (`participant_id`)
   );

2. Configure the Project

   Update the Config.toml file with your MySQL database connection details:


    host = " "
    port = 
    user = "your-username"
    password = "your-password"
    database = "your-database-name"

3. Run the Project

Navigate to the project root and run:

    bal run
