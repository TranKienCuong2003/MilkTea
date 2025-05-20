<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8" />
	    <title>Báo cáo doanh thu</title>
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
    <div class="mb-4">
      <canvas id="revenueChart" height="100"></canvas>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
      // Lấy dữ liệu từ backend
      const type = "${type}";
      const labels = [
        <c:forEach var="row" items="${report}">
          <c:choose>
            <c:when test="${type == 'day'}">
              "${row.Ngay}",
            </c:when>
            <c:when test="${type == 'month'}">
              "${row.Thang}/${row.Nam}",
            </c:when>
            <c:when test="${type == 'quarter'}">
              "Q${row.Quy}/${row.Nam}",
            </c:when>
            <c:when test="${type == 'year'}">
              "${row.Nam}",
            </c:when>
          </c:choose>
        </c:forEach>
      ];
      const data = [
        <c:forEach var="row" items="${report}">
          ${row.DoanhThu},
        </c:forEach>
      ];
      const soDon = [
        <c:forEach var="row" items="${report}">
          ${row.SoDon},
        </c:forEach>
      ];
      const ctx = document.getElementById('revenueChart').getContext('2d');
      new Chart(ctx, {
        type: 'bar',
        data: {
          labels: labels,
          datasets: [
            {
              label: 'Doanh thu (VNĐ)',
              data: data,
              backgroundColor: 'rgba(54, 162, 235, 0.7)',
              borderRadius: 8,
              maxBarThickness: 40
            },
            {
              label: 'Số đơn',
              data: soDon,
              type: 'line',
              borderColor: 'rgba(255, 99, 132, 0.8)',
              backgroundColor: 'rgba(255, 99, 132, 0.2)',
              yAxisID: 'y1',
              tension: 0.3,
              pointRadius: 4
            }
          ]
        },
        options: {
          responsive: true,
          interaction: { mode: 'index', intersect: false },
          plugins: {
            legend: { position: 'top' },
            title: { display: true, text: 'Báo cáo doanh thu' }
          },
          scales: {
            y: {
              beginAtZero: true,
              title: { display: true, text: 'Doanh thu (VNĐ)' }
            },
            y1: {
              beginAtZero: true,
              position: 'right',
              grid: { drawOnChartArea: false },
              title: { display: true, text: 'Số đơn' }
            }
          }
        }
      });
    </script>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 