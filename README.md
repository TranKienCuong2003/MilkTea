# MilkTea - Milk Tea Shop Management System

A comprehensive web-based management system for milk tea shops, built with Java Spring MVC. This system streamlines the entire business operation from order management to inventory control. It features a modern, user-friendly interface and robust backend architecture, making it perfect for both small and large milk tea businesses. The system includes real-time order tracking, inventory management, sales reporting, and an integrated chatbot for customer support. With role-based access control, it ensures secure and efficient operations for all staff members, from owners to baristas.

## Key Features

### 1. User Management

- Registration, login, and personal information management
- User role management (Owner, Manager, Order Staff, Cashier, Barista, Warehouse Staff, Customer)
- Session management and security

### 2. Product Management

- Add, edit, delete products
- Category management
- Product image upload
- Product detail management (ingredients, usage instructions)
- Search and filter products

### 3. Order Management

- Create new orders
- Shopping cart management
- Voucher application
- Price calculation (including size and toppings)
- Order status tracking

### 4. Inventory Management

- Material tracking
- Supplier management
- Low stock alerts
- Import/export history

### 5. Reports & Statistics

- Revenue reports
- Best-selling products statistics
- Inventory reports
- Report export

### 6. Chatbot Integration

- Automated customer support
- FAQ responses
- Product recommendations

## Technologies Used

### Backend

- Java 8
- Spring MVC 5.3.20
- MySQL Database
- Maven

### Frontend

- JSP/JSTL
- HTML/CSS/JavaScript
- Bootstrap

## Installation

1. Clone repository:

```bash
git clone https://github.com/TranKienCuong2003/MilkTea.git
```

2. Configure database:

- Create new MySQL database
- Import `database/teamilk.sql` file

3. Configure Maven:

- Open project in Maven-supported IDE
- Update dependencies

4. Run application:

- Build project with Maven
- Deploy to Tomcat server
- Access: `http://localhost:8080/MilkTea`

## Project Structure

```
MilkTea/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── controller/    # Request handling controllers
│   │   │   ├── service/       # Business logic
│   │   │   ├── dao/          # Data Access Objects
│   │   │   ├── beans/        # Model classes
│   │   │   ├── utils/        # Utility classes
│   │   │   └── interceptor/  # Request interceptors
│   │   ├── webapp/
│   │   │   ├── WEB-INF/
│   │   │   │   ├── views/    # JSP files
│   │   │   │   └── spring-servlet.xml
│   │   │   └── resources/    # Static resources
│   │   └── resources/        # Configuration files
│   └── test/                 # Test cases
├── database/
│   └── teamilk.sql          # Database schema
└── pom.xml                  # Maven configuration
```

## User Roles

1. Owner

- Full system management access
- View revenue reports
- Manage staff

2. Manager

- Product management
- Order management
- View reports

3. Order Staff

- Create orders
- Manage orders

4. Cashier

- Process payments
- Print receipts

5. Barista

- View orders
- Update order status

6. Warehouse Staff

- Inventory management
- Material import/export

7. Customer

- View products
- Place orders
- View order history

## Contributing

Contributions are welcome. Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
