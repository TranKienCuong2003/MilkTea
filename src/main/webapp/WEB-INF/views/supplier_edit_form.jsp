<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Chỉnh sửa nhà cung cấp</title>
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/milk-tea-logo.png" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
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
        max-width: 600px;
        margin: 50px auto;
        padding: 30px 40px;
        background-color: #fff;
        border-radius: 16px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
      }
      h2 {
        font-weight: bold;
        color: #007bff;
        text-align: center;
        margin-bottom: 32px;
        text-transform: uppercase;
        letter-spacing: 1px;
      }
      .form-label {
        font-weight: 500;
        color: #333;
      }
      .btn-success {
        background: linear-gradient(135deg, #28a745, #218838);
        border: none;
        width: 100%;
        border-radius: 8px;
        padding: 12px;
        font-size: 16px;
        font-weight: 600;
        transition: all 0.3s;
      }
      .btn-success:hover {
        background: linear-gradient(135deg, #218838, #1e7e34);
      }
      .form-control {
        border-radius: 8px;
        padding: 12px;
        font-size: 15px;
        border: 1px solid #ced4da;
      }
      .alert {
        border-radius: 8px;
        margin-bottom: 20px;
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="container">
      <div class="form-container">
        <h2>Chỉnh sửa nhà cung cấp</h2>

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

        <c:if test="${not empty success}">
          <div
            class="alert alert-success alert-dismissible fade show"
            role="alert"
          >
            ${success}
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
          action="${pageContext.request.contextPath}/supplier/edit/${supplier.code}"
          modelAttribute="supplier"
          enctype="multipart/form-data"
        >
          <div class="mb-3">
            <label for="name" class="form-label">Tên nhà cung cấp:</label>
            <form:input
              path="name"
              class="form-control"
              required="required"
              placeholder="Nhập tên nhà cung cấp"
            />
          </div>

          <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ:</label>
            <form:input
              path="address"
              class="form-control"
              required="required"
              placeholder="Nhập địa chỉ"
            />
          </div>

          <div class="mb-3">
            <label for="phone" class="form-label">Số điện thoại:</label>
            <form:input
              path="phone"
              class="form-control"
              required="required"
              type="tel"
              placeholder="Nhập số điện thoại"
            />
          </div>

          <button type="submit" class="btn btn-success">Lưu</button>
        </form:form>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
