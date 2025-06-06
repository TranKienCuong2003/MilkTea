<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ - Milk Tea Shop</title>
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/milk-tea-logo.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
    	html, body {
    	height: 100%;
	}
    body {
        background-color: #f5f5f5;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        min-height: 100vh;
	    display: flex;
	    flex-direction: column;
	    padding-top: 70px;
      }
	.footer {
	    margin-top: auto;
	    width: 100%;
	    }
      .nav-link {
            color: #2d3436;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: color 0.3s ease;
        }
        .nav-link:hover {
            color: #0984e3;
        }
      .navbar {
        background: white;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 1rem 0;
      }
      .navbar-brand {
        font-size: 1.5rem;
        font-weight: 600;
        color: #2d3436;
      }
      .navbar-brand i {
        color: #0984e3;
        margin-right: 0.5rem;
      }
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                       url('${pageContext.request.contextPath}/resources/images/background.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white;
            padding: 150px 0;
            margin-bottom: 40px;
            text-align: center;
        }
        .hero-section h1 {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        .hero-section p.lead {
            font-size: 1.5rem;
            margin-bottom: 30px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }
        .search-filter-container {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin: -50px auto 40px;
            max-width: 800px;
            position: relative;
            z-index: 10;
        }
        .search-filter-form {
            display: flex;
            gap: 18px;
            align-items: center;
        }
        .search-input {
            flex-grow: 1;
            position: relative;
        }
        .search-input .form-control {
            padding-left: 40px;
            height: 45px;
        }
        .search-input i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        .category-filter {
            min-width: 200px;
        }
        .search-button {
            height: 45px;
            padding: 0 25px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .category-section {
            padding: 40px 0;
            background-color: white;
        }
        .products-container {
            max-width: 1140px;
            margin: 0 auto;
            padding: 0 15px;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 0 15px;
        }
        .section-title {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
            color: #333;
            flex: 0 0 auto;
        }
        .search-filter-form {
            display: flex;
            gap: 10px;
            align-items: center;
            flex: 0 0 auto;
        }
        .search-input {
            position: relative;
        }
        .search-input .form-control {
            width: 200px;
            height: 38px;
            border-radius: 4px;
            padding: 8px 12px;
            border: 1px solid #ddd;
        }
        .search-input i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        .category-filter .form-select {
            width: 150px;
            height: 38px;
            border-radius: 4px;
            padding: 8px 12px;
            border: 1px solid #ddd;
        }
        .search-button {
            height: 38px;
            padding: 0 15px;
            border-radius: 4px;
            background-color: #0d6efd;
            border: none;
            color: white;
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 14px;
        }
        .search-button:hover {
            background-color: #0b5ed7;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin: 40px 0;
            transition: opacity 0.2s ease-in-out;
        }
        .product-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
            opacity: 0;
            animation: fadeIn 0.2s ease-in-out forwards;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .product-image {
            height: 200px;
            object-fit: cover;
            border-radius: 12px 12px 0 0;
            width: 100%;
        }
        .product-info {
            padding: 15px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        .product-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }
        .product-description {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 12px;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .product-category {
            color: #0d6efd;
            font-size: 0.85rem;
            margin-bottom: 8px;
        }
        .product-price {
            font-size: 1.25rem;
            color: #28a745;
            font-weight: bold;
            margin: 8px 0;
        }
        .status-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
            z-index: 1;
        }
        .btn-modern {
            background: linear-gradient(90deg, #6dd5ed 0%, #2193b0 100%);
            color: #fff;
            border: none;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1rem;
            box-shadow: 0 4px 16px rgba(33,147,176,0.12);
            padding: 10px 28px;
            margin-top: 10px;
            transition: background 0.3s, transform 0.2s, box-shadow 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none !important;
        }
        .btn-modern i {
            font-size: 1.1em;
        }
        .btn-modern:hover, .btn-modern:focus {
            background: linear-gradient(90deg, #2193b0 0%, #6dd5ed 100%);
            color: #fff;
            transform: translateY(-2px) scale(1.04);
            box-shadow: 0 8px 24px rgba(33,147,176,0.18);
            text-decoration: none !important;
        }
        .navbar {
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            padding: 0.8rem 1rem;
        }
        .navbar-brand {
            font-weight: 600;
            font-size: 1.25rem;
            color: #2d3436;
        }
        .navbar-brand i {
            color: #0984e3;
            margin-right: 0.5rem;
        }
        .nav-link {
            color: #2d3436;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: color 0.3s ease;
        }
        .nav-link:hover {
            color: #0984e3;
        }
        .user-avatar {
            font-size: 1.5rem;
            color: #0984e3;
            display: flex;
            align-items: center;
        }
        .dropdown-toggle::after {
            margin-left: 0.5rem;
        }
        .dropdown-menu {
            border: none;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border-radius: 10px;
            padding: 0.5rem;
            min-width: 200px;
        }
        .dropdown-item {
            padding: 0.7rem 1rem;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        .dropdown-item:hover {
            background-color: #f8f9fa;
            color: #0984e3;
        }
        .dropdown-item.text-danger:hover {
            background-color: #fff5f5;
            color: #dc3545;
        }
        .dropdown-divider {
            margin: 0.5rem 0;
        }
        #userDropdown {
            cursor: pointer;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            transition: background-color 0.3s ease;
        }
        #userDropdown:hover {
            background-color: #f8f9fa;
        }
        .navbar-nav .nav-link i {
            margin-right: 0.5rem;
        }
        .section-title:after {
            content: '';
            display: block;
            width: 50px;
            height: 3px;
            background-color: #007bff;
            margin: 10px auto;
        }
        .card-title {
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
        }
        .loading {
            position: relative;
            min-height: 200px;
        }
        .loading-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 2rem;
            color: #0d6efd;
            opacity: 0;
            transition: opacity 0.2s ease-in-out;
        }
        .loading .loading-overlay {
            opacity: 1;
        }
        a.btn-modern, a.btn-modern:hover, a.btn-modern:focus {
            text-decoration: none !important;
        }
        .chat-container {
            height: 300px;
            overflow-y: auto;
            padding: 15px;
            background: #fff;
            border-radius: 10px 10px 18px 18px;
            border: 1px solid #dee2e6;
            padding-bottom: 40px;
        }
        #chatMessages {
            display: flex;
            flex-direction: column;
            gap: 10px;
            min-height: 100px;
        }
        .chat-message {
            display: flex;
            flex-direction: column;
            margin-bottom: 18px;
            width: 100%;
            max-width: 100%;
            align-items: stretch;
        }
        .chat-message.user {
            align-items: flex-end;
            margin-left: auto;
            margin-right: 0;
        }
        .chat-message.bot {
            margin-right: 20%;
            margin-left: 0;
        }
        .chat-row-user {
            display: flex;
            align-items: center;
            flex-direction: row-reverse;
            justify-content: flex-end;
            gap: 10px;
            width: auto;
        }
        .chat-row-bot {
            display: flex;
            align-items: center;
            flex-direction: row;
            justify-content: flex-start;
            gap: 10px;
            width: 100%;
        }
        .chat-name {
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 2px;
            color: #1976d2;
            width: 100%;
            display: flex;
            align-items: center;
        }
        .chat-message.user .chat-name {
            color: #28a745;
            justify-content: flex-end;
            text-align: right;
            padding-right: 80px;
        }
        .chat-message.bot .chat-name {
            justify-content: flex-start;
            text-align: left;
            padding-left: 62px;
        }
        .chat-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #e3f2fd;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            color: #1976d2;
            box-shadow: 0 2px 8px rgba(33,147,176,0.10);
            flex-shrink: 0;
        }
        .chat-message.user .chat-avatar {
            background: #e8f5e9;
            color: #28a745;
        }
        .chat-bubble {
            padding: 12px 18px;
            border-radius: 18px;
            background: #f1f8fe;
            color: #222;
            font-size: 15px;
            border: 1px solid #e3eaf1;
            box-shadow: 0 2px 8px rgba(33,147,176,0.05);
            min-width: 40px;
            min-height: 24px;
            white-space: pre-line;
            max-width: 80%;
            display: flex;
            align-items: center;
        }
        .chat-message.user .chat-bubble {
            background: linear-gradient(90deg, #36d1c4 0%, #1976d2 100%);
            color: #fff;
            border: 1px solid #36d1c4;
        }
        .chat-message.bot .chat-bubble {
            background: #f1f8fe;
            color: #222;
            border: 1px solid #e3eaf1;
        }
        .chat-input .form-control {
            height: 48px;
            border-radius: 12px;
            font-size: 1.1rem;
            box-shadow: none;
            border: 1.5px solid #e3eaf1;
        }
        .chat-input .btn {
            height: 48px;
            border-radius: 12px;
            font-size: 1.3rem;
            padding: 0 22px;
            background: linear-gradient(90deg, #36d1c4 0%, #1976d2 100%);
            border: none;
            color: #fff;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(33,147,176,0.10);
            transition: background 0.2s;
        }
        .chat-input .btn:hover {
            background: linear-gradient(90deg, #1976d2 0%, #36d1c4 100%);
            color: #fff;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container text-center">
            <h1>Chào mừng đến với Milk Tea Shop</h1>
            <p class="lead">Khám phá thế giới trà sữa tuyệt vời của chúng tôi</p>
        </div>
    </div>

    <!-- Products Section -->
    <section class="py-5">
        <div class="products-container">
            <div class="section-header">
                <h2 class="section-title">Sản phẩm nổi bật</h2>
                <form action="${pageContext.request.contextPath}/search" method="get" class="d-flex align-items-center gap-3" id="searchForm">
                    <div class="input-group" style="height: 45px; min-width: 270px;">
                        <span class="input-group-text bg-white border-end-0">
                            <i class="fas fa-search text-secondary"></i>
                        </span>
                        <input type="text" name="keyword" class="form-control border-start-0" placeholder="Tìm kiếm sản phẩm..." value="${keyword}" style="height: 45px;">
                    </div>
                    <div style="min-width: 180px;">
                        <select name="category" class="form-select" style="height: 45px;">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.maDM}" ${cat.maDM == selectedCategory ? 'selected' : ''}>${cat.tenDM}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="search-button d-flex align-items-center px-4" style="height: 45px; min-width: 130px;">
                        <i class="fas fa-search me-2" style="font-size:1.2em;"></i>
                        <span>Tìm</span>
                    </button>
                </form>
            </div>
            
            <div class="product-grid">
                <c:choose>
                    <c:when test="${empty products}">
                        <div class="col-12 text-center">
                            <div class="alert alert-info" role="alert">
                                <i class="fas fa-info-circle me-2"></i>
                                Không tìm thấy sản phẩm ${not empty keyword ? 'với từ khóa \"'.concat(keyword).concat('\"') : ''}
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="product" items="${products}">
                            <div class="product-card">
                                <div class="position-relative">
                                    <img src="${pageContext.request.contextPath}/resources/images/${product.hinhAnh}"
                                         class="product-image" alt="${product.tenSP}">
                                    <span class="status-badge ${product.trangThai ? 'bg-success' : 'bg-danger'} text-white">
                                        ${product.trangThai ? 'Còn hàng' : 'Hết hàng'}
                                    </span>
                                </div>
                                <div class="product-info">
                                    <h5 class="product-title">${product.tenSP}</h5>
                                    <p class="product-description">${product.moTa}</p>
                                    <p class="product-category">Danh mục: ${product.tenDM}</p>
                                    <p class="product-price">
                                        <fmt:formatNumber value="${product.donGia}" type="currency" currencySymbol="đ"/>
                                    </p>
                                    <a href="${pageContext.request.contextPath}/product/detail/${product.maSP}" class="btn-modern mb-2">
                                        Xem chi tiết
                                    </a>
                                    <c:if test="${not empty loggedInUser && permission == 'khách hàng'}">
                                        <a href="#" class="btn-modern btn-add-cart" data-id="${product.maSP}">
                                            Thêm vào giỏ hàng
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <div class="modal fade modal-add-cart" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm vào giỏ hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="product-size" class="form-label">Chọn size</label>
                        <select class="form-select" id="product-size"></select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Chọn topping</label>
                        <div id="topping-checkbox-list" class="row g-2"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary btn-add-cart-submit">Thêm vào giỏ hàng</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast thông báo -->
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1055">
        <div id="toastNotify" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body" id="toastNotifyMsg">
                    <!-- Nội dung thông báo -->
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <!-- Chat Bot Modal -->
    <div class="position-fixed" style="right: 2rem; bottom: 5.5rem; z-index: 1045;">
        <button id="chatbotIcon" type="button" class="btn btn-primary btn-lg rounded-circle shadow-lg d-flex align-items-center justify-content-center" style="width: 64px; height: 64px;" data-bs-toggle="modal" data-bs-target="#chatbotModal">
            <img src="${pageContext.request.contextPath}/resources/images/chatbot.png" alt="Chatbot" style="width: 38px; height: 38px;">
        </button>
    </div>

    <div class="modal fade" id="chatbotModal" tabindex="-1" aria-labelledby="chatbotModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="chatbotModalLabel">
                        <i class="fas fa-robot me-2"></i>Milk Tea Shop Bot
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="chat-container" style="height: 300px; overflow-y: auto; padding: 15px;">
                        <div id="chatMessages" class="d-flex flex-column gap-3">
                            <!-- Messages will be added here -->
                        </div>
                    </div>
                    <div class="chat-input mt-3">
                        <div class="d-flex gap-2">
                            <input type="text" 
                                   id="userInput" 
                                   class="form-control" 
                                   placeholder="Nhập tin nhắn của bạn..."
                                   autocomplete="off">
                            <button type="button" id="sendMessage" class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Load scripts in correct order -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Script xử lý tìm kiếm và lọc danh mục -->
    <script>
        $(document).ready(function() {
            let isLoading = false;
            
            function showLoading() {
                isLoading = true;
                $('.product-grid').css('opacity', '0.5');
                if (!$('.loading-overlay').length) {
                    $('<div class="loading-overlay"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>').appendTo('.products-container');
                }
            }
            
            function hideLoading() {
                isLoading = false;
                $('.product-grid').css('opacity', '1');
                $('.loading-overlay').fadeOut(200, function() {
                    $(this).remove();
                });
            }
            
            function loadProducts() {
                if (isLoading) return;
                
                showLoading();
                const keyword = $('input[name="keyword"]').val();
                const category = $('select[name="category"]').val();
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/search',
                    type: 'GET',
                    data: {
                        keyword: keyword,
                        category: category
                    },
                    success: function(response) {
                        const newContent = $(response).find('.product-grid').html();
                        if (newContent) {
                            $('.product-grid').html(newContent);
                        }
                        hideLoading();
                    },
                    error: function() {
                        showToast('Có lỗi xảy ra khi tải dữ liệu!', true);
                        hideLoading();
                    }
                });
            }
            
            // Xử lý khi thay đổi danh mục
            $('select[name="category"]').on('change', function(e) {
                e.preventDefault();
                loadProducts();
            });
            
            // Xử lý khi submit form tìm kiếm
            $('#searchForm').on('submit', function(e) {
                e.preventDefault();
                loadProducts();
            });
        });
    </script>
    
    <!-- Chat bot script -->
    <script>
        // Lấy tên người dùng từ session (JSP render ra JS)
        var userName = '<%= session.getAttribute("loggedInUser") != null ? ((beans.User)session.getAttribute("loggedInUser")).getUsername() : "Bạn" %>';
        $(document).ready(function() {
            function addMessage(message, isUser = false) {
                // Tạo messageDiv với class đúng
                const messageDiv = document.createElement('div');
                messageDiv.className = isUser ? 'chat-message user' : 'chat-message bot';
                // Tên
                const nameDiv = document.createElement('div');
                nameDiv.className = 'chat-name';
                nameDiv.textContent = isUser ? userName : 'Milk Tea Bot';
                // Hàng chứa avatar + bubble
                const rowDiv = document.createElement('div');
                rowDiv.className = isUser ? 'chat-row-user' : 'chat-row-bot';
                // Avatar
                const avatarDiv = document.createElement('div');
                avatarDiv.className = 'chat-avatar';
                avatarDiv.innerHTML = isUser ? '<i class="fas fa-user"></i>' : '<i class="fas fa-robot"></i>';
                // Nội dung
                const contentDiv = document.createElement('div');
                contentDiv.className = 'chat-bubble';
                contentDiv.textContent = message;
                // Gắn vào rowDiv
                if (isUser) {
                    rowDiv.appendChild(avatarDiv);
                    rowDiv.appendChild(contentDiv);
                } else {
                    rowDiv.appendChild(avatarDiv);
                    rowDiv.appendChild(contentDiv);
                }
                // Gắn vào messageDiv
                messageDiv.appendChild(nameDiv);
                messageDiv.appendChild(rowDiv);
                document.getElementById('chatMessages').appendChild(messageDiv);
                // Scroll to bottom
                const chatContainer = document.querySelector('.chat-container');
                chatContainer.scrollTop = chatContainer.scrollHeight;
            }

            function addTypingIndicator() {
                const indicator = $('<div class="typing-indicator">')
                    .html(`
                        <div class="typing-dot"></div>
                        <div class="typing-dot"></div>
                        <div class="typing-dot"></div>
                    `);
                $('#chatMessages').append(indicator);
                
                // Scroll to bottom
                const chatContainer = $('.chat-container');
                chatContainer.scrollTop(chatContainer[0].scrollHeight);
                return indicator;
            }

            async function getBotResponse(userMessage) {
                try {
                    const response = await fetch('${pageContext.request.contextPath}/api/chatbot/send', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ message: userMessage })
                    });

                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }

                    const data = await response.json();
                    console.log('getBotResponse data:', data);
                    if (data.error) {
                        throw new Error(data.error);
                    }
                    return data.message;
                } catch (error) {
                    console.error('Error:', error);
                    throw error;
                }
            }

            // Xử lý khi nhấn nút gửi
            $('#sendMessage').on('click', async function() {
                const message = $('#userInput').val().trim();
                if (!message) return;

                // Disable input và button
                $('#userInput').prop('disabled', true);
                $('#sendMessage').prop('disabled', true);

                // Hiển thị tin nhắn của user
                addMessage(message, true);
                $('#userInput').val('');

                // Hiển thị typing indicator
                const typingIndicator = addTypingIndicator();

                try {
                    // Lấy và hiển thị câu trả lời của bot
                    const response = await getBotResponse(message);
                    typingIndicator.remove();
                    addMessage(response, false);
                } catch (error) {
                    console.error('Error:', error);
                    typingIndicator.remove();
                    addMessage('Xin lỗi, có lỗi xảy ra. Vui lòng thử lại sau.', false);
                } finally {
                    // Enable lại input và button
                    $('#userInput').prop('disabled', false).focus();
                    $('#sendMessage').prop('disabled', false);
                }
            });

            // Xử lý khi nhấn Enter
            $('#userInput').on('keypress', function(e) {
                if (e.which === 13) {
                    $('#sendMessage').click();
                }
            });

            // Auto-focus input khi mở modal
            $('#chatbotModal').on('shown.bs.modal', function() {
                // Nếu chưa có tin nhắn nào thì thêm câu chào đầu tiên
                if ($('#chatMessages').children().length === 0) {
                    addMessage('Xin chào! Tôi là Milk Tea Bot. Tôi có thể giúp gì cho bạn?', false);
                }
                $('#userInput').focus();
            });
        });
    </script>
    <script>
        function showToast(message, isError = false) {
            const toast = document.getElementById('toastNotify');
            const toastMsg = document.getElementById('toastNotifyMsg');
            toastMsg.textContent = message;
            if (isError) {
                toast.classList.remove('text-bg-success');
                toast.classList.add('text-bg-danger');
            } else {
                toast.classList.remove('text-bg-danger');
                toast.classList.add('text-bg-success');
            }
            const bsToast = new bootstrap.Toast(toast);
            bsToast.show();
        }

        async function getListSizes() {
            return $.ajax({
                url: "/MilkTea/api/size",
                dataType: "json",
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                }
            });
        }

        async function getListToppings() {
            return $.ajax({
                url: "/MilkTea/api/topping",
                dataType: "json",
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                }
            });
        }

        async function getCountCart() {
            return $.ajax({
                url: "/MilkTea/api/cart",
                dataType: "json",
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                }
            });
        }

        async function setCountCart() {
            try {
                let carts = await getCountCart();
                $('#countCart').html(carts.length);
            } catch (error) {
                console.error('Error getting cart count:', error);
            }
        }

        $(document).ready(function() {
            setCountCart();

            $('.btn-add-cart').on('click', async function(e) {
                e.preventDefault();
                let btn = $(this);
                try {
                    // Load size
                    let sizes = await getListSizes();
                    $('#product-size').html('');
                    let sizesDiv = document.getElementById("product-size");
                    sizes.forEach(size => {
                        const option = document.createElement("option");
                        option.setAttribute('value', size.maSize);
                        option.textContent = size.tenSize;
                        sizesDiv.appendChild(option);
                    });
                    // Load topping
                    let toppings = await getListToppings();
                    let toppingListDiv = document.getElementById("topping-checkbox-list");
                    toppingListDiv.innerHTML = '';
                    toppings.forEach(topping => {
                        const col = document.createElement('div');
                        col.className = 'col-6';
                        const checkboxDiv = document.createElement('div');
                        checkboxDiv.className = 'form-check';
                        const checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.className = 'form-check-input';
                        checkbox.id = 'topping-' + topping.maTopping;
                        checkbox.value = topping.maTopping;
                        const label = document.createElement('label');
                        label.className = 'form-check-label';
                        label.htmlFor = checkbox.id;
                        label.textContent = topping.tenTopping + ' (' + topping.donGia + 'đ)';
                        checkboxDiv.appendChild(checkbox);
                        checkboxDiv.appendChild(label);
                        col.appendChild(checkboxDiv);
                        toppingListDiv.appendChild(col);
                    });
                    $('.modal-add-cart').modal('show');
                    $('.btn-add-cart-submit').attr('data-id', btn.attr('data-id'));
                } catch (error) {
                    console.error('Error loading size/topping:', error);
                    showToast('Có lỗi xảy ra khi tải dữ liệu!', true);
                }
            });

            $('.btn-add-cart-submit').on('click', async function(e) {
                e.preventDefault();
                let btn = $(this);
                let data = {
                    'product': btn.attr('data-id'),
                    'size': $('#product-size').val(),
                    'toppings': []
                };
                // Lấy topping đã chọn
                $('#topping-checkbox-list input[type=checkbox]:checked').each(function() {
                    data.toppings.push($(this).val());
                });
                try {
                    await $.ajax({
                        url: "/MilkTea/api/cart",
                        dataType: "json",
                        method: "POST",
                        data: JSON.stringify(data),
                        headers: {
                            "Content-Type": "application/json"
                        }
                    });
                    showToast('Thêm vào giỏ hàng thành công!');
                    $('.modal-add-cart').modal('hide');
                    await setCountCart();
                } catch (error) {
                    console.error('Error adding to cart:', error);
                    showToast('Có lỗi xảy ra khi thêm vào giỏ hàng!', true);
                }
            });
        });
    </script>
</body>
</html> 