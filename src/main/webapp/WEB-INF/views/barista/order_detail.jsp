<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Chi tiết đơn hàng #${order.id}</title>
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
      .order-detail-card {
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 1rem;
      }
      .order-header {
        background: #f8f9fa;
        padding: 1.5rem;
        border-radius: 12px 12px 0 0;
        border-bottom: 1px solid #dee2e6;
      }
      .order-body {
        padding: 1.5rem;
      }
      .product-item {
        padding: 1rem;
        border-bottom: 1px solid #dee2e6;
      }
      .product-item:last-child {
        border-bottom: none;
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
      .btn-complete {
        background: linear-gradient(135deg, #00b894, #00a884);
        border: none;
        padding: 0.8rem 2rem;
        font-weight: 600;
      }
      .btn-complete:hover {
        background: linear-gradient(135deg, #00a884, #009874);
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container mt-4">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Chi tiết đơn hàng #${order.id}</h2>
        <a
          href="${pageContext.request.contextPath}/barista/orders"
          class="btn btn-outline-secondary"
        >
          <i class="fas fa-arrow-left"></i> Quay lại
        </a>
      </div>

      <div class="order-detail-card">
        <div class="order-header">
          <div class="row">
            <div class="col-md-6">
              <h5 class="mb-3">Thông tin đơn hàng</h5>
              <p class="mb-1"><strong>Khách hàng:</strong> ${order.ten}</p>
              <p class="mb-1"><strong>SĐT:</strong> ${order.sdt}</p>
              <p class="mb-1"><strong>Địa chỉ:</strong> ${order.diaChi}</p>
              <p class="mb-1">
                <strong>Ngày đặt:</strong> ${order.ngayDatFormatted}
              </p>
            </div>
            <div class="col-md-6 text-md-end">
              <span class="status-badge status-waiting mb-3 d-inline-block"
                >Chờ pha chế</span
              >
              <p class="mb-1">
                <strong>Tổng tiền:</strong> ${order.thanhTien} VNĐ
              </p>
              <c:if test="${not empty order.vouchers}">
                <div>
                  <strong>Voucher đã áp dụng:</strong>
                  <span class="badge bg-info text-dark"
                    >${order.vouchers[0]}</span
                  >
                </div>
              </c:if>
            </div>
          </div>
        </div>

        <div class="order-body">
          <h5 class="mb-4">Danh sách sản phẩm</h5>

          <c:forEach items="${orderDetails}" var="detail">
            <div class="product-item">
              <div class="row align-items-center">
                <div class="col-md-6">
                  <h6 class="mb-2">${detail.productName}</h6>
                  <p class="mb-1 text-muted">Size: ${detail.size}</p>
                  <c:if test="${not empty detail.topping}">
                    <p class="mb-0 text-muted">Topping: ${detail.topping}</p>
                  </c:if>
                </div>
                <div class="col-md-6 text-md-end">
                  <p class="mb-0">
                    <strong>Thành tiền:</strong> ${detail.thanhTien} VNĐ
                  </p>
                </div>
              </div>
            </div>
          </c:forEach>

          <div class="text-center mt-4">
            <form
              action="${pageContext.request.contextPath}/barista/orders/${order.id}/complete"
              method="post"
            >
              <button type="submit" class="btn btn-complete text-white">
                <i class="fas fa-check"></i> Hoàn thành pha chế
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/your-font-awesome-kit.js"></script>
  </body>
</html>
