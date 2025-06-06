<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Đăng nhập - Milk Tea Shop</title>
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
        background: linear-gradient(120deg, #74b9ff, #0984e3);
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }
      .login-container {
        background: white;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px;
        animation: fadeIn 0.5s ease-in-out;
      }
      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(-20px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
      .login-header {
        text-align: center;
        margin-bottom: 30px;
      }
      .login-header h1 {
        color: #2d3436;
        font-size: 2rem;
        margin-bottom: 10px;
      }
      .login-header p {
        color: #636e72;
        font-size: 1rem;
      }
      .brand-logo {
        font-size: 3rem;
        color: #0984e3;
        margin-bottom: 20px;
        animation: float 3s ease-in-out infinite;
      }
      @keyframes float {
        0%,
        100% {
          transform: translateY(0);
        }
        50% {
          transform: translateY(-10px);
        }
      }
      .input-group {
        margin-bottom: 20px;
        position: relative;
      }
      .input-group-text {
        background: transparent;
        border: 1px solid #dfe6e9;
        border-right: none;
        color: #636e72;
      }
      .form-control {
        border-left: none;
        padding-right: 40px;
      }
      .form-control:focus {
        border-color: #74b9ff;
        box-shadow: 0 0 0 0.25rem rgba(116, 185, 255, 0.25);
      }
      .password-toggle {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        z-index: 10;
        cursor: pointer;
        background: none;
        border: none;
        color: #636e72;
        padding: 5px;
      }
      .password-toggle:hover {
        color: #0984e3;
      }
      .btn-login {
        background: linear-gradient(120deg, #74b9ff, #0984e3);
        border: none;
        border-radius: 10px;
        color: white;
        padding: 12px;
        font-weight: 600;
        width: 100%;
        margin-top: 10px;
        transition: all 0.3s ease;
      }
      .btn-login:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(9, 132, 227, 0.3);
      }
      .alert {
        border-radius: 10px;
        margin-bottom: 20px;
        animation: shake 0.5s ease-in-out;
      }
      @keyframes shake {
        0%,
        100% {
          transform: translateX(0);
        }
        10%,
        30%,
        50%,
        70%,
        90% {
          transform: translateX(-5px);
        }
        20%,
        40%,
        60%,
        80% {
          transform: translateX(5px);
        }
      }
      .form-check {
        margin: 15px 0;
      }
      .form-check-input:checked {
        background-color: #0984e3;
        border-color: #0984e3;
      }
    </style>
  </head>
  <body>
    <div class="login-container">
      <div class="login-header">
        <i class="fas fa-mug-hot brand-logo"></i>
        <h1>Milk Tea Shop</h1>
        <p>Đăng nhập để tiếp tục</p>
      </div>

      <c:if test="${not empty error}">
        <div
          class="alert alert-danger alert-dismissible fade show"
          role="alert"
        >
          <i class="fas fa-exclamation-circle me-2"></i>${error}
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
          <i class="fas fa-check-circle me-2"></i>${success}
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert"
            aria-label="Close"
          ></button>
        </div>
      </c:if>

      <form
        action="${pageContext.request.contextPath}/login"
        method="post"
        class="needs-validation"
        novalidate
      >
        <div class="input-group">
          <span class="input-group-text">
            <i class="fas fa-user"></i>
          </span>
          <input
            type="text"
            name="username"
            class="form-control"
            placeholder="Tên đăng nhập"
            required
          />
          <div class="invalid-feedback">Vui lòng nhập tên đăng nhập</div>
        </div>

        <div class="input-group">
          <span class="input-group-text">
            <i class="fas fa-lock"></i>
          </span>
          <input
            type="password"
            name="password"
            id="password"
            class="form-control"
            placeholder="Mật khẩu"
            required
          />
          <button
            type="button"
            class="password-toggle"
            onclick="togglePassword()"
          >
            <i class="fas fa-eye" id="password-toggle-icon"></i>
          </button>
          <div class="invalid-feedback">Vui lòng nhập mật khẩu</div>
        </div>

        <div class="mb-3">
          <label class="form-label w-100">Mã xác nhận (Captcha):</label>
          <div
            class="input-captcha-row d-flex align-items-center gap-2"
            style="width: 100%"
          >
            <img
              src="${pageContext.request.contextPath}/captcha"
              class="captcha-img"
              id="captchaImg"
              alt="captcha"
              style="
                height: 38px;
                cursor: pointer;
                border-radius: 6px;
                border: 1px solid #eee;
              "
              onclick="refreshCaptcha()"
              title="Nhấn để làm mới mã"
            />
            <button
              type="button"
              class="btn btn-outline-secondary btn-sm"
              onclick="refreshCaptcha()"
            >
              <i class="fas fa-sync-alt"></i>
            </button>
            <input
              type="text"
              name="captcha"
              class="form-control ms-2"
              placeholder="Nhập mã Capcha"
              required
              autocomplete="off"
              style="max-width: 160px"
            />
          </div>
          <div class="invalid-feedback">Vui lòng nhập mã xác nhận</div>
        </div>

        <div class="form-check">
          <input
            class="form-check-input"
            type="checkbox"
            id="rememberMe"
            name="rememberMe"
          />
          <label class="form-check-label" for="rememberMe">
            Ghi nhớ đăng nhập
          </label>
        </div>

        <button type="submit" class="btn btn-login">
          <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
        </button>
      </form>
      <div class="text-center mt-3">
        <span>Bạn chưa có tài khoản?</span>
        <a
          href="${pageContext.request.contextPath}/register"
          class="btn btn-outline-primary ms-2"
          >Đăng ký</a
        >
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // Ẩn/hiện mật khẩu
      function togglePassword() {
        const passwordInput = document.getElementById("password");
        const toggleIcon = document.getElementById("password-toggle-icon");

        if (passwordInput.type === "password") {
          passwordInput.type = "text";
          toggleIcon.classList.remove("fa-eye");
          toggleIcon.classList.add("fa-eye-slash");
        } else {
          passwordInput.type = "password";
          toggleIcon.classList.remove("fa-eye-slash");
          toggleIcon.classList.add("fa-eye");
        }
      }

      // Form validation
      (function () {
        "use strict";
        var forms = document.querySelectorAll(".needs-validation");
        Array.prototype.slice.call(forms).forEach(function (form) {
          form.addEventListener(
            "submit",
            function (event) {
              if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
              }
              form.classList.add("was-validated");
            },
            false
          );
        });
      })();

      // Ẩn alert thành công sau 2.5 giây và remove khỏi DOM
      window.addEventListener("DOMContentLoaded", function () {
        var alertSuccess = document.querySelector(".alert-success");
        if (alertSuccess) {
          setTimeout(function () {
            alertSuccess.remove();
          }, 2500);
        }
        var alertDanger = document.querySelector(".alert-danger");
        if (alertDanger) {
          setTimeout(function () {
            alertDanger.remove();
          }, 2500);
        }
      });

      function refreshCaptcha() {
        document.getElementById("captchaImg").src =
          "${pageContext.request.contextPath}/captcha?" + new Date().getTime();
      }
    </script>
  </body>
</html>
