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
    <c:if test="${_csrf != null}">
      <meta name="_csrf" content="${_csrf.token}"/>
      <meta name="_csrf_header" content="${_csrf.headerName}"/>
    </c:if>
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
                                    <a href="#" class="btn-action btn-delete btn-remove-product" data-index="${index}">
                                        <i class="fas fa-trash me-1"></i>Xóa
                                    </a>
                                </td>
                            </tr>
                            <c:set var="index" value="${index + 1 }" />
                        </c:forEach>
                    </tbody>
                </table>
                <div class="row align-items-center mt-3">
                    <div class="col-md-6 d-flex flex-column justify-content-center">
                        <div class="d-flex align-items-center fs-5 mb-2">
                            <i class="fas fa-shopping-basket me-2 text-primary"></i>
                            <span>Có ${count} sản phẩm trong giỏ hàng</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/voucher/view" class="d-flex align-items-center fs-5 text-decoration-underline text-info mb-2" style="cursor:pointer;">
                            <i class="fas fa-ticket-alt me-2"></i>Danh sách Voucher
                        </a>
                        <div class="d-flex align-items-center fs-5 text-secondary">
                            <i class="fas fa-headset me-2"></i>Liên hệ: (+84) 369702376
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card shadow-sm mb-3">
                            <div class="card-body">
                                <c:if test="${not empty vouchers}">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="fw-semibold">Giá trước khi giảm:</span>
                                        <span class="product-price text-primary fw-bold">
                                            <fmt:formatNumber value="${totalBeforeDiscount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </span>
                                    </div>
                                    <div class="d-flex align-items-center mb-2">
                                        <span class="fw-semibold me-2">Voucher đã áp dụng:</span>
                                        <div>
                                            <c:forEach var="voucher" items="${vouchers}">
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
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="fw-semibold">Giảm giá:</span>
                                        <span class="product-price text-danger fw-bold">
                                            -<fmt:formatNumber value="${totalDiscount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </span>
                                    </div>
                                </c:if>
                                <c:if test="${empty vouchers}">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="fw-semibold">Tổng tiền sản phẩm:</span>
                                        <span class="product-price text-primary fw-bold">
                                            <fmt:formatNumber value="${grandTotal}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </span>
                                    </div>
                                    <div class="row align-items-center mb-2">
                                        <div class="col-auto text-secondary small d-flex align-items-center">
                                            <i class="fas fa-gift me-2 text-warning"></i>
                                            <span>Bạn có mã giảm giá?</span>
                                        </div>
                                        <div class="col">
                                            <div class="input-group" style="max-width: 350px; float: right;">
                                                <input type="text" class="form-control" id="voucherInput" placeholder="Nhập mã voucher">
                                                <button class="btn btn-outline-primary" id="applyVoucherBtn" type="button">Áp dụng</button>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-end mt-3 mb-4">
                    <div class="col-md-6 text-end">
                        <div class="card shadow border-primary border-2">
                            <div class="card-body text-center">
                                <c:if test="${not empty vouchers}">
                                    <span class="fs-4 fw-bold text-success">Tổng cộng sau giảm:</span>
                                    <span class="fs-4 fw-bold text-success ms-2">
                                        <fmt:formatNumber value="${totalAfterDiscount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                    </span>
                                </c:if>
                                <c:if test="${empty vouchers}">
                                    <span class="fs-4 fw-bold text-primary">Tổng tiền:</span>
                                    <span class="fs-4 fw-bold text-primary ms-2">
                                        <fmt:formatNumber value="${grandTotal}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                    </span>
                                </c:if>
                            </div>
                        </div>
                        <button class="btn btn-primary btn-lg px-5 fw-bold mt-3 btn-pay" style="border-radius: 12px; min-width: 220px;" type="button">
                            <i class="fas fa-shopping-cart me-2"></i>Mua ngay
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <div class="modal modal-pay" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title">
          <i class="fas fa-user-edit me-2"></i>Thông tin đặt hàng
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3 text-secondary small">
          Vui lòng nhập đầy đủ thông tin để đặt hàng.
        </div>
        <div class="mb-3">
          <label for="name" class="form-label">Họ và tên</label>
          <input type="text" id="name" name="name" class="form-control rounded-3" placeholder="Nhập họ và tên">
        </div>
        <div class="mb-3">
          <label for="phone" class="form-label">Số điện thoại</label>
          <input type="tel" id="phone" name="phone" class="form-control rounded-3" placeholder="Nhập số điện thoại">
        </div>
        <div class="mb-3">
          <label for="address" class="form-label">Địa chỉ</label>
          <input type="text" id="address" name="address" class="form-control rounded-3" placeholder="Nhập địa chỉ">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success btn-pay-submit px-4 fw-bold">
          <i class="fas fa-check me-2"></i>Đặt hàng
        </button>
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
$(document).ready(function() {
    let voucherToRemove = null;
    $(document).on('click', '.btn-remove-voucher', function() {
        voucherToRemove = $(this).data('voucher');
        $('#confirmRemoveVoucherModal').modal('show');
    });
    $('#btn-confirm-remove-voucher').off('click').on('click', function() {
        console.log('Voucher to remove:', voucherToRemove);
        if (voucherToRemove) {
            $.ajax({
                url: '/MilkTea/cart/remove-voucher/' + voucherToRemove,
                method: 'POST',
                success: function(res) {
                    console.log('Xóa voucher thành công:', res);
                    location.reload();
                },
                error: function(xhr) {
                    showToast('Có lỗi xảy ra khi xóa voucher! ' + xhr.status, true);
                    console.error('Lỗi xóa voucher:', xhr);
                }
            });
            $('#confirmRemoveVoucherModal').modal('hide');
            voucherToRemove = null;
        }
    });
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
<!-- Modal xác nhận xóa voucher -->
<div class="modal fade" id="confirmRemoveVoucherModal" tabindex="-1" aria-labelledby="confirmRemoveVoucherLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="confirmRemoveVoucherLabel">Xác nhận xóa voucher</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>
      <div class="modal-body">
        Bạn có chắc chắn muốn xóa voucher này không?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
        <button type="button" class="btn btn-danger" id="btn-confirm-remove-voucher">Xóa</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal xác nhận xóa sản phẩm -->
<div class="modal fade" id="confirmRemoveProductModal" tabindex="-1" aria-labelledby="confirmRemoveProductLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="confirmRemoveProductLabel">Xác nhận xóa sản phẩm</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>
      <div class="modal-body">
        Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
        <button type="button" class="btn btn-danger" id="btn-confirm-remove-product">Xóa</button>
      </div>
    </div>
  </div>
</div>
<script>
let productToRemove = null;
$(document).on('click', '.btn-remove-product', function(e) {
    e.preventDefault();
    productToRemove = $(this).data('index');
    $('#confirmRemoveProductModal').modal('show');
});
$('#btn-confirm-remove-product').on('click', function() {
    if (productToRemove !== null) {
        window.location.href = '/MilkTea/cart/delete/' + productToRemove;
        $('#confirmRemoveProductModal').modal('hide');
        productToRemove = null;
    }
});
</script>
<script>
// CSRF cho mọi AJAX
var csrfToken = $('meta[name="_csrf"]').attr('content');
var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
$.ajaxSetup({
    beforeSend: function(xhr) {
        if (csrfToken && csrfHeader) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        }
    }
});
</script>
</body>
</html> 