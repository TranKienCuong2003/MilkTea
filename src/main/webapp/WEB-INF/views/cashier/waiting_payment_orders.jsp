<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Danh sách hóa đơn</title>
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
      .badge.bg-success {
        background: linear-gradient(90deg, #43e97b 0%, #38f9d7 100%) !important;
        color: #fff !important;
        font-size: 1em;
        border-radius: 1em;
        padding: 0.5em 1.2em;
        box-shadow: 0 2px 8px rgba(67, 233, 123, 0.15);
      }
      .badge.bg-warning {
        background: linear-gradient(90deg, #f7971e 0%, #ffd200 100%) !important;
        color: #333 !important;
        font-size: 1em;
        border-radius: 1em;
        padding: 0.5em 1.2em;
        box-shadow: 0 2px 8px rgba(255, 210, 0, 0.15);
      }
      .btn-info {
        background: linear-gradient(90deg, #36d1c4 0%, #1976d2 100%);
        color: #fff;
        border: none;
        box-shadow: 0 2px 8px rgba(25, 118, 210, 0.15);
        transition: background 0.3s, transform 0.2s;
      }
      .btn-info:hover {
        background: linear-gradient(90deg, #1976d2 0%, #36d1c4 100%);
        color: #fff;
        transform: translateY(-2px) scale(1.04);
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="container mt-4">
      <h2 class="mb-4">Danh sách hóa đơn</h2>
      <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
          <thead class="table-light">
            <tr>
              <th>Mã đơn</th>
              <th>Khách hàng</th>
              <th>SĐT</th>
              <th>Ngày đặt</th>
              <th>Tổng tiền</th>
              <th>Trạng thái</th>
              <th>Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="order" items="${orders}">
              <tr>
                <td>#${order.id}</td>
                <td>${order.ten}</td>
                <td>${order.sdt}</td>
                <td>${order.ngayDatFormatted}</td>
                <td>${order.thanhTien} VNĐ</td>
                <td>
                  <c:choose>
                    <c:when test="${order.status == 4}">
                      <span class="badge bg-success">Đã thanh toán</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge bg-warning text-dark"
                        >Chờ thanh toán</span
                      >
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <a
                    href="${pageContext.request.contextPath}/cashier/orders/${order.id}/bill"
                    class="btn btn-info btn-sm rounded-pill shadow-sm d-inline-flex align-items-center gap-2"
                  >
                    <i class="fas fa-receipt"></i>
                    <span>Xem hóa đơn</span>
                  </a>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty orders}">
              <tr>
                <td colspan="6" class="text-center">
                  Không có đơn hàng nào chờ thanh toán.
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
        const toast = new bootstrap.Toast(toastEl, { delay: 1500 });
        toast.show();
      }
      function confirmPayment(btn) {
        const orderId = btn.getAttribute("data-order-id");
        if (!confirm("Xác nhận đơn này đã thanh toán?")) return;
        fetch(
          `${pageContext.request.contextPath}/cashier/orders/${orderId}/confirm-payment`,
          {
            method: "POST",
            headers: { "X-Requested-With": "XMLHttpRequest" },
          }
        )
          .then((res) => (res.ok ? res.text() : Promise.reject(res.status)))
          .then(() => {
            showToast("Xác nhận thanh toán thành công!");
            setTimeout(() => location.reload(), 1500);
          })
          .catch(() => {
            showToast("Có lỗi xảy ra khi xác nhận thanh toán!", true);
          });
      }
    </script>
  </body>
</html>
