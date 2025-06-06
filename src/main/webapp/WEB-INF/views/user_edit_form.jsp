<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Chỉnh sửa nhân viên</title>
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/milk-tea-logo.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
        margin: 2rem auto;
        padding: 2rem;
      }
      .card {
        border: none;
        border-radius: 15px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      }
      .card-header {
        background: linear-gradient(135deg, #007bff, #0056b3);
        color: white;
        border-radius: 15px 15px 0 0 !important;
        padding: 1.5rem;
      }
      .form-label {
        font-weight: 500;
        color: #495057;
      }
      .form-control {
        border-radius: 8px;
        padding: 0.75rem;
        border: 1px solid #ced4da;
        transition: all 0.3s ease;
      }
      .form-control:focus {
        border-color: #80bdff;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
      }
      .btn {
        padding: 0.75rem 1.5rem;
        font-weight: 500;
        border-radius: 8px;
        transition: all 0.3s ease;
      }
      .btn-success {
        background: linear-gradient(135deg, #28a745, #218838);
        border: none;
      }
      .btn-success:hover {
        background: linear-gradient(135deg, #218838, #1e7e34);
        transform: translateY(-1px);
      }
      .alert {
        border-radius: 10px;
        padding: 1rem;
      }
      .custom-file-input {
        padding: 0.75rem;
      }
      .form-actions {
        display: flex;
        gap: 1rem;
        margin-top: 2rem;
      }
      .custom-file .btn {
        background: linear-gradient(135deg, #007bff, #0056b3);
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 0.5rem 1.5rem;
        font-weight: 500;
        cursor: pointer;
        transition: background 0.3s;
      }
      .custom-file .btn:hover {
        background: linear-gradient(135deg, #0056b3, #003a80);
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
      <div class="form-container">
        <div class="card">
          <div class="card-header">
            <h3 class="mb-0">Chỉnh sửa thông tin nhân viên</h3>
          </div>
          <div class="card-body">
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
              action="${pageContext.request.contextPath}/user/edit/${user.maNd}"
              modelAttribute="user"
              enctype="multipart/form-data"
              accept-charset="UTF-8"
            >
              <div class="row">
                <div class="col-md-6 mb-3">
                  <label for="hoTen" class="form-label">Họ và tên</label>
                  <form:input
                    path="hoTen"
                    class="form-control"
                    required="required"
                    placeholder="Nhập họ và tên"
                  />
                </div>

                <div class="col-md-6 mb-3">
                  <label for="email" class="form-label">Email</label>
                  <form:input
                    path="email"
                    class="form-control"
                    required="required"
                    type="email"
                    placeholder="Nhập email"
                  />
                </div>
              </div>

              <div class="row">
                <div class="col-md-6 mb-3">
                  <label for="soDienThoai" class="form-label"
                    >Số điện thoại</label
                  >
                  <form:input
                    path="soDienThoai"
                    class="form-control"
                    required="required"
                    type="tel"
                    placeholder="Nhập số điện thoại"
                  />
                </div>

                <div class="col-md-6 mb-3">
                  <label for="maQuyen" class="form-label">Quyền</label>
                  <form:select
                    path="maQuyen"
                    cssClass="form-control"
                    id="maQuyen"
                  >
                    <form:options
                      items="${permissions}"
                      itemValue="maQuyen"
                      itemLabel="tenQuyen"
                    />
                  </form:select>
                </div>
              </div>

              <div class="mb-3">
                <label for="diaChi" class="form-label">Địa chỉ</label>
                <form:input
                  path="diaChi"
                  class="form-control"
                  required="required"
                  placeholder="Nhập địa chỉ"
                />
              </div>

              <div class="mb-4">
                <label for="file" class="form-label">Ảnh đại diện</label>
                <div class="custom-file">
                  <form:input
                    path="file"
                    type="file"
                    cssClass="custom-file-input"
                    id="image"
                    style="display: none"
                  />
                  <label
                    for="image"
                    class="btn btn-primary"
                    id="customFileLabel"
                    >Chọn ảnh</label
                  >
                  <span id="file-chosen" class="ms-2 text-secondary"
                    >Chưa chọn ảnh</span
                  >
                </div>
              </div>

              <div class="form-actions">
                <button type="submit" class="btn btn-success">
                  <i class="fas fa-save me-2"></i>Lưu thay đổi
                </button>
                <a
                  href="${pageContext.request.contextPath}/user/list"
                  class="btn btn-secondary"
                >
                  <i class="fas fa-arrow-left me-2"></i>Quay lại
                </a>
              </div>
            </form:form>
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/your-font-awesome-kit.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
      async function getCountCart() {
        return $.ajax({
          url: "/MilkTea/api/cart",
          dataType: "json",
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
          success: (rs) => {
            return rs;
          },
          error: (rs) => {
            return rs;
          },
        });
      }

      async function setCountCart() {
        let carts = await getCountCart();
        $("#countCart").html(carts.length);
      }

      setCountCart();
      // Hiển thị tên file đã chọn
      document.getElementById("image").addEventListener("change", function () {
        const fileName = this.files[0] ? this.files[0].name : "Chưa chọn ảnh";
        document.getElementById("file-chosen").textContent = fileName;
      });
    </script>
  </body>
</html>
