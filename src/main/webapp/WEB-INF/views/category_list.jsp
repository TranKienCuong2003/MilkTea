<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Quản lý danh mục - Milk Tea Shop</title>
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
      .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
      }
      .page-title {
        font-size: 1.8rem;
        font-weight: 600;
        color: #2d3436;
        margin: 0;
      }
      .btn-add {
        background: #00b894;
        color: white;
        border: none;
        padding: 0.75rem 1.5rem;
        border-radius: 8px;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.3s ease;
      }
      .btn-add:hover {
        background: #00a38c;
        transform: translateY(-1px);
        color: white;
      }
      .table {
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
      }
      .table th {
        background: #f8f9fa;
        font-weight: 600;
        color: #2d3436;
      }
      .btn-action {
        padding: 0.5rem 1rem;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.3s ease;
      }
      .btn-edit {
        background: #0984e3;
        color: white;
        border: none;
        margin-right: 0.5rem;
      }
      .btn-edit:hover {
        background: #0878d4;
        color: white;
      }
      .btn-delete {
        background: #d63031;
        color: white;
        border: none;
      }
      .btn-delete:hover {
        background: #c42727;
        color: white;
      }
      .empty-state {
        text-align: center;
        padding: 3rem;
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
      }
      .empty-state i {
        font-size: 4rem;
        color: #b2bec3;
        margin-bottom: 1rem;
      }
      .empty-state h3 {
        color: #2d3436;
        font-size: 1.5rem;
        margin-bottom: 0.5rem;
      }
      .empty-state p {
        color: #636e72;
        margin-bottom: 0;
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
        <div class="page-header">
          <h1 class="page-title">
            <i class="fas fa-folder me-2"></i>
            Quản lý danh mục
          </h1>
          <a
            href="${pageContext.request.contextPath}/category/add"
            class="btn btn-add"
          >
            <i class="fas fa-plus me-2"></i>Thêm danh mục mới
          </a>
        </div>

        <c:if test="${not empty success}">
          <div class="alert alert-success" role="alert">
            <i class="fas fa-check-circle me-2"></i>${success}
          </div>
        </c:if>

        <c:if test="${not empty error}">
          <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
          </div>
        </c:if>

        <c:choose>
          <c:when test="${not empty categories}">
            <table class="table">
              <thead>
                <tr>
                  <th>Mã danh mục</th>
                  <th>Tên danh mục</th>
                  <th>Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${categories}" var="category">
                  <tr>
                    <td>${category.maDM}</td>
                    <td>${category.tenDM}</td>
                    <td>
                      <a
                        href="${pageContext.request.contextPath}/category/edit/${category.maDM}"
                        class="btn btn-action btn-edit"
                      >
                        <i class="fas fa-edit"></i>
                      </a>
                      <a
                        href="${pageContext.request.contextPath}/category/delete/${category.maDM}"
                        class="btn btn-action btn-delete"
                        onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');"
                      >
                        <i class="fas fa-trash"></i>
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:when>
          <c:otherwise>
            <div class="empty-state">
              <i class="fas fa-folder-open"></i>
              <h3>Chưa có danh mục nào</h3>
              <p>Hãy thêm danh mục mới để bắt đầu</p>
            </div>
          </c:otherwise>
        </c:choose>
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
