# TeaMilk - Milk Tea Shop Management Application

**TeaMilk** is a web application designed to help manage milk tea shops, developed with **Java Web** using **Spring MVC**, **JSP**, and **MySQL**. The project aims to assist shop owners in managing products, categories, orders, and users conveniently and efficiently.

## Main Features

- User Management

  - Role-based login
  - Access control by role

- Product & Category Management

  - Add, edit, delete milk tea products
  - Manage product categories

- Order Management

  - Create and track orders
  - View order details

- Revenue Statistics

## Technologies Used

| Component     | Technology                         |
| ------------- | ---------------------------------- |
| Backend       | Java, Spring MVC                   |
| Frontend      | JSP, HTML/CSS, Bootstrap           |
| Database      | MySQL                              |
| Build Tool    | Maven                              |
| View Resolver | InternalResourceViewResolver (JSP) |

## Project Structure

```source
MilkTea/
├── src/
│ └── main/
│ ├── java/ # Java code (Controllers, DAO, Models)
│ ├── resources/ # Config files, properties
│ └── webapp/
│ ├── META-INF/
│ └── WEB-INF/
│ ├── views/ # JSP files
│ ├── lib/ # Additional libraries (if any)
│ ├── web.xml # Servlet configuration
│ └── spring-servlet.xml # Spring MVC configuration
├── pom.xml # Maven build file
├── database/TeaMilk.sql # DB structure and sample data
└── README.md
```

## ⚙️ Installation & Run Guide

### Requirements

- JDK 8 or higher
- Apache Tomcat 9 or higher
- MySQL
- Maven

### Step 1: Clone and Import into IDE

```bash
git clone https://github.com/TranKienCuong2003/MilkTea.git
```

### Step 2: Database Configuration

- Create a MySQL database named: teamilk
- Import the database/TeaMilk.sql file
- Update DB connection info in spring-servlet.xml or application.properties (if needed)

### Step 3: Build and Deploy

```bash
mvn clean install
```

- Deploy the WAR file to Tomcat or run directly from your IDE.

Access the application at:

```
http://localhost:8080/TeaMilk/
```

## Sample Accounts

### Admin

- Username: chuquan01 &nbsp;|&nbsp; Password: 123
- Username: quanly1 &nbsp;|&nbsp; Password: 123

---

### Staff

- Username: order01 &nbsp;|&nbsp; Password: 123
- Username: thungan01 &nbsp;|&nbsp; Password: 123
- Username: phache01 &nbsp;|&nbsp; Password: 123
- Username: kho01 &nbsp;|&nbsp; Password: 123

---

## Contribution

- Fork the repository
- Create a new branch: feature/add-functionality
- Commit and push your changes
- Create a Pull Request

📄 License

See details at [LICENSE](LICENSE).
