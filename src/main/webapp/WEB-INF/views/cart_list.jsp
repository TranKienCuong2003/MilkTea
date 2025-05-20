<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng - Milk Tea Shop</title>
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/milk-tea-logo.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
        .main-content {
            padding: 2rem 0;
        }
        .page-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: #2d3436;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .page-title i {
            color: #0984e3;
        }
        .search-bar {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }
        .search-input {
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            padding: 0.75rem 1rem;
            width: 300px;
        }
        .search-input:focus {
            border-color: #0984e3;
            box-shadow: 0 0 0 0.2rem rgba(9,132,227,0.25);
        }
        .btn-search {
            background: #0984e3;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-search:hover {
            background: #0773c5;
            transform: translateY(-1px);
        }
        .btn-add {
            background: #00b894;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .btn-add:hover {
            background: #00a38c;
            color: white;
            transform: translateY(-1px);
        }
        .product-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #2d3436;
            border-bottom: 2px solid #e9ecef;
            padding: 1rem;
        }
        .table td {
            padding: 1rem;
            vertical-align: middle;
        }
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
        }
        .product-name {
            font-weight: 500;
            color: #2d3436;
            margin-bottom: 0.25rem;
        }
        .product-category {
            color: #636e72;
            font-size: 0.9rem;
        }
        .product-price {
            font-weight: 600;
            color: #00b894;
        }
        .product-quantity {
            font-weight: 500;
            color: #2d3436;
        }
        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.9rem;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .btn-edit {
            background: #0984e3;
            color: white;
            margin-right: 0.5rem;
        }
        .btn-delete {
            background: #d63031;
            color: white;
        }
        .btn-action:hover {
            opacity: 0.9;
            color: white;
            transform: translateY(-1px);
        }
        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            white-space: nowrap;
        }
        .status-active {
            background: #e1f6ed;
            color: #00b894;
        }
        .status-inactive {
            background: #ffe9e9;
            color: #d63031;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="main-content">
        <div class="container">
            <h1 class="page-title">
                <i class="fas fa-list"></i> Giỏ hàng
            </h1>

            <div class="product-table">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Giá</th>
                            <th>Size</th>
                            <th>Topping</th>
                            <th>Thành tiền</th>
                            <th style="width: 200px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:set var="index" value="0" />
                    <c:set var="grandTotal" value="0" />
                        <c:forEach var="cart" items="${carts}">
                        
                            <tr>
                                <td>
                                	<image src="${pageContext.request.contextPath}/resources/images/${ cart.productObj.hinhAnh }" class="product-image">
                                    <div class="product-name">${cart.productObj.tenSP}</div>
                                </td>
                                <td>
                                    <div class="product-name">
                                    	<fmt:formatNumber value="${cart.productObj.donGia}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="product-name">${cart.sizeObj.tenSize} (${ cart.sizeObj.heSoGia })</div>
                                </td>
                                <td>
                                    <c:forEach var="topping" items="${cart.toppingsObj}">
                                    	<div class="product-name">${topping.tenTopping} (<fmt:formatNumber value="${ topping.donGia }" type="currency" currencySymbol="₫" groupingUsed="true"/>)</div>
                                    </c:forEach>
                                </td>
                                <td>
    <c:set var="toppingTotal" value="0" />
    <c:forEach var="topping" items="${cart.toppingsObj}">
        <c:set var="toppingTotal" value="${toppingTotal + topping.donGia}" />
    </c:forEach>

    <c:set var="basePrice" value="${cart.productObj.donGia}" />
    <c:set var="sizeRatio" value="${cart.sizeObj.heSoGia}" />
    <c:set var="totalPrice" value="${basePrice * sizeRatio + toppingTotal}" />

    <div class="product-price">
        <fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>
    </div>
    <c:set var="grandTotal" value="${grandTotal + totalPrice}" />
</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/cart/delete/${index}" 
                                       class="btn-action btn-delete"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa giỏ hàng này?');">
                                        <i class="fas fa-trash me-1"></i>Xóa
                                    </a>
                                </td>
                            </tr>
                            <c:set var="index" value="${index + 1 }" />
                        </c:forEach>
                    </tbody>
                </table>
                <div class="row justify-content-end">
                    <div class="col-lg-6 col-md-8 col-12">
                        <div class="card shadow-sm mb-3">
                            <div class="card-body">
                                <c:if test="${not empty vouchers}">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="fw-semibold">Giá trước khi giảm:</span>
                                        <span class="product-price text-primary fw-bold">
                                            <fmt:formatNumber value="${totalBeforeDiscount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </span>
                                    </div>
                                    <div class="mb-2">
                                        <span class="fw-semibold">Voucher đã áp dụng:</span>
                                        <div class="mt-2">
                                            <c:forEach var="voucher" items="${vouchers}" varStatus="status">
                                                <c:if test="${status.index == 0}">
                                                    <div class="d-inline-flex align-items-center bg-light rounded-pill px-3 py-1 me-2 mb-2 border">
                                                        <span class="badge bg-info text-dark me-2">${voucher.code}</span>
                                                        <c:choose>
                                                            <c:when test="${voucher.percentDiscount != null}">
                                                                <span class="me-2">Giảm ${voucher.percentDiscount}%</span>
                                                            </c:when>
                                                            <c:when test="${voucher.valueDiscount != null}">
                                                                <span class="me-2">Giảm <fmt:formatNumber value="${voucher.valueDiscount}" type="currency" currencySymbol="₫"/></span>
                                                            </c:when>
                                                        </c:choose>
                                                        <button class="btn btn-sm btn-danger btn-remove-voucher ms-1" data-voucher="${voucher.code}"><i class="fas fa-times"></i></button>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="fw-semibold">Giảm giá:</span>
                                        <span class="product-price text-danger fw-bold">
                                            -<fmt:formatNumber value="${totalDiscount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="fs-5 fw-bold">Tổng cộng sau giảm:</span>
                                        <span class="product-price text-success fs-5 fw-bold">
                                            <fmt:formatNumber value="${totalAfterDiscount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </span>
                                    </div>
                                </c:if>
                                <c:if test="${empty vouchers}">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="fs-5 fw-bold">Tổng tiền:</span>
                                        <span class="product-price fs-5 fw-bold" data-total="${grandTotal}" id="total">
                                            <fmt:formatNumber value="${grandTotal}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </span>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row align-items-center mt-3">
                  <div class="col-md-6 col-12 mb-2 mb-md-0">
                    <c:if test="${empty vouchers}">
                      <div class="input-group">
                        <input type="text" id="voucherInput" class="form-control" placeholder="Nhập mã voucher">
                        <button class="btn btn-success" id="applyVoucherBtn">Áp dụng</button>
                      </div>
                    </c:if>
                  </div>
                  <div class="col-md-6 col-12 text-md-end">
                    <div class="card shadow-sm">
                      <div class="card-body py-2 px-3">
                        <c:if test="${not empty vouchers}">
                          <span class="fs-5 fw-bold">Tổng cộng sau giảm:</span>
                          <span class="product-price fs-5 fw-bold" data-total="${totalAfterDiscount}" id="total">
                            <fmt:formatNumber value="${totalAfterDiscount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                          </span>
                        </c:if>
                        <c:if test="${empty vouchers}">
                          <span class="fs-5 fw-bold">Tổng tiền:</span>
                          <span class="product-price fs-5 fw-bold" data-total="${grandTotal}" id="total">
                            <fmt:formatNumber value="${grandTotal}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                          </span>
                        </c:if>
                      </div>
                    </div>
                  </div>
                </div>
                <c:if test="${ count > 0 }">
                    <div class="text-end mt-3">
                    <button class="btn btn-primary btn-pay">Mua</button>
                </div>
                </c:if>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <div class="modal modal-pay" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Thanh toán</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <label for="name" class="form-label">Họ và tên</label>
          <input type="text" id="name" name="name" class="form-control"
                       placeholder="Nhập họ và tên">
          <label for="phone" class="form-label">Số điện thoại</label>
          <input type="tel" id="phone" name="phone" class="form-control"
                       placeholder="Nhập số điện thoại">
                       <label for="address" class="form-label">Địa chỉ</label>
          <input type="text" id="address" name="address" class="form-control"
                       placeholder="Nhập địa chỉ">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary btn-pay-submit">Thanh toán</button>
      </div>
    </div>
  </div>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        let isLoading = false;
        
        function showLoading() {
            isLoading = true;
            $('.product-table').css('opacity', '0.5');
            if (!$('.loading-overlay').length) {
                $('<div class="loading-overlay"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>').appendTo('.main-content');
            }
        }
        
        function hideLoading() {
            isLoading = false;
            $('.product-table').css('opacity', '1');
            $('.loading-overlay').fadeOut(200, function() {
                $(this).remove();
            });
        }
        
        function loadProducts() {
            if (isLoading) return;
            
            showLoading();
            const keyword = $('input[name="keyword"]').val();
            const category = $('.search-input select[name="category"]').val();
            
            $.ajax({
                url: '${pageContext.request.contextPath}/product/search',
                type: 'GET',
                data: {
                    keyword: keyword,
                    category: category
                },
                success: function(response) {
                    const newContent = $(response).find('.product-table').html();
                    if (newContent) {
                        $('.product-table').html(newContent);
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
        $('.search-input select[name="category"]').on('change', function(e) {
            e.preventDefault();
            loadProducts();
        });
        
        // Xử lý khi submit form tìm kiếm
        $('#searchForm').on('submit', function(e) {
            e.preventDefault();
            loadProducts();
        });
        
        // Thêm CSS cho loading overlay
        $('<style>')
            .text(`
                .loading-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(255,255,255,0.8);
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    z-index: 9999;
                }
            `)
            .appendTo('head');
    </script>
    <script>
    function validatePhone(phone) {
        const regex = /^0[35789]\d{8}$/;

        if (regex.test(phone)) {
            return "";
        } else {
        	return "Số điện thoại không hợp lệ. Vui lòng nhập đúng định dạng!";
        }
    }
    $('.btn-pay').off('click').on('click', async function(e) {
        e.preventDefault();
        $('#name').val('');
        $('#phone').val('');
        $('#address').val('');
        $('.modal-pay').modal('show');
    });
    $('.btn-pay-submit').off('click').on('click', async function(e) {
        e.preventDefault();
        if($('#name').val().trim() == ''){
            showToast('Vui lòng nhập họ và tên', true);
            return;
        }
        if($('#phone').val().trim() == ''){
            showToast('Vui lòng nhập số điện thoại', true);
            return;
        }
        if(validatePhone($('#phone').val().trim()) != ''){
            showToast(validatePhone($('#phone').val().trim()), true);
            return;
        }
        if($('#address').val().trim() == ''){
            showToast('Vui lòng nhập địa chỉ', true);
            return;
        }
        let data = {
            'ten': $('#name').val().trim(),
            'diaChi': $('#address').val().trim(),
            'sdt': $('#phone').val().trim()
        };
        $.ajax({
            url: "/MilkTea/api/order",
            dataType: "json",
            method: "POST",
            data: JSON.stringify(data),
            headers: {
                "Content-Type": "application/json"
            },
            success: (rs) => {
                showToast('Hóa đơn đã được gửi đến người quản lý');
                document.location.href = document.location.href;
            },
            error: (rs) => {
                if(rs.status == 200){
                    showToast('Hóa đơn đã được gửi đến người quản lý');
                    document.location.href = document.location.href;
                }else{
                    showToast(rs.responseText, true);
                }
            }
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
    <!-- <script>
    async function checkVoucher(voucher){
		return $.ajax({
            url: "/MilkTea/api/voucher/" + voucher,
            dataType: "json",
            method: "GET",
            headers: {
                "Content-Type": "application/json"
            },
            success: (rs) => {
                return rs;
            },
            error: (rs) => {
            	if(rs.status != 200)
            		return null;
            	return rs;
            }
        });
	}
    
    $('#applyVoucherBtn').off('click').on('click', async function(e) {
        e.preventDefault();
        if($('#voucherInput').val() != ''){
        	let voucher = await checkVoucher($('#voucherInput').val());
        	console.log(voucher);
        	if(voucher == null){
        		alert('Voucher không hợp lệ hoặc đã hết hạn');
        	}else{
        		alert('Voucher hợp lệ');
        	}
        }else{
        	alert('Bạn chưa nhập voucher');
        }
    });
    </script> -->
    <script>
    async function checkVoucher(voucher) {
        try {
            const response = await $.ajax({
                url: "/MilkTea/api/voucher/" + voucher,
                dataType: "json",
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                }
            });
            return response;
        } catch (error) {
        	console.error("Lỗi khi kiểm tra voucher:", error);
            if (error.responseText) {
                try {
                    return JSON.parse(error.responseText);
                } catch (e) {
                    console.error("Không thể parse responseText:", e);
                }
            }

            return null;
        }
    }

    $('#applyVoucherBtn').off('click').on('click', async function(e) {
        e.preventDefault();
        const voucherCode = $('#voucherInput').val().trim();
        if (voucherCode !== '') {
            const voucher = await checkVoucher(voucherCode);
            if (voucher == null) {
                showToast('Voucher không hợp lệ hoặc đã hết hạn', true);
            } else {
                // Gọi API backend để lưu voucher vào session
                $.ajax({
                    url: '/MilkTea/cart/add-voucher/' + voucherCode,
                    method: 'POST',
                    success: function() {
                        location.reload();
                    },
                    error: function() {
                        showToast('Có lỗi xảy ra khi áp dụng voucher!', true);
                    }
                });
            }
        } else {
            showToast('Bạn chưa nhập voucher', true);
        }
    });
    
    const formatCurrency = (amount) => {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
            minimumFractionDigits: 2
        }).format(amount);
    };
</script>
<script>
$(document).on('click', '.btn-remove-voucher', function() {
    const code = $(this).data('voucher');
    if (confirm('Bạn có chắc chắn muốn xóa voucher này?')) {
        $.ajax({
            url: '/MilkTea/cart/remove-voucher/' + code,
            method: 'POST',
            success: function() {
                location.reload();
            },
            error: function() {
                showToast('Có lỗi xảy ra khi xóa voucher!', true);
            }
        });
    }
});
</script>
<!-- Toast thông báo -->
<div class="position-fixed top-0 end-0 p-3" style="z-index: 1055">
  <div id="toastNotify" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="d-flex">
      <div class="toast-body" id="toastNotifyMsg"></div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
  </div>
</div>
<script>
function showToast(msg, isError = false) {
    const toastEl = document.getElementById('toastNotify');
    const toastMsg = document.getElementById('toastNotifyMsg');
    toastMsg.innerText = msg;
    toastEl.classList.remove('text-bg-success', 'text-bg-danger');
    toastEl.classList.add(isError ? 'text-bg-danger' : 'text-bg-success');
    const toast = new bootstrap.Toast(toastEl, { delay: 1000 });
    toast.show();
}
</script>
</body>
</html> 