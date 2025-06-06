<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Xác thực email</title>
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
      body {
        background: linear-gradient(120deg, #74b9ff, #0984e3);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
      }
      .otp-container {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
        padding: 32px 28px;
        max-width: 400px;
        width: 100%;
      }
      .otp-title {
        color: #0984e3;
        font-weight: 700;
        text-align: center;
        margin-bottom: 18px;
      }
      .form-label {
        font-weight: 500;
      }
      .btn-verify {
        background: linear-gradient(120deg, #74b9ff, #0984e3);
        border: none;
        border-radius: 8px;
        color: white;
        font-weight: 600;
        width: 100%;
        padding: 12px;
        margin-top: 10px;
        transition: all 0.3s;
      }
      .btn-verify:hover {
        background: linear-gradient(120deg, #0984e3, #74b9ff);
        transform: translateY(-2px);
      }
    </style>
  </head>
  <body>
    <div class="otp-container">
      <h2 class="otp-title">Xác thực email</h2>
      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>
      <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
      </c:if>
      <c:if test="${not empty info}">
        <div class="alert alert-info">${info}</div>
      </c:if>
      <form
        action="${pageContext.request.contextPath}/verify-otp"
        method="post"
        autocomplete="off"
      >
        <div class="mb-3">
          <label class="form-label">Nhập mã xác thực đã gửi về email</label>
          <input
            type="text"
            name="otp"
            class="form-control"
            required
            placeholder="Nhập mã xác thực"
          />
        </div>
        <button type="submit" class="btn btn-verify mb-2">Xác nhận</button>
        <form
          action="${pageContext.request.contextPath}/resend-otp"
          method="post"
          class="mt-2"
        >
          <button type="submit" class="btn btn-outline-primary w-100">
            Gửi lại mã xác thực
          </button>
        </form>
      </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
