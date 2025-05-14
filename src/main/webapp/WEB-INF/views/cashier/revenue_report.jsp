<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8" />
	    <title>Báo cáo doanh thu</title>
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
	    </style>
  </head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="container mt-4">
    <h2 class="mb-4">Báo cáo doanh thu</h2>
    <form method="get" class="mb-3">
        <div class="row g-2 align-items-center">
            <div class="col-auto">
                <label for="type" class="col-form-label">Xem theo:</label>
            </div>
            <div class="col-auto">
                <select name="type" id="type" class="form-select" onchange="this.form.submit()">
                    <option value="day" ${type == 'day' ? 'selected' : ''}>Ngày</option>
                    <option value="month" ${type == 'month' ? 'selected' : ''}>Tháng</option>
                    <option value="quarter" ${type == 'quarter' ? 'selected' : ''}>Quý</option>
                    <option value="year" ${type == 'year' ? 'selected' : ''}>Năm</option>
                </select>
            </div>
        </div>
    </form>
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <c:choose>
                        <c:when test="${type == 'day'}">
                            <th>Ngày</th>
                        </c:when>
                        <c:when test="${type == 'month'}">
                            <th>Năm</th><th>Tháng</th>
                        </c:when>
                        <c:when test="${type == 'quarter'}">
                            <th>Năm</th><th>Quý</th>
                        </c:when>
                        <c:when test="${type == 'year'}">
                            <th>Năm</th>
                        </c:when>
                    </c:choose>
                    <th>Số đơn</th>
                    <th>Doanh thu (VNĐ)</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="row" items="${report}">
                    <tr>
                        <c:choose>
                            <c:when test="${type == 'day'}">
                                <td>${row.Ngay}</td>
                            </c:when>
                            <c:when test="${type == 'month'}">
                                <td>${row.Nam}</td>
                                <td>${row.Thang}</td>
                            </c:when>
                            <c:when test="${type == 'quarter'}">
                                <td>${row.Nam}</td>
                                <td>${row.Quy}</td>
                            </c:when>
                            <c:when test="${type == 'year'}">
                                <td>${row.Nam}</td>
                            </c:when>
                        </c:choose>
                        <td>${row.SoDon}</td>
                        <td>
                            <fmt:formatNumber value="${row.DoanhThu}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 