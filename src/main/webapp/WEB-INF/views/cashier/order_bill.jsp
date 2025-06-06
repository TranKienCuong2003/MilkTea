<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Hóa đơn #${order.id}</title>
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
      .bill-container {
        max-width: 800px;
        margin: 20px auto;
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      }
      .bill-header {
        text-align: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 2px dashed #ddd;
      }
      .bill-title {
        color: #2d3436;
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 10px;
      }
      .bill-info {
        margin-bottom: 20px;
      }
      .bill-items {
        margin-bottom: 20px;
      }
      .bill-total {
        text-align: right;
        font-size: 18px;
        font-weight: bold;
        margin-top: 20px;
        padding-top: 20px;
        border-top: 2px dashed #ddd;
      }
      .print-button {
        margin-top: 20px;
      }
      @media print {
        body {
          padding-top: 0;
        }
        .no-print {
          display: none;
        }
        .bill-container {
          box-shadow: none;
          margin: 0;
          padding: 20px;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
      <div class="bill-container">
        <div class="bill-header">
          <h1 class="bill-title">MILK TEA SHOP</h1>
          <p>Hóa đơn thanh toán</p>
          <p>Mã đơn: #${order.id}</p>
          <p>Ngày: ${order.ngayDatFormatted}</p>
        </div>

        <div class="bill-info">
          <h5>Thông tin khách hàng:</h5>
          <p>Tên: ${order.ten}</p>
          <p>SĐT: ${order.sdt}</p>
          <p>Địa chỉ: ${order.diaChi}</p>
        </div>

        <div class="bill-items">
          <h5>Chi tiết đơn hàng:</h5>
          <table class="table">
            <thead>
              <tr>
                <th>Sản phẩm</th>
                <th>Size</th>
                <th>Topping</th>
                <th class="text-end">Thành tiền</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="detail" items="${orderDetails}">
                <tr>
                  <td>${detail.productName}</td>
                  <td>${detail.size}</td>
                  <td>${detail.topping}</td>
                  <td class="text-end">${detail.thanhTien} VNĐ</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <div class="bill-total card shadow-sm p-3 mb-4 bg-light border-0">
          <div class="row justify-content-end">
            <div class="col-md-7 col-lg-6">
              <c:if test="${not empty order.vouchers}">
                <div
                  class="d-flex justify-content-between align-items-center mb-2"
                >
                  <span class="fw-semibold text-success"
                    >Voucher đã áp dụng:</span
                  >
                  <span>
                    <c:forEach var="vcode" items="${order.vouchers}">
                      <span class="badge bg-info text-dark me-2">${vcode}</span>
                    </c:forEach>
                  </span>
                </div>
                <div
                  class="d-flex justify-content-between align-items-center mb-2"
                >
                  <span class="fw-semibold text-success">Giảm giá:</span>
                  <span class="fw-bold text-success"
                    >-<fmt:formatNumber
                      value="${order.discountAmount}"
                      type="currency"
                      currencySymbol="₫"
                  /></span>
                </div>
              </c:if>
              <div
                class="d-flex justify-content-between align-items-center border-top pt-3 mt-2"
              >
                <span class="fw-bold fs-5 text-dark">Tổng tiền:</span>
                <span class="product-price fs-3 text-primary fw-bold">
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

        <div class="text-center print-button no-print">
          <button onclick="window.print()" class="btn btn-primary me-2">
            <i class="fas fa-print"></i> In hóa đơn
          </button>
          <form
            action="${pageContext.request.contextPath}/cashier/orders/${order.id}/confirm-payment"
            method="post"
            style="display: inline"
          >
            <button
              type="submit"
              class="btn btn-success"
              onclick="return confirm('Xác nhận đơn này đã thanh toán?')"
            >
              <i class="fas fa-check"></i> Xác nhận thanh toán
            </button>
          </form>
        </div>
      </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
