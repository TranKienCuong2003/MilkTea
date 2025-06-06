# Milk Tea Shop - Milk Tea Store Management System

## 📝 Description

Milk Tea Shop is a comprehensive web application for managing a milk tea store, featuring product management, order processing, and customer interaction through chatbot. Built with Java Spring MVC, the application provides a user-friendly interface and smooth user experience.

## 🎯 Detailed Features by Role/Permission

### 1. Guest (Not Logged In)

- View product list, search, filter by category
- View product details, images, descriptions, prices, status
- Register account, email OTP verification
- Login
- AI Chatbot for product consultation and store information

### 2. Customer (Logged In)

- All Guest features
- Add products to cart, select size, toppings
- Apply vouchers, view total, update/remove products from cart
- Place orders, confirm orders
- View order history
- View and update personal profile, change email, avatar, password
- Change password, password recovery via email
- AI Chatbot for product consultation, order tracking, and voucher information

### 3. Order Staff

- View order list
- Confirm orders, update order status
- View order details

### 4. Warehouse Staff

- Warehouse management: view, add, edit, delete inventory items
- Supplier management: add, edit, delete supplier information
- Track ingredient expiration dates

### 5. Barista

- View orders requiring preparation
- Update preparation status (completed, in progress, etc.)
- View order details for preparation

### 6. Cashier

- View pending payment orders
- Confirm order payments
- Print customer receipts
- View revenue reports by day/month/quarter/year

### 7. Manager

- Product management: add, edit, delete, update details, upload images
- Category management: add, edit, delete
- Topping and size management: add, edit, delete
- Voucher management: add, edit, delete, check validity
- Warehouse management: add, edit, delete inventory items
- Supplier management: add, edit, delete
- Staff management: add, edit, delete, assign staff permissions (cannot modify/delete store owner)
- Order management: confirm, update status, view order details
- Cashier reports: revenue statistics, pending payment orders, receipt printing
- Barista reports: preparation order list, update preparation status
- View comprehensive reports, product sales statistics

### 8. Store Owner

- All Manager features
- Manager management: add, edit, delete, assign manager permissions

## 🛠 Technologies Used

- **Backend**

  - Java 8
  - Spring MVC
  - Spring JDBC Template
  - MySQL 8.0
  - Maven

- **Frontend**

  - HTML5, CSS3, JavaScript
  - Bootstrap
  - jQuery
  - AJAX

- **Server**
  - Apache Tomcat 9.0
  - JDK 1.8

## 📋 System Requirements

- JDK 1.8 or higher
- MySQL 8.0 or higher
- Apache Tomcat 9.0
- Maven 3.8.1 or higher
- IDE (Eclipse/IntelliJ IDEA)

## 🚀 Installation Guide

### 1. Clone the Project

```bash
git clone https://github.com/TranKienCuong2003/MilkTea.git
cd MilkTea
```

### 2. Database Configuration

1. Create a new database in MySQL:

```sql
CREATE DATABASE [TeaShop]
GO
USE [TeaShop]
GO
```

2. Import database file:

```bash
mysql -u your_username -p milk_tea_shop < database/MilkTea.sql
```

### 3. Maven Configuration

1. Open `pom.xml` and check dependencies
2. Run Maven to download dependencies:

```bash
mvn clean install
```

### 4. Tomcat Configuration

1. Download and install Apache Tomcat 9.0
2. In Eclipse:
   - Window > Preferences > Server > Runtime Environments
   - Add > Apache Tomcat v9.0
   - Select Tomcat installation directory
   - Apply and Close

### 5. Import Project into Eclipse

1. File > Import > Maven > Existing Maven Projects
2. Select project directory
3. Wait for Maven to download dependencies
4. Clean and Build project

### 6. Run the Project

1. Right-click project > Run As > Run on Server
2. Select Tomcat 9.0
3. Finish

## 📁 Project Structure

```
milk-tea-shop/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── api/            # REST API endpoints
│   │   │   ├── beans/          # Model classes
│   │   │   ├── controller/     # MVC Controllers
│   │   │   ├── dao/           # Data Access Objects
│   │   │   ├── interceptor/   # Request interceptors
│   │   │   ├── service/       # Business logic
│   │   │   └── utils/         # Utility classes
│   │   ├── resources/
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── views/
│   │       └── resources/
│   └── test/
├── database/
│   └── MilkTea.sql
├── pom.xml
└── README.md
```

## 📧 Contact

- Email: trankiencuong30072003@gmail.com
- Phone: 0369702376

## 📄 License

This project is developed for educational and research purposes.
