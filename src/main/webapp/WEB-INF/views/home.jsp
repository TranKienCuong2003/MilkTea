<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ - Milk Tea Shop</title>
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
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin: -50px auto 40px;
            max-width: 800px;
            position: relative;
            z-index: 10;
        }
        .search-filter-form {
            display: flex;
            gap: 15px;
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
        .btn-view-detail {
            background-color: #749dde;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.3s;
            margin-top: auto;
        }
        .btn-view-detail:hover {
            background-color: #0b5ed7;
            color: white;
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
                <form action="${pageContext.request.contextPath}/search" method="get" class="search-filter-form" id="searchForm">
                    <div class="search-input">
                        <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm sản phẩm..." value="${keyword}">
                    </div>
                    <div class="category-filter">
                        <select name="category" class="form-select">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.maDM}" ${cat.maDM == selectedCategory ? 'selected' : ''}>${cat.tenDM}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="search-button">
                        <i class="fas fa-search"></i> Tìm kiếm
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
                                    <a href="${pageContext.request.contextPath}/product/detail/${product.maSP}" 
                                       class="btn-view-detail">
                                        Xem chi tiết
                                    </a>
                                    <a href="#" 
                                       class="btn-view-detail btn-add-cart mt-3" data-id="${product.maSP}">
                                        Thêm vào giỏ hàng
                                    </a>
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
    
    <div class="modal modal-add-cart" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Thêm vào giỏ hàng</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <label for="product-size" class="form-label">Chọn size</label>
          <select class="form-select" id="product-size">
          </select>
          <label class="form-label">Danh sách topping</label>
          <div id="list-topping-select" class="list-group">
          </div>
          <label for="topping" class="form-label">Chọn topping:</label>
                <input type="text" id="topping" name="topping" class="form-control"
                       placeholder="Nhập topping">
                <div id="list-topping-no-select" class="list-group"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary btn-add-cart-submit">Thêm vào giỏ hàng</button>
      </div>
    </div>
  </div>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            let isLoading = false;

            function showLoading() {
                isLoading = true;
                $('.product-grid').css('opacity', '0.5');
                $('.product-grid').addClass('loading').append('<div class="loading-overlay"><i class="fas fa-spinner fa-spin"></i></div>');
            }

            function hideLoading() {
                isLoading = false;
                $('.product-grid').css('opacity', '1');
                $('.loading-overlay').fadeOut(200, function() {
                    $(this).remove();
                });
                $('.product-grid').removeClass('loading');
            }

            function loadProducts() {
                if (isLoading) return;
                
                showLoading();
                const keyword = $('input[name="keyword"]').val();
                const category = $('.category-filter select').val();
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/search',
                    type: 'GET',
                    data: {
                        keyword: keyword,
                        category: category
                    },
                    success: function(response) {
                        setTimeout(function() {
                            const newContent = $(response).find('.product-grid').html();
                            if (newContent) {
                                $('.product-grid').html(newContent);
                            }
                            hideLoading();
                        }, 200); // Thêm delay 200ms
                    },
                    error: function() {
                        alert('Có lỗi xảy ra khi tải dữ liệu!');
                        hideLoading();
                    }
                });
            }

            // Xử lý khi thay đổi danh mục
            $('.category-filter select').on('change', function(e) {
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
    <script>
    	async function getCountCart(){
    		return $.ajax({
                url: "/MilkTea/api/cart",
                dataType: "json",
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                },
                success: (rs) => {
                    return rs;
                },
                error: (rs) => {
                	return rs;
                }
            });
    	}
    	
    	async function setCountCart(){
    		let carts = await getCountCart();
    		$('#countCart').html(carts.length);
    	}
    	
    	setCountCart();
    </script>
    <script>
    async function getListSizes() {
    	return $.ajax({
            url: "/MilkTea/api/size",
            dataType: "json",
            method: "GET",
            headers: {
                "Content-Type": "application/json"
            },
            success: (rs) => {
                return rs;
            },
            error: (rs) => {
                return rs;
            }
        });
    }
    async function getListToppings() {
        let key = $('#topping').val();
        if (key.trim() == '') {
            return $.ajax({
                url: "/MilkTea/api/topping",
                dataType: "json",
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                },
                success: (rs) => {
                    return rs;
                },
                error: (rs) => {
                    return rs;
                }
            });
        }
        return $.ajax({
            url: "/MilkTea/api/topping?name=" + key,
            dataType: "json",
            method: "GET",
            headers: {
                "Content-Type": "application/json"
            },
            success: (rs) => {
                return rs;
            },
            error: (rs) => {
                return rs;
            }
        });
    }
    
    $('#topping').off('keyup').on('keyup', async function(e) {
        e.preventDefault();
        let toppings = await getListToppings();
        const toppingsDiv = document.getElementById("list-topping-no-select");
        toppingsDiv.innerHTML = "";
        const element = document.getElementById("list-topping-select");
        let ids = [];
        if (element.hasAttribute("data-id")) {
            ids = element.getAttribute('data-id').split(';');
        }
        toppings.forEach(topping => {
            if (ids.indexOf(topping.maTopping) === -1) {
                const div = document.createElement("div");
                div.classList.add("list-group-item");
                div.classList.add("list-group-item-action");
                div.setAttribute('data-id', topping.maTopping);
                div.textContent = topping.tenTopping;
                div.onclick = () => selectTopping(topping);
                toppingsDiv.appendChild(div);
            }
        });
    });
    
    /* function selectTopping(topping) {
        document.getElementById("list-topping-no-select").innerHTML = "";
        const div = document.createElement("div");
        div.classList.add("list-group-item");
        div.classList.add("list-group-item-action");
        div.setAttribute('data-id', topping.maTopping);
        div.textContent = topping.tenTopping;
        document.getElementById("list-topping-select").appendChild(div);
        document.getElementById("topping").value = "";
        const element = document.getElementById("list-topping-select");
        if (element.hasAttribute("data-id")) {
            element.setAttribute('data-id', element.getAttribute('data-id') + ';' + topping.maTopping);
        } else {
            element.setAttribute('data-id', topping.maTopping);
        }
    } */
    
    function selectTopping(topping) {
        const element = document.getElementById("list-topping-select");

        // Tạo container cho topping
        const div = document.createElement("div");
        div.classList.add("list-group-item", "d-flex", "justify-content-between", "align-items-center");
        div.setAttribute('data-id', topping.maTopping);

        const span = document.createElement("span");
        span.textContent = topping.tenTopping;

        const btn = document.createElement("button");
        btn.innerHTML = '<i class="bi bi-trash-fill"></i>';
        btn.classList.add("btn", "btn-danger");
        btn.onclick = () => {
            div.remove(); // Xoá phần tử khỏi DOM

            // Cập nhật lại data-id
            const ids = Array.from(element.children).map(d => d.getAttribute('data-id'));
            element.setAttribute('data-id', ids.filter(id => id !== topping.maTopping).join(';'));
        };

        div.appendChild(span);
        div.appendChild(btn);

        element.appendChild(div);
        document.getElementById("topping").value = "";

        // Cập nhật thuộc tính data-id
        if (element.hasAttribute("data-id")) {
            const currentIds = element.getAttribute('data-id');
            element.setAttribute('data-id', currentIds + ';' + topping.maTopping);
        } else {
            element.setAttribute('data-id', topping.maTopping);
        }

        // Xoá gợi ý
        document.getElementById("list-topping-no-select").innerHTML = "";
    }
    
    $('.btn-add-cart').off('click').on('click', async function(e) {
        e.preventDefault();
        let btn = $(this);
        let sizes = await getListSizes();
        $('#product-size').html('');
        let sizesDiv = document.getElementById("product-size");
        sizes.forEach(size => {
        	const option = document.createElement("option");
        	option.setAttribute('value', size.maSize);
        	option.textContent = size.tenSize;
        	sizesDiv.appendChild(option);
        });
        $('#topping').val('');
        $('#list-topping-select').html('');
        $('#list-topping-no-select').html('');
        document.getElementById("list-topping-select").removeAttribute('data-id');
        $('.modal-add-cart').modal('show');
        $('.btn-add-cart-submit').attr('data-id', btn.attr('data-id'));
    });
    
    $('.btn-add-cart-submit').off('click').on('click', async function(e) {
        e.preventDefault();
        let btn = $(this);
        let productId = btn.attr('data-id');
        let data = {
        	'product': btn.attr('data-id'),
        	'size': $('#product-size').val(),
        	'toppings': []
        };
        let toppingdivs = document.getElementById("list-topping-select");
        if(toppingdivs.hasAttribute("data-id")){
        	data = {
                	'product': btn.attr('data-id'),
                	'size': $('#product-size').val(),
                	'toppings': toppingdivs.getAttribute("data-id").split(';')
                };
        }
        $.ajax({
            url: "/MilkTea/api/cart",
            dataType: "json",
            method: "POST",
            data: JSON.stringify(data),
            headers: {
                "Content-Type": "application/json"
            },
            success: (rs) => {
                alert('Thêm vào giỏ hàng thành công!');
                $('.modal-add-cart').modal('hide');
                setCountCart();
            },
            error: (rs) => {
            	if(rs.status == 200){
            		alert('Thêm vào giỏ hàng thành công!');
            		$('.modal-add-cart').modal('hide');
            		setCountCart();
            	}else{
            		console.log(rs);
                    alert('Có lỗi xảy ra!');
            	}
            }
        });
    });
    </script>
</body>
</html> 