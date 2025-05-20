<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Danh sách đơn hàng cần pha chế</title>
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
      .fa-shopping-cart {
        color: #2d3436 !important;
      }
      .order-card {
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 1rem;
        transition: transform 0.2s;
      }
      .order-card:hover {
        transform: translateY(-2px);
      }
      .order-header {
        background: #f8f9fa;
        padding: 1rem;
        border-radius: 12px 12px 0 0;
        border-bottom: 1px solid #dee2e6;
      }
      .order-body {
        padding: 1rem;
      }
      .search-box {
        background: white;
        padding: 1rem;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 1rem;
      }
      .filter-buttons {
        margin-bottom: 1rem;
      }
      .filter-buttons .btn {
        margin-right: 0.5rem;
      }
      .status-badge {
        font-size: 0.9rem;
        padding: 0.4rem 0.8rem;
        border-radius: 20px;
      }
      .status-waiting {
        background-color: #ffeaa7;
        color: #d35400;
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container mt-4">
      <h2 class="mb-4">Danh sách đơn hàng cần pha chế</h2>

      <!-- Search Box -->
      <div class="search-box">
        <form
          action="${pageContext.request.contextPath}/barista/orders/search"
          method="get"
          class="row g-3"
        >
          <div class="col-md-8">
            <input
              type="text"
              class="form-control"
              name="keyword"
              placeholder="Tìm theo tên khách hàng hoặc mã đơn hàng"
              value="${keyword}"
            />
          </div>
          <div class="col-md-4">
            <button type="submit" class="btn btn-primary w-100">
              Tìm kiếm
            </button>
          </div>
        </form>
      </div>

      <!-- Filter Buttons -->
      <div class="filter-buttons">
        <a
          href="${pageContext.request.contextPath}/barista/orders/filter?timeFilter=today"
          class="btn btn-outline-primary"
          >Hôm nay</a
        >
        <a
          href="${pageContext.request.contextPath}/barista/orders/filter?timeFilter=10min"
          class="btn btn-outline-primary"
          title="Chỉ hiển thị các đơn chưa pha chế của hôm nay, đã chờ hơn 10 phút"
          >Đơn hôm nay chờ hơn 10 phút</a
        >
        <a
          href="${pageContext.request.contextPath}/barista/orders/filter?timeFilter=30min"
          class="btn btn-outline-primary"
          title="Chỉ hiển thị các đơn chưa pha chế của hôm nay, đã chờ hơn 30 phút"
          >Đơn hôm nay chờ hơn 30 phút</a
        >
        <a
          href="${pageContext.request.contextPath}/barista/orders"
          class="btn btn-outline-secondary"
          >Tất cả</a
        >
      </div>
      <div class="text-muted small mb-2">
        * Các filter chỉ áp dụng cho đơn đặt trong ngày hôm nay.
      </div>

      <!-- Orders List -->
      <c:forEach items="${orders}" var="order">
        <div class="order-card">
          <div
            class="order-header d-flex justify-content-between align-items-center"
          >
            <div>
              <h5 class="mb-0">Đơn hàng #${order.id}</h5>
              <small class="text-muted">${order.ngayDatFormatted}</small>
            </div>
            <span class="status-badge status-waiting">Chờ pha chế</span>
          </div>
          <div class="order-body">
            <div class="row">
              <div class="col-md-6">
                <p class="mb-1"><strong>Khách hàng:</strong> ${order.ten}</p>
                <p class="mb-1"><strong>SĐT:</strong> ${order.sdt}</p>
              </div>
              <div class="col-md-6 text-md-end">
                <p class="mb-1">
                  <strong>Tổng tiền:</strong> ${order.thanhTien} VNĐ
                </p>
                <a
                  href="${pageContext.request.contextPath}/barista/orders/${order.id}"
                  class="btn btn-primary"
                  >Xem chi tiết</a
                >
              </div>
            </div>
          </div>
        </div>
      </c:forEach>

      <c:if test="${empty orders}">
        <div class="alert alert-info">Không có đơn hàng nào cần pha chế.</div>
      </c:if>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
