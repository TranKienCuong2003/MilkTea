<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Thông tin cá nhân - Milk Tea Shop</title>
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
      .profile-container {
        max-width: 800px;
        margin: 40px auto;
        padding: 20px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      }
      .avatar-container {
        text-align: center;
        margin-bottom: 30px;
      }
      .avatar-preview {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        object-fit: cover;
        margin-bottom: 15px;
        border: 3px solid #007bff;
        background-color: #f8f9fa;
      }
      .upload-btn-wrapper {
        position: relative;
        overflow: hidden;
        display: inline-block;
      }
      .upload-btn {
        border: 2px solid #007bff;
        color: #007bff;
        background-color: white;
        padding: 8px 20px;
        border-radius: 8px;
        font-weight: bold;
        cursor: pointer;
      }
      .upload-btn:hover {
        background-color: #007bff;
        color: white;
      }
      .upload-btn-wrapper input[type="file"] {
        font-size: 100px;
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
        cursor: pointer;
      }
      .form-group {
        margin-bottom: 20px;
      }
      .alert {
        margin-bottom: 20px;
      }
    </style>
  </head>
  <body>
    <!-- Navbar -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="profile-container">
      <h2 class="text-center mb-4">Thông tin cá nhân</h2>

      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>
      <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
      </c:if>

      <div class="avatar-container">
        <img
          src="${empty loggedInUser.anhDaiDien ? pageContext.request.contextPath.concat('/resources/images/default-avatar.png') : pageContext.request.contextPath.concat(loggedInUser.anhDaiDien)}"
          alt="Avatar"
          class="avatar-preview"
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

      <form
        action="${pageContext.request.contextPath}/user/update"
        method="post"
        class="needs-validation"
        novalidate
      >
        <div class="form-group">
          <label for="hoTen">Họ và tên:</label>
          <input
            type="text"
            class="form-control"
            id="hoTen"
            name="hoTen"
            value="${loggedInUser.hoTen}"
            required
          />
        </div>

        <div class="form-group">
          <label for="email">Email:</label>
          <input
            type="email"
            class="form-control"
            id="email"
            name="email"
            value="${loggedInUser.email}"
            required
          />
        </div>

        <div class="form-group">
          <label for="soDienThoai">Số điện thoại:</label>
          <input
            type="tel"
            class="form-control"
            id="soDienThoai"
            name="soDienThoai"
            value="${loggedInUser.soDienThoai}"
            required
          />
        </div>

        <div class="form-group">
          <label for="diaChi">Địa chỉ:</label>
          <textarea
            class="form-control"
            id="diaChi"
            name="diaChi"
            rows="3"
            required
          >
${loggedInUser.diaChi}</textarea
          >
        </div>

        <div class="text-center">
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Lưu thay đổi
          </button>
        </div>
      </form>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      function previewImage(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function (e) {
            document.getElementById("avatarPreview").src = e.target.result;
          };
          reader.readAsDataURL(input.files[0]);
        }
      }

      function submitForm() {
        document.getElementById("avatarForm").submit();
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
    </script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<script>
    	async function getCountCart(){
    		return $.ajax({
                url: "/MilkTea/api/cart",
                dataType: "json",
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                },
                success: (rs) => {
                    return rs;
                },
                error: (rs) => {
                	return rs;
                }
            });
    	}
    	
    	async function setCountCart(){
    		let carts = await getCountCart();
    		$('#countCart').html(carts.length);
    	}
    	
    	setCountCart();
    </script>
  </body>
</html>
