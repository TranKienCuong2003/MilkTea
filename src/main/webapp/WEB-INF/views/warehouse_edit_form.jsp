<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Chỉnh sửa nguyên liệu - Milk Tea Shop</title>
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/milk-tea-logo.png" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
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
        
      .form-container {
        max-width: 800px;
        margin: 50px auto;
        padding: 30px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
      }
      .form-label {
        font-weight: bold;
        color: #333;
      }
      .btn {
        width: 100%;
        border-radius: 8px;
        padding: 12px;
        font-size: 16px;
        transition: all 0.3s;
      }
      .btn-success {
        background: linear-gradient(135deg, #28a745, #218838);
        border: none;
      }
      .btn-success:hover {
        background: linear-gradient(135deg, #218838, #1e7e34);
      }
      .form-control {
        border-radius: 5px;
        padding: 12px;
        font-size: 14px;
        border: 1px solid #ced4da;
      }
      h2 {
        font-weight: bold;
        color: #007bff;
        text-transform: uppercase;
        letter-spacing: 1px;
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
      <div class="form-container">
        <h2 class="text-center text-primary mb-4">Chỉnh sửa nguyên liệu</h2>

        <c:if test="${not empty error}">
          <div
            class="alert alert-danger alert-dismissible fade show"
            role="alert"
          >
            ${error}
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="alert"
              aria-label="Close"
            ></button>
          </div>
        </c:if>

        <form:form
          method="post"
          action="${pageContext.request.contextPath}/warehouse/edit/${warehouse.code}"
          modelAttribute="warehouse"
          enctype="multipart/form-data"
        >
          <div class="mb-3">
            <label for="name" class="form-label">Tên nguyên liệu:</label>
            <form:input
              path="name"
              class="form-control"
              required="required"
              placeholder="Nhập tên nguyên liệu"
            />
          </div>

          <div class="mb-3">
            <label for="quantity" class="form-label">Số lượng:</label>
            <form:input
              path="quantity"
              type="number"
              step="0.01"
              class="form-control"
              required="required"
              placeholder="Nhập số lượng"
            />
          </div>

          <div class="mb-3">
            <label for="address" class="form-label">Đơn vị tính:</label>
            <form:input
              path="address"
              class="form-control"
              required="required"
              placeholder="Nhập đơn vị tính (gram, kg, lít, chai, ly...)"
            />
          </div>

          <div class="mb-3">
            <label for="importDate" class="form-label">Ngày nhập:</label>
            <form:input
              path="importDate"
              type="date"
              class="form-control"
              required="required"
            />
          </div>

          <div class="mb-3">
            <label for="expiryDate" class="form-label">Hạn sử dụng:</label>
            <form:input path="expiryDate" type="date" class="form-control" />
          </div>

          <div class="mb-3">
            <label for="supplierId" class="form-label">Nhà cung cấp:</label>
            <form:select
              path="supplierId"
              class="form-select"
              required="required"
            >
              <form:option value="">-- Chọn nhà cung cấp --</form:option>
              <c:forEach items="${suppliers}" var="supplier">
                <form:option value="${supplier.code}"
                  >${supplier.name}</form:option
                >
              </c:forEach>
            </form:select>
          </div>

          <div class="mb-3">
            <label for="note" class="form-label">Ghi chú:</label>
            <form:textarea
              path="note"
              class="form-control"
              rows="3"
              placeholder="Nhập ghi chú (nếu có)"
            />
          </div>

          <button type="submit" class="btn btn-success">Cập nhật</button>
        </form:form>
      </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
