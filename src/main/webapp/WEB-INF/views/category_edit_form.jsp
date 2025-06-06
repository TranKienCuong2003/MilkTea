<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Chỉnh sửa danh mục - Milk Tea Shop</title>
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
      .main-content {
        padding: 2rem 0;
      }
      .form-container {
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        padding: 2rem;
        max-width: 600px;
        margin: 0 auto;
      }
      .page-title {
        font-size: 1.8rem;
        font-weight: 600;
        color: #2d3436;
        margin-bottom: 1.5rem;
        text-align: center;
      }
      .form-label {
        font-weight: 500;
        color: #2d3436;
      }
      .form-control {
        border-radius: 8px;
        padding: 0.75rem 1rem;
        border: 1px solid #e0e0e0;
        transition: all 0.3s ease;
      }
      .form-control:focus {
        border-color: #0984e3;
        box-shadow: 0 0 0 0.2rem rgba(9, 132, 227, 0.25);
      }
      .btn-action {
        padding: 0.75rem 1.5rem;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s ease;
      }
      .btn-submit {
        background: #00b894;
        color: white;
        border: none;
      }
      .btn-submit:hover {
        background: #00a38c;
        transform: translateY(-1px);
      }
      .btn-cancel {
        background: #636e72;
        color: white;
        border: none;
        text-decoration: none;
      }
      .btn-cancel:hover {
        background: #576574;
        color: white;
        transform: translateY(-1px);
      }
      .alert {
        border-radius: 8px;
        margin-bottom: 1rem;
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="main-content">
      <div class="container">
        <div class="form-container">
          <h1 class="page-title">
            <i class="fas fa-edit me-2"></i>
            Chỉnh sửa danh mục
          </h1>

          <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
              <i class="fas fa-exclamation-circle me-2"></i>${error}
            </div>
          </c:if>

          <form
            action="${pageContext.request.contextPath}/category/edit/${category.maDM}"
            method="post"
            accept-charset="UTF-8"
          >
            <input type="hidden" name="maDM" value="${category.maDM}" />

            <div class="mb-4">
              <label for="tenDM" class="form-label">Tên danh mục</label>
              <input
                type="text"
                class="form-control"
                id="tenDM"
                name="tenDM"
                value="${category.tenDM}"
                required
                placeholder="Nhập tên danh mục"
              />
            </div>

            <div class="d-flex gap-3">
              <button
                type="submit"
                class="btn btn-action btn-submit flex-grow-1"
              >
                <i class="fas fa-save me-2"></i>Lưu
              </button>
              <a
                href="${pageContext.request.contextPath}/category/view"
                class="btn btn-action btn-cancel flex-grow-1"
              >
                <i class="fas fa-times me-2"></i>Hủy
              </a>
            </div>
          </form>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
