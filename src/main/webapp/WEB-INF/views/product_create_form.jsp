<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="spring"
uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Thêm sản phẩm mới</title>
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/milk-tea-logo.png" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
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
      /* CSS cho input file */
      .custom-file-input::-webkit-file-upload-button {
        visibility: hidden;
        display: none;
      }
      .custom-file-input::before {
        content: "Chọn ảnh";
        display: inline-block;
        background: linear-gradient(135deg, #007bff, #0056b3);
        color: white;
        border: none;
        border-radius: 5px;
        padding: 8px 16px;
        outline: none;
        white-space: nowrap;
        cursor: pointer;
        font-weight: 500;
        font-size: 14px;
      }
      .custom-file-input:hover::before {
        background: linear-gradient(135deg, #0056b3, #004094);
      }
      .custom-file-input:active::before {
        background: linear-gradient(135deg, #004094, #003075);
      }
      h2 {
        font-weight: bold;
        color: #007bff;
        text-transform: uppercase;
        letter-spacing: 1px;
      }
      .alert {
        border-radius: 8px;
        margin-bottom: 20px;
      }
      .invalid-feedback {
        display: block;
      }
    </style>
  </head>
  <body>
  <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="container">
      <div class="form-container">
        <h2 class="text-center text-primary mb-4">Thêm sản phẩm mới</h2>

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
          action="${pageContext.request.contextPath}/save"
          modelAttribute="product"
          enctype="multipart/form-data"
          accept-charset="UTF-8"
        >
          <div class="mb-3">
            <label for="tenSP" class="form-label">Tên sản phẩm:</label>
            <form:input
              path="tenSP"
              class="form-control ${not empty tenSPError ? 'is-invalid' : ''}"
              placeholder="Nhập tên sản phẩm"
            />
            <form:errors path="tenSP" cssClass="invalid-feedback" />
            <c:if test="${not empty tenSPError}">
              <div class="invalid-feedback">${tenSPError}</div>
            </c:if>
          </div>

          <div class="mb-3">
            <label for="donGia" class="form-label">Giá sản phẩm</label>
            <input type="number" class="form-control" id="donGia" name="donGia" 
                   required min="0" step="1000">
          </div>

          <div class="mb-3">
            <label for="soLuong" class="form-label">Số lượng</label>
            <input type="number" class="form-control" id="soLuong" name="soLuong" 
                   value="0" required min="0" 
                   onchange="updateStatus()" oninput="updateStatus()">
          </div>

          <div class="mb-3">
            <label for="maDM" class="form-label">Danh mục:</label>
            <form:select path="maDM" class="form-control">
              <c:forEach var="category" items="${categories}">
                <form:option value="${category.maDM}"
                  >${category.tenDM}</form:option
                >
              </c:forEach>
            </form:select>
          </div>

          <div class="mb-3">
            <label for="moTa" class="form-label">Mô tả:</label>
            <form:textarea
              path="moTa"
              class="form-control"
              placeholder="Nhập mô tả sản phẩm"
              rows="4"
            />
          </div>

          <div class="mb-3">
            <label for="imageFile" class="form-label">Hình ảnh:</label>
            <input
              type="file"
              name="imageFile"
              class="form-control custom-file-input"
              accept="image/*"
              style="padding-left: 0"
            />
          </div>

          <div class="mb-3">
            <label for="trangThai" class="form-label">Trạng thái:</label>
            <form:select path="trangThai" class="form-control" id="trangThai" disabled="true">
              <form:option value="true">Còn hàng</form:option>
              <form:option value="false">Hết hàng</form:option>
            </form:select>
            <small class="text-muted">Trạng thái sẽ tự động cập nhật dựa trên số lượng</small>
          </div>

          <form:hidden path="trangThai" id="trangThai" value="false"/>

          <button type="submit" class="btn btn-success" onclick="return validateBeforeSubmit()">Lưu</button>
        </form:form>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // Cập nhật trạng thái ngay khi trang load
      window.onload = function() {
          updateStatus();
      }

      function validatePrice(input) {
        if (input.value > 999999) {
          input.value = 999999;
          input.classList.add("is-invalid");
          input.nextElementSibling.textContent =
            "Giá sản phẩm không thể vượt quá 999,999";
        } else {
          input.classList.remove("is-invalid");
          input.nextElementSibling.textContent = "";
        }
      }

      function updateStatus() {
        const soLuong = parseInt(document.getElementById('soLuong').value) || 0;
        const trangThai = document.getElementById('trangThai');
        trangThai.value = soLuong > 0 ? 'true' : 'false';
      }

      function validateBeforeSubmit() {
          updateStatus(); // Cập nhật trạng thái một lần nữa trước khi submit
          return true;
      }
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
