<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.RequestDispatcher" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lỗi <%= request.getAttribute("javax.servlet.error.status_code") %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/milk-tea-logo.png" />
    
    <!-- Bootstrap + Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            background: linear-gradient(135deg, #ffe0e0, #ffecec);
            font-family: 'Segoe UI', sans-serif;
            animation: fadeIn 0.8s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .error-container {
            max-width: 700px;
            margin: 5vh auto;
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            text-align: center;
        }
        .error-icon {
            font-size: 100px;
            color: #ff6b6b;
            animation: pulse 1.5s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        .status-code {
            font-size: 4rem;
            font-weight: 700;
            color: #ff4e4e;
        }
        .message {
            font-size: 1.5rem;
            color: #333;
        }
        .details {
            margin-top: 20px;
            font-size: 0.95rem;
            color: #666;
            background: #f9f9f9;
            padding: 15px;
            border-radius: 10px;
            text-align: left;
        }
        .btn-custom {
            background-color: #ff4e4e;
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            margin: 15px 5px 0;
        }
        .btn-custom:hover {
            background-color: #e03a3a;
        }
        code {
            background: #f1f1f1;
            padding: 2px 6px;
            border-radius: 4px;
            color: #c7254e;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="error-container">
        <i class="fas fa-exclamation-triangle error-icon"></i>

        <%
            Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
            String uri = (String) request.getAttribute("javax.servlet.error.request_uri");
            String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");
            String errorMsg = (String) request.getAttribute("javax.servlet.error.message");

            String message = "Đã xảy ra lỗi không xác định.";

            if (statusCode != null) {
                switch (statusCode) {
                    case 400:
                        message = "Yêu cầu không hợp lệ (400).";
                        break;
                    case 403:
                        message = "Bạn không có quyền truy cập trang này (403).";
                        break;
                    case 404:
                        message = "Không tìm thấy URL bạn yêu cầu (404).";
                        break;
                    case 500:
                        message = "Lỗi máy chủ nội bộ (500). Có thể hệ thống gặp sự cố.";
                        break;
                    default:
                        message = "Đã xảy ra lỗi với mã: " + statusCode;
                }
            }
        %>

        <div class="status-code"><%= statusCode != null ? statusCode : "???" %></div>
        <div class="message"><%= message %></div>
        <p>Hãy kiểm tra lại đường dẫn và thử lại.</p>
        <a href="javascript:history.back()" class="btn btn-outline-danger ms-2"><i class="fa fa-arrow-left"></i> Quay lại</a>

        <div class="details mt-4">
            <strong>URI được yêu cầu:</strong> <%= uri != null ? uri : "Không xác định" %><br/>
            <strong>Tên servlet gây lỗi:</strong> <%= servletName != null ? servletName : "Không rõ" %><br/>
            <strong>Mô tả lỗi (message):</strong> <%= errorMsg != null ? errorMsg : "Không có mô tả cụ thể." %><br/>
            <strong>Loại ngoại lệ (Exception):</strong> <%= exception != null ? exception.getClass().getName() : "Không có." %><br/>
            <strong>Chi tiết lỗi:</strong> <%= exception != null ? exception.getMessage() : "Không có thông tin chi tiết." %><br/>

            <% if (exception != null) { %>
                <br/><strong>📌 Stack Trace:</strong>
                <pre><code>
<%
    java.io.StringWriter sw = new java.io.StringWriter();
    java.io.PrintWriter pw = new java.io.PrintWriter(sw);
    exception.printStackTrace(pw);
    out.print(sw.toString());
%>
                </code></pre>
            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
