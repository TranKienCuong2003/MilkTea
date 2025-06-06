<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Thông tin cá nhân - Milk Tea Shop</title>
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
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        min-height: 100vh;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        padding: 40px 0;
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
      .profile-card {
        max-width: 800px;
        margin: 30px auto;
        border-radius: 18px;
        box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.15);
        background: #fff;
        padding: 2.5rem;
      }
      .profile-header {
        display: flex;
        align-items: flex-start;
        margin-bottom: 2rem;
      }
      .profile-avatar-section {
        flex: 0 0 200px;
        margin-right: 2rem;
      }
      .profile-info-section {
        flex: 1;
      }
      .profile-avatar {
        width: 180px;
        height: 180px;
        object-fit: cover;
        border-radius: 50%;
        border: 4px solid #0d6efd;
        margin: 0 auto 18px auto;
        display: block;
        background: #f8f9fa;
      }
      .upload-btn-wrapper {
        position: relative;
        display: flex;
        justify-content: center;
        margin-bottom: 18px;
      }
      .upload-btn {
        border: 2px solid #0d6efd;
        color: #0d6efd;
        background: #fff;
        padding: 7px 18px;
        border-radius: 8px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s;
        width: 100%;
        text-align: center;
      }
      .upload-btn:hover {
        background: #0d6efd;
        color: #fff;
      }
      .upload-btn-wrapper input[type="file"] {
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
        width: 100%;
        height: 100%;
        cursor: pointer;
      }
      .profile-title {
        font-size: 1.8rem;
        font-weight: 600;
        margin-bottom: 1.5rem;
        color: #222;
      }
      .form-section {
        background: #f8f9fa;
        border-radius: 12px;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
      }
      .section-title {
        font-size: 1.2rem;
        font-weight: 600;
        margin-bottom: 1rem;
        color: #0d6efd;
      }
      .form-label {
        font-weight: 500;
        color: #444;
      }
      .form-control {
        border-radius: 8px;
        padding: 0.6rem 1rem;
      }
      .form-control:focus {
        box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.15);
      }
      .btn-save {
        font-weight: 600;
        font-size: 1rem;
        padding: 0.7rem 2rem;
        border-radius: 8px;
      }
      .alert {
        border-radius: 10px;
        margin-bottom: 1.5rem;
      }
      @media (max-width: 768px) {
        .profile-header {
          flex-direction: column;
          align-items: center;
        }
        .profile-avatar-section {
          margin-right: 0;
          margin-bottom: 2rem;
        }
        .profile-card {
          margin: 15px;
          padding: 1.5rem;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="container">
      <div class="profile-card">
        <div class="profile-header">
          <div class="profile-avatar-section">
            <img
              src="${empty loggedInUser.anhDaiDien ? pageContext.request.contextPath.concat('/resources/images/default-avatar.png') : pageContext.request.contextPath.concat(loggedInUser.anhDaiDien)}"
              alt="Avatar"
              class="profile-avatar"
              id="avatarPreview"
            />
            <form
              action="${pageContext.request.contextPath}/user/upload-avatar"
              method="post"
              enctype="multipart/form-data"
              id="avatarForm"
            >
              <div class="upload-btn-wrapper">
                <button class="upload-btn" type="button">
                  <i class="fas fa-camera"></i> Chọn ảnh
                </button>
                <input
                  type="file"
                  name="avatar"
                  accept="image/*"
                  onchange="previewImage(this); submitForm();"
                />
              </div>
            </form>
          </div>

          <div class="profile-info-section">
            <h1 class="profile-title">Thông tin cá nhân</h1>
            <c:if test="${not empty error}">
              <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
              <div class="alert alert-success">${success}</div>
            </c:if>

            <form
              action="${pageContext.request.contextPath}/user/update"
              method="post"
              class="needs-validation"
              novalidate
            >
              <div class="form-section">
                <div class="section-title">Thông tin chung</div>
                <div class="row">
                  <div class="col-md-6 mb-3">
                    <label for="hoTen" class="form-label">Họ và tên</label>
                    <input
                      type="text"
                      class="form-control"
                      id="hoTen"
                      name="hoTen"
                      value="${loggedInUser.hoTen}"
                      required
                    />
                  </div>
                  <div class="col-md-6 mb-3">
                    <label for="soDienThoai" class="form-label"
                      >Số điện thoại</label
                    >
                    <input
                      type="tel"
                      class="form-control"
                      id="soDienThoai"
                      name="soDienThoai"
                      value="${loggedInUser.soDienThoai}"
                      required
                    />
                  </div>
                </div>
                <div class="mb-3">
                  <label for="diaChi" class="form-label">Địa chỉ</label>
                  <textarea
                    class="form-control"
                    id="diaChi"
                    name="diaChi"
                    rows="2"
                    required
                  >
${loggedInUser.diaChi}</textarea
                  >
                </div>
                <button type="submit" class="btn btn-primary btn-save">
                  <i class="fas fa-save"></i> Lưu thay đổi
                </button>
              </div>
            </form>

            <div class="form-section">
              <div class="section-title">Thay đổi email</div>
              <div id="emailChangeMsg"></div>
              <form id="changeEmailForm">
                <div class="mb-3">
                  <label for="email" class="form-label">Email hiện tại</label>
                  <input
                    type="email"
                    class="form-control"
                    value="${loggedInUser.email}"
                    disabled
                  />
                </div>
                <div class="mb-3">
                  <label for="newEmail" class="form-label">Email mới</label>
                  <input
                    type="email"
                    class="form-control"
                    id="newEmail"
                    name="newEmail"
                    required
                  />
                </div>
                <button type="submit" class="btn btn-primary">
                  <i class="fas fa-envelope"></i> Gửi mã xác thực
                </button>
              </form>

              <div id="otpForm" style="display: none" class="mt-4">
                <div class="mb-3">
                  <label for="otp" class="form-label">Nhập mã xác thực</label>
                  <input
                    type="text"
                    class="form-control"
                    id="otp"
                    name="otp"
                    required
                  />
                </div>
                <button
                  type="button"
                  class="btn btn-success"
                  onclick="verifyNewEmail()"
                >
                  <i class="fas fa-check"></i> Xác nhận
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script>
      // Hiển thị ảnh preview khi chọn file
      function previewImage(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function (e) {
            document.getElementById("avatarPreview").src = e.target.result;
          };
          reader.readAsDataURL(input.files[0]);
        }
      }
      // Tự động submit form upload avatar khi chọn ảnh
      function submitForm() {
        document.getElementById("avatarForm").submit();
      }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      $(document).ready(function () {
        $("#changeEmailForm").on("submit", function (e) {
          e.preventDefault();
          var newEmail = $("#newEmail").val();

          $.ajax({
            url: "/MilkTea/user/change-email",
            type: "POST",
            data: { newEmail: newEmail },
            success: function (response) {
              showEmailChangeMsg(response, true);
              $("#otpForm").show();
            },
            error: function (xhr) {
              showEmailChangeMsg(xhr.responseText, false);
            },
          });
        });
      });

      function verifyNewEmail() {
        var otp = $("#otp").val();

        $.ajax({
          url: "/MilkTea/user/verify-new-email",
          type: "POST",
          data: { otp: otp },
          success: function (response) {
            showEmailChangeMsg(response, true);
            if (response.includes("thành công")) {
              setTimeout(function () {
                location.reload();
              }, 1500);
            }
          },
          error: function (xhr) {
            showEmailChangeMsg(xhr.responseText, false);
          },
        });
      }

      function showEmailChangeMsg(msg, isSuccess) {
        var alertClass = isSuccess ? "alert-success" : "alert-danger";
        var html =
          '<div class="alert ' +
          alertClass +
          ' alert-dismissible fade show" role="alert">' +
          msg +
          '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
          "</div>";
        $("#emailChangeMsg").html(html);
        // Tự động ẩn sau 4 giây
        setTimeout(function () {
          $("#emailChangeMsg .alert").alert("close");
        }, 4000);
      }
    </script>
  </body>
</html>
