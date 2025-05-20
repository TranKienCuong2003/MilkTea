<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${product.tenSP} - Chi tiết sản phẩm</title>
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/milk-tea-logo.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
    .nav-link {
            color: #2d3436;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: color 0.3s ease;
        }
        .nav-link:hover {
            color: #0984e3;
        }
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar {
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
        .product-image {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .product-info {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .price {
            font-size: 1.8rem;
            color: #28a745;
            font-weight: bold;
        }
        .status-badge {
            font-size: 1.1em;
            padding: 8px 15px;
            border-radius: 20px;
            margin: 10px 0;
            display: inline-block;
        }
        .description {
            margin: 20px 0;
            line-height: 1.6;
        }
        .category-badge {
            background-color: #e9ecef;
            color: #495057;
            padding: 5px 15px;
            border-radius: 15px;
            display: inline-block;
            margin: 10px 0;
        }
        .back-button {
            margin-bottom: 20px;
        }
        .related-products {
            margin-top: 50px;
        }
        .related-product-card {
            transition: transform 0.3s;
            margin-bottom: 20px;
        }
        .related-product-card:hover {
            transform: translateY(-5px);
        }
        .detail-section {
            margin-top: 15px;
            padding: 15px;
            border-left: 4px solid #3498db;
            background: #f8f9fa;
            margin-bottom: 15px;
        }
        .detail-section h5 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }
        .detail-content {
            background: white;
            padding: 12px;
            border-radius: 5px;
            border-left: 4px solid #3498db;
        }
        .related-product {
            transition: transform 0.3s;
        }
        .related-product:hover {
            transform: translateY(-5px);
        }
        .related-image {
            height: 200px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container mt-4">
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary mb-4">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>

        <div class="row">
            <!-- Hình ảnh sản phẩm -->
            <div class="col-md-5">
                <img src="${pageContext.request.contextPath}/resources/images/${product.hinhAnh}" 
                     class="product-image" alt="${product.tenSP}">
            </div>

            <!-- Thông tin sản phẩm -->
            <div class="col-md-7">
                <div class="product-info">
                    <h2 class="mb-3">${product.tenSP}</h2>
                    <p class="text-muted mb-2">Danh mục: ${product.tenDM}</p>
                    
                    <div class="price mb-3">
                        <fmt:formatNumber value="${product.donGia}" type="currency" currencySymbol="đ"/>
                    </div>

                    <div class="mb-3">
                        <span class="badge ${product.trangThai ? 'bg-success' : 'bg-danger'} p-2">
                            <i class="fas ${product.trangThai ? 'fa-check-circle' : 'fa-times-circle'} me-1"></i>
                            ${product.trangThai ? 'Còn hàng' : 'Hết hàng'}
                        </span>
                    </div>

                    <div class="detail-section">
                        <h5><i class="fas fa-info-circle me-2"></i>Mô tả sản phẩm</h5>
                        <p class="mb-0">${product.moTa}</p>
                    </div>

                    <c:if test="${not empty detail}">
                        <div class="detail-section">
                            <h5><i class="fas fa-leaf me-2"></i>Nguyên liệu</h5>
                            <p class="mb-0">${detail.nguyenLieu}</p>
                        </div>

                        <div class="detail-section">
                            <h5><i class="fas fa-book me-2"></i>Hướng dẫn sử dụng</h5>
                            <p class="mb-0">${detail.huongDanSuDung}</p>
                        </div>

                        <div class="detail-section">
                            <h5><i class="fas fa-heart me-2"></i>Lợi ích</h5>
                            <p class="mb-0">${detail.loiIch}</p>
                        </div>

                        <div class="detail-section">
                            <h5><i class="fas fa-sticky-note me-2"></i>Ghi chú</h5>
                            <p class="mb-0">${detail.ghiChu}</p>
                        </div>
                    </c:if>

                    <!-- Admin buttons -->
                    <div class="mt-4">
                    <c:if test="${not empty loggedInUser}">
                    	<c:if test="${ permission == 'quản lý' || permission == 'chủ quán' }">
                    		<button class="btn btn-primary" type="button" data-bs-toggle="collapse" 
                                data-bs-target="#editForm">
                            <i class="fas fa-edit me-1"></i> Chỉnh sửa thông tin chi tiết
                        </button>
                        <a href="${pageContext.request.contextPath}/product/edit/${product.maSP}" 
                           class="btn btn-warning ms-2">
                            <i class="fas fa-pencil-alt me-1"></i> Sửa sản phẩm
                        </a>
                        <a href="${pageContext.request.contextPath}/product/delete/${product.maSP}" 
                           class="btn btn-danger ms-2"
                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                            <i class="fas fa-trash me-1"></i> Xóa
                        </a>
                    	</c:if>
                    	</c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Form chỉnh sửa chi tiết (ẩn) -->
        <div class="collapse mt-4" id="editForm">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-3">Chỉnh sửa thông tin chi tiết</h5>
                    <form action="${pageContext.request.contextPath}/product/detail/save" method="post">
                        <input type="hidden" name="maSP" value="${product.maSP}">
                        <input type="hidden" name="maCTSP" value="${detail.maCTSP}">
                        
                        <div class="mb-3">
                            <label for="nguyenLieu" class="form-label">Nguyên liệu:</label>
                            <textarea name="nguyenLieu" id="nguyenLieu" 
                                      class="form-control" rows="3">${detail.nguyenLieu}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="huongDanSuDung" class="form-label">Hướng dẫn sử dụng:</label>
                            <textarea name="huongDanSuDung" id="huongDanSuDung" 
                                      class="form-control" rows="3">${detail.huongDanSuDung}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="loiIch" class="form-label">Lợi ích:</label>
                            <textarea name="loiIch" id="loiIch" 
                                      class="form-control" rows="3">${detail.loiIch}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="ghiChu" class="form-label">Ghi chú:</label>
                            <textarea name="ghiChu" id="ghiChu" 
                                      class="form-control" rows="3">${detail.ghiChu}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save me-1"></i> Lưu thay đổi
                            </button>
                            <c:if test="${not empty detail.maCTSP}">
                                <a href="${pageContext.request.contextPath}/product/detail/delete/${product.maSP}" 
                                   class="btn btn-danger ms-2"
                                   onclick="return confirm('Bạn có chắc muốn xóa chi tiết sản phẩm này?')">
                                    <i class="fas fa-trash me-1"></i> Xóa chi tiết
                                </a>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Sản phẩm liên quan -->
        <div class="related-products mt-5">
            <h3 class="mb-4">Sản phẩm liên quan</h3>
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                <c:forEach var="relatedProduct" items="${relatedProducts}">
                    <div class="col">
                        <div class="card h-100 related-product">
                            <img src="${pageContext.request.contextPath}/resources/images/${relatedProduct.hinhAnh}" 
                                 class="card-img-top related-image" alt="${relatedProduct.tenSP}">
                            <div class="card-body">
                                <h5 class="card-title">${relatedProduct.tenSP}</h5>
                                <p class="text-success fw-bold">
                                    <fmt:formatNumber value="${relatedProduct.donGia}" type="currency" currencySymbol="đ"/>
                                </p>
                                <a href="${pageContext.request.contextPath}/product/detail/${relatedProduct.maSP}" 
                                   class="btn btn-outline-primary w-100">Xem chi tiết</a>
                                   <a href="#" 
                                       class="btn btn-outline-primary w-100 mt-3 btn-add-cart" data-id="${relatedProduct.maSP}">
                                        Thêm vào giỏ hàng
                                    </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Thông báo -->
        <c:if test="${not empty success}">
            <div class="alert alert-success mt-3">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger mt-3">${error}</div>
        </c:if>
    </div>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <div class="modal modal-add-cart" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Thêm vào giỏ hàng</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <label for="product-size" class="form-label">Chọn size</label>
          <select class="form-select" id="product-size">
          </select>
          <label class="form-label">Danh sách topping</label>
          <div id="list-topping-select" class="list-group">
          </div>
          <label for="topping" class="form-label">Chọn topping:</label>
                <input type="text" id="topping" name="topping" class="form-control"
                       placeholder="Nhập topping">
                <div id="list-topping-no-select" class="list-group"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary btn-add-cart-submit">Thêm vào giỏ hàng</button>
      </div>
    </div>
  </div>
</div>

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
	<script>
    async function getListSizes() {
    	return $.ajax({
            url: "/MilkTea/api/size",
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
    async function getListToppings() {
        let key = $('#topping').val();
        if (key.trim() == '') {
            return $.ajax({
                url: "/MilkTea/api/topping",
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
        return $.ajax({
            url: "/MilkTea/api/topping?name=" + key,
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
    
    $('#topping').off('keyup').on('keyup', async function(e) {
        e.preventDefault();
        let toppings = await getListToppings();
        const toppingsDiv = document.getElementById("list-topping-no-select");
        toppingsDiv.innerHTML = "";
        const element = document.getElementById("list-topping-select");
        let ids = [];
        if (element.hasAttribute("data-id")) {
            ids = element.getAttribute('data-id').split(';');
        }
        toppings.forEach(topping => {
            if (ids.indexOf(topping.maTopping) === -1) {
                const div = document.createElement("div");
                div.classList.add("list-group-item");
                div.classList.add("list-group-item-action");
                div.setAttribute('data-id', topping.maTopping);
                div.textContent = topping.tenTopping;
                div.onclick = () => selectTopping(topping);
                toppingsDiv.appendChild(div);
            }
        });
    });
    
    function selectTopping(topping) {
        const element = document.getElementById("list-topping-select");

        // Tạo container cho topping
        const div = document.createElement("div");
        div.classList.add("list-group-item", "d-flex", "justify-content-between", "align-items-center");
        div.setAttribute('data-id', topping.maTopping);

        const span = document.createElement("span");
        span.textContent = topping.tenTopping;

        const btn = document.createElement("button");
        btn.innerHTML = '<i class="bi bi-trash-fill"></i>';
        btn.classList.add("btn", "btn-danger");
        btn.onclick = () => {
            div.remove(); // Xoá phần tử khỏi DOM

            // Cập nhật lại data-id
            const ids = Array.from(element.children).map(d => d.getAttribute('data-id'));
            element.setAttribute('data-id', ids.filter(id => id !== topping.maTopping).join(';'));
        };

        div.appendChild(span);
        div.appendChild(btn);

        element.appendChild(div);
        document.getElementById("topping").value = "";

        // Cập nhật thuộc tính data-id
        if (element.hasAttribute("data-id")) {
            const currentIds = element.getAttribute('data-id');
            element.setAttribute('data-id', currentIds + ';' + topping.maTopping);
        } else {
            element.setAttribute('data-id', topping.maTopping);
        }

        // Xoá gợi ý
        document.getElementById("list-topping-no-select").innerHTML = "";
    }
    
    $('.btn-add-cart').off('click').on('click', async function(e) {
        e.preventDefault();
        let btn = $(this);
        let sizes = await getListSizes();
        $('#product-size').html('');
        let sizesDiv = document.getElementById("product-size");
        sizes.forEach(size => {
        	const option = document.createElement("option");
        	option.setAttribute('value', size.maSize);
        	option.textContent = size.tenSize;
        	sizesDiv.appendChild(option);
        });
        $('#topping').val('');
        $('#list-topping-select').html('');
        $('#list-topping-no-select').html('');
        document.getElementById("list-topping-select").removeAttribute('data-id');
        $('.modal-add-cart').modal('show');
        $('.btn-add-cart-submit').attr('data-id', btn.attr('data-id'));
    });
    
    $('.btn-add-cart-submit').off('click').on('click', async function(e) {
        e.preventDefault();
        let btn = $(this);
        let productId = btn.attr('data-id');
        let data = {
        	'product': btn.attr('data-id'),
        	'size': $('#product-size').val(),
        	'toppings': []
        };
        let toppingdivs = document.getElementById("list-topping-select");
        if(toppingdivs.hasAttribute("data-id")){
        	data = {
                	'product': btn.attr('data-id'),
                	'size': $('#product-size').val(),
                	'toppings': toppingdivs.getAttribute("data-id").split(';')
                };
        }
        $.ajax({
            url: "/MilkTea/api/cart",
            dataType: "json",
            method: "POST",
            data: JSON.stringify(data),
            headers: {
                "Content-Type": "application/json"
            },
            success: (rs) => {
                showToast('Thêm vào giỏ hàng thành công!');
                $('.modal-add-cart').modal('hide');
                setCountCart();
            },
            error: (rs) => {
            	if(rs.status == 200){
            		showToast('Thêm vào giỏ hàng thành công!');
            		$('.modal-add-cart').modal('hide');
            		setCountCart();
            	}else{
            		console.log(rs);
                    showToast('Có lỗi xảy ra!', true);
            	}
            }
        });
    });
    </script>

    <!-- Toast thông báo -->
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1055">
      <div id="toastNotify" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
          <div class="toast-body" id="toastNotifyMsg"></div>
          <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
      </div>
    </div>

    <script>
    function showToast(msg, isError = false) {
        const toastEl = document.getElementById('toastNotify');
        const toastMsg = document.getElementById('toastNotifyMsg');
        toastMsg.innerText = msg;
        toastEl.classList.remove('text-bg-success', 'text-bg-danger');
        toastEl.classList.add(isError ? 'text-bg-danger' : 'text-bg-success');
        const toast = new bootstrap.Toast(toastEl, { delay: 1000 });
        toast.show();
    }
    </script>
</body>
</html> 