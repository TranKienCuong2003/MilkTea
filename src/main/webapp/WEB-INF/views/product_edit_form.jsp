<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chỉnh sửa sản phẩm</title>
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/milk-tea-logo.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
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
        .card {
            margin: 50px auto;
            max-width: 600px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            background-color: #007bff;
            color: white;
        }
        .form-control, .btn {
            border-radius: 8px;
        }
        .btn {
            padding: 12px 20px;
            font-size: 16px;
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
        .form-actions {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .form-actions .btn {
            width: 48%;
        }
        /* CSS cho input file */
        .custom-file-input::-webkit-file-upload-button {
            visibility: hidden;
            display: none;
        }
        .custom-file-input::before {
            content: 'Chọn ảnh';
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
        <div class="card">
            <div class="card-header text-center">
                <h4>Chỉnh sửa sản phẩm</h4>
            </div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/product/edit/${product.maSP}" method="post" 
                      accept-charset="UTF-8" enctype="multipart/form-data">
                    <input type="hidden" name="maSP" value="${product.maSP}">

                    <div class="mb-3">
                        <label for="tenSP" class="form-label">Tên sản phẩm:</label>
                        <input type="text" class="form-control ${not empty tenSPError ? 'is-invalid' : ''}" 
                               id="tenSP" name="tenSP" value="${product.tenSP}" 
                               placeholder="Nhập tên sản phẩm" required>
                        <c:if test="${not empty tenSPError}">
                            <div class="invalid-feedback">${tenSPError}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="donGia" class="form-label">Giá sản phẩm</label>
                        <input type="number" class="form-control" id="donGia" name="donGia" 
                               value="${product.donGia}" required min="0" step="1000">
                    </div>

                    <div class="mb-3">
                        <label for="soLuong" class="form-label">Số lượng</label>
                        <input type="number" class="form-control" id="soLuong" name="soLuong" 
                               value="${product.soLuong}" required min="0" 
                               onchange="updateStatus()" oninput="updateStatus()">
                    </div>

                    <input type="hidden" name="trangThai" id="trangThai" value="${product.soLuong > 0}">

                    <div class="mb-3">
                        <label for="maDM" class="form-label">Danh mục:</label>
                        <select class="form-control" id="maDM" name="maDM">
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.maDM}" ${product.maDM == category.maDM ? 'selected' : ''}>
                                    ${category.tenDM}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="moTa" class="form-label">Mô tả:</label>
                        <textarea class="form-control" id="moTa" name="moTa" rows="4"
                                  placeholder="Nhập mô tả sản phẩm">${product.moTa}</textarea>
                    </div>

                    <div class="mb-3">
                        <label for="imageFile" class="form-label">Hình ảnh:</label>
                        <input type="file" class="form-control custom-file-input" id="imageFile" name="imageFile"
                               accept="image/*" style="padding-left: 0;">
                        <input type="hidden" name="hinhAnh" value="${product.hinhAnh}">
                        <div class="mt-2">
                            <small class="text-muted">Ảnh hiện tại: ${product.hinhAnh}</small>
                            <c:if test="${not empty product.hinhAnh}">
                                <img src="${pageContext.request.contextPath}/resources/images/${product.hinhAnh}" 
                                     alt="Ảnh sản phẩm" class="mt-2" style="max-width: 100px; height: auto;">
                            </c:if>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-success" onclick="return validateBeforeSubmit()">Lưu</button>
                        <a href="${pageContext.request.contextPath}/product/view" class="btn btn-secondary">Hủy</a>
                    </div>
                </form>
            </div>
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
                input.classList.add('is-invalid');
                input.nextElementSibling.textContent = 'Giá sản phẩm không thể vượt quá 999,999';
            } else {
                input.classList.remove('is-invalid');
                input.nextElementSibling.textContent = '';
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
