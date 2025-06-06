<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Chi tiết đơn hàng - Milk Tea Shop</title>
    <link
      rel="shortcut icon"
      type="image/png"
      href="${pageContext.request.contextPath}/resources/images/milk-tea-logo.png"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      html,
      body {
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
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
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
        box-shadow: 0 0 0 0.2rem rgba(9, 132, 227, 0.25);
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
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
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
          <i class="fas fa-list"></i> Chi tiết đơn hàng
        </h1>

        <div
          class="search-bar d-flex justify-content-between align-items-center"
        ></div>

        <div class="product-table">
          <table class="table">
            <thead>
              <tr>
                <th>Sản phẩm</th>
                <th>Đơn giá</th>
                <th>Size</th>
                <th>Topping</th>
                <th>Thành tiền</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="orderDetail" items="${orderDetails}">
                <tr>
                  <td>${ orderDetail.productName }</td>
                  <td>
                    <div class="product-price">
                      <fmt:formatNumber
                        value="${orderDetail.donGia}"
                        type="currency"
                        currencySymbol="đ"
                      />
                    </div>
                  </td>
                  <td>
                    <div class="product-name">${orderDetail.size}</div>
                  </td>
                  <td>
                    <div class="product-name">${orderDetail.topping}</div>
                  </td>
                  <td>
                    <div class="product-price">
                      <fmt:formatNumber
                        value="${orderDetail.thanhTien}"
                        type="currency"
                        currencySymbol="đ"
                      />
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
          <div class="p-4">
            <c:if test="${not empty order.vouchers}">
              <div
                class="d-flex justify-content-end mb-2 text-success align-items-center"
              >
                <strong class="me-3">Voucher đã áp dụng:</strong>
                <c:forEach var="vcode" items="${order.vouchers}">
                  <span class="badge bg-info text-dark me-2">${vcode}</span>
                </c:forEach>
              </div>
              <div class="d-flex justify-content-end mb-2 text-success">
                <strong class="me-3">Giảm giá:</strong>
                <span
                  >-<fmt:formatNumber
                    value="${order.discountAmount}"
                    type="currency"
                    currencySymbol="₫"
                /></span>
              </div>
            </c:if>
            <div class="d-flex justify-content-end mb-2">
              <strong class="me-3">Tổng tiền:</strong>
              <span class="product-price fs-4 text-primary fw-bold">
                <fmt:formatNumber
                  value="${order.thanhTien}"
                  type="currency"
                  currencySymbol="₫"
                />
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      let isLoading = false;

      function showLoading() {
        isLoading = true;
        $(".product-table").css("opacity", "0.5");
        if (!$(".loading-overlay").length) {
          $(
            '<div class="loading-overlay"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>'
          ).appendTo(".main-content");
        }
      }

      function hideLoading() {
        isLoading = false;
        $(".product-table").css("opacity", "1");
        $(".loading-overlay").fadeOut(200, function () {
          $(this).remove();
        });
      }

      function loadProducts() {
        if (isLoading) return;

        showLoading();
        const keyword = $('input[name="keyword"]').val();
        const category = $('.search-input select[name="category"]').val();

        $.ajax({
          url: "${pageContext.request.contextPath}/product/search",
          type: "GET",
          data: {
            keyword: keyword,
            category: category,
          },
          success: function (response) {
            const newContent = $(response).find(".product-table").html();
            if (newContent) {
              $(".product-table").html(newContent);
            }
            hideLoading();
          },
          error: function () {
            showToast("Có lỗi xảy ra khi tải dữ liệu!", true);
            hideLoading();
          },
        });
      }

      // Xử lý khi thay đổi danh mục
      $('.search-input select[name="category"]').on("change", function (e) {
        e.preventDefault();
        loadProducts();
      });

      // Xử lý khi submit form tìm kiếm
      $("#searchForm").on("submit", function (e) {
        e.preventDefault();
        loadProducts();
      });

      // Thêm CSS cho loading overlay
      $("<style>")
        .text(
          `
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
            `
        )
        .appendTo("head");
    </script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
      async function getCountCart() {
        return $.ajax({
          url: "/MilkTea/api/cart",
          dataType: "json",
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
          success: (rs) => {
            return rs;
          },
          error: (rs) => {
            return rs;
          },
        });
      }

      async function setCountCart() {
        let carts = await getCountCart();
        $("#countCart").html(carts.length);
      }

      setCountCart();
    </script>
    <!-- Toast thông báo -->
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1055">
      <div
        id="toastNotify"
        class="toast align-items-center text-bg-success border-0"
        role="alert"
        aria-live="assertive"
        aria-atomic="true"
      >
        <div class="d-flex">
          <div class="toast-body" id="toastNotifyMsg"></div>
          <button
            type="button"
            class="btn-close btn-close-white me-2 m-auto"
            data-bs-dismiss="toast"
            aria-label="Close"
          ></button>
        </div>
      </div>
    </div>
    <script>
      function showToast(msg, isError = false) {
        const toastEl = document.getElementById("toastNotify");
        const toastMsg = document.getElementById("toastNotifyMsg");
        toastMsg.innerText = msg;
        toastEl.classList.remove("text-bg-success", "text-bg-danger");
        toastEl.classList.add(isError ? "text-bg-danger" : "text-bg-success");
        const toast = new bootstrap.Toast(toastEl, { delay: 1000 });
        toast.show();
      }
    </script>
  </body>
</html>
