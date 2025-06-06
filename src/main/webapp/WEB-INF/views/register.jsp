<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Đăng ký tài khoản</title>
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
        background: #f5f6fa;
        min-height: 100vh;
      }
      .register-container {
        max-width: 700px;
        margin: 40px auto;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
        padding: 32px 28px;
      }
      .register-title {
        font-weight: 700;
        color: #0984e3;
        margin-bottom: 24px;
        text-align: center;
      }
      .form-label {
        font-weight: 500;
      }
      .input-group-text {
        background: #f1f2f6;
      }
      .captcha-img {
        border-radius: 6px;
        border: 1px solid #ddd;
        margin-right: 10px;
        height: 40px;
      }
      .btn-refresh {
        border: none;
        background: none;
        color: #0984e3;
        font-size: 1.2em;
        cursor: pointer;
      }
      .btn-register {
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
      .btn-register:hover {
        background: linear-gradient(120deg, #0984e3, #74b9ff);
        transform: translateY(-2px);
      }
      .btn-send-otp {
        white-space: nowrap;
      }
      @media (max-width: 767px) {
        .register-container {
          padding: 18px 6px;
        }
      }
    </style>
  </head>
  <body>
    <div class="register-container">
      <h2 class="register-title">Đăng ký tài khoản</h2>
      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>
      <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
      </c:if>
      <form
        id="registerForm"
        action="${pageContext.request.contextPath}/register"
        method="post"
        autocomplete="off"
      >
        <div class="row g-3">
          <div class="col-md-6">
            <label class="form-label">Họ và tên</label>
            <div class="input-group mb-2">
              <span class="input-group-text"><i class="fas fa-user"></i></span>
              <input
                type="text"
                name="hoTen"
                class="form-control"
                required
                placeholder="Nhập họ tên"
                value="${user.hoTen}"
              />
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label">Tên đăng nhập</label>
            <div class="input-group mb-2">
              <span class="input-group-text"
                ><i class="fas fa-user-circle"></i
              ></span>
              <input
                type="text"
                name="tenDangNhap"
                class="form-control"
                required
                placeholder="Tên đăng nhập"
                value="${user.tenDangNhap}"
              />
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label">Email</label>
            <div class="input-group mb-2">
              <span class="input-group-text"
                ><i class="fas fa-envelope"></i
              ></span>
              <input
                type="email"
                name="email"
                id="emailInput"
                class="form-control"
                required
                placeholder="Email"
                value="${user.email}"
              />
              <button
                type="button"
                class="btn btn-outline-primary btn-send-otp ms-2"
                id="sendOtpBtn"
              >
                Gửi mã xác thực
              </button>
            </div>
            <div class="input-group mb-2" id="otpGroup">
              <span class="input-group-text"><i class="fas fa-key"></i></span>
              <input
                type="text"
                name="otp"
                id="otpInput"
                class="form-control"
                placeholder="Nhập mã xác thực"
              />
            </div>
            <div
              id="otpMsg"
              class="text-success small"
              style="display: none"
            ></div>
          </div>
          <div class="col-md-6">
            <label class="form-label">Mật khẩu</label>
            <div class="input-group mb-2">
              <span class="input-group-text"><i class="fas fa-lock"></i></span>
              <input
                type="password"
                name="matKhau"
                class="form-control"
                required
                placeholder="Mật khẩu"
              />
            </div>
            <label class="form-label">Xác nhận mật khẩu</label>
            <div class="input-group mb-2">
              <span class="input-group-text"><i class="fas fa-lock"></i></span>
              <input
                type="password"
                name="confirmPassword"
                class="form-control"
                required
                placeholder="Nhập lại mật khẩu"
              />
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label">Số điện thoại</label>
            <div class="input-group mb-2">
              <span class="input-group-text"><i class="fas fa-phone"></i></span>
              <input
                type="text"
                name="soDienThoai"
                class="form-control"
                required
                placeholder="Số điện thoại"
                value="${user.soDienThoai}"
              />
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label">Địa chỉ</label>
            <div class="input-group mb-2">
              <span class="input-group-text"
                ><i class="fas fa-map-marker-alt"></i
              ></span>
              <input
                type="text"
                name="diaChi"
                class="form-control"
                required
                placeholder="Địa chỉ"
                value="${user.diaChi}"
              />
            </div>
          </div>
          <div class="col-md-12">
            <label class="form-label">Mã xác nhận (Capcha):</label>
            <div class="d-flex align-items-center gap-2 mb-2">
              <img
                src="${pageContext.request.contextPath}/captcha"
                class="captcha-img"
                id="captchaImg"
                alt="captcha"
                style="border-radius: 6px; border: 1px solid #ddd; height: 40px"
              />
              <button
                type="button"
                class="btn-refresh"
                onclick="refreshCaptcha()"
                title="Lấy mã mới"
              >
                <i class="fas fa-sync-alt"></i>
              </button>
              <input
                type="text"
                name="captcha"
                class="form-control ms-2"
                required
                placeholder="Nhập mã Capcha"
                style="max-width: 150px"
              />
            </div>
          </div>
        </div>
        <button type="submit" class="btn btn-register mt-3 w-100">
          Đăng ký
        </button>
      </form>
    </div>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
    <script>
      function refreshCaptcha() {
        document.getElementById("captchaImg").src =
          "${pageContext.request.contextPath}/captcha?" + new Date().getTime();
      }
      // Gửi mã xác thực qua AJAX
      document.getElementById("sendOtpBtn").onclick = function () {
        var email = document.getElementById("emailInput").value;
        if (!email) {
          showToast("Vui lòng nhập email trước!", true);
          return;
        }
        fetch("${pageContext.request.contextPath}/send-otp", {
          method: "POST",
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
          body: "email=" + encodeURIComponent(email),
        })
          .then((response) => response.json())
          .then((data) => {
            document.getElementById("otpGroup").style.display = "";
            document.getElementById("otpMsg").style.display = "";
            if (data.success) {
              document.getElementById("otpMsg").innerText =
                "Đã gửi mã xác thực về email!";
            } else {
              document.getElementById("otpMsg").innerText =
                data.message || "Gửi mã xác thực thất bại!";
            }
            document.getElementById("otpInput").focus();
          })
          .catch(() => {
            document.getElementById("otpGroup").style.display = "";
            document.getElementById("otpMsg").style.display = "";
            document.getElementById("otpMsg").innerText =
              "Có lỗi khi gửi mã xác thực!";
            document.getElementById("otpInput").focus();
          });
      };
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
