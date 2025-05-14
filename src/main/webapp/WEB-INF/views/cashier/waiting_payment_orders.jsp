<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Xác nhận đơn thanh toán</title>
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
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="container mt-4">
      <h2 class="mb-4">Đơn hàng chờ thanh toán</h2>
      <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
          <thead class="table-light">
            <tr>
              <th>Mã đơn</th>
              <th>Khách hàng</th>
              <th>SĐT</th>
              <th>Ngày đặt</th>
              <th>Tổng tiền</th>
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
                  <a
                    href="${pageContext.request.contextPath}/cashier/orders/${order.id}/bill"
                    class="btn btn-info btn-sm me-2"
                  >
                    <i class="fas fa-receipt"></i> Xem hóa đơn
                  </a>
                  <form
                    action="${pageContext.request.contextPath}/cashier/orders/${order.id}/confirm-payment"
                    method="post"
                    style="display: inline"
                  >
                    <button
                      type="submit"
                      class="btn btn-success btn-sm"
                      onclick="return confirm('Xác nhận đơn này đã thanh toán?')"
                    >
                      Xác nhận thanh toán
                    </button>
                  </form>
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
  </body>
</html>
