<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Quản lý đơn hàng - Milk Tea Shop</title>
    <link
      rel="shortcut icon"
      type="image/png"
      href="${pageContext.request.contextPath}/resources/images/milk-tea-logo.png"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      html,
      body {
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
      .page-title {
        font-size: 1.8rem;
        font-weight: 600;
        color: #2d3436;
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }
      .page-title i {
        color: #0984e3;
      }
      .search-bar {
        background: white;
        padding: 1.5rem;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        margin-bottom: 2rem;
      }
      .search-input {
        border-radius: 8px;
        border: 1px solid #e0e0e0;
        padding: 0.75rem 1rem;
        width: 300px;
      }
      .search-input:focus {
        border-color: #0984e3;
        box-shadow: 0 0 0 0.2rem rgba(9, 132, 227, 0.25);
      }
      .btn-search {
        background: #0984e3;
        color: white;
        border: none;
        padding: 0.75rem 1.5rem;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s ease;
      }
      .btn-search:hover {
        background: #0773c5;
        transform: translateY(-1px);
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
        color: white;
        transform: translateY(-1px);
      }
      .product-table {
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        overflow: hidden;
      }
      .table {
        margin-bottom: 0;
      }
      .table th {
        background: #f8f9fa;
        font-weight: 600;
        color: #2d3436;
        border-bottom: 2px solid #e9ecef;
        padding: 1rem;
      }
      .table td {
        padding: 1rem;
        vertical-align: middle;
      }
      .product-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
      }
      .product-name {
        font-weight: 500;
        color: #2d3436;
        margin-bottom: 0.25rem;
      }
      .product-category {
        color: #636e72;
        font-size: 0.9rem;
      }
      .product-price {
        font-weight: 600;
        color: #00b894;
      }
      .product-quantity {
        font-weight: 500;
        color: #2d3436;
      }
      .btn-action {
        padding: 0.5rem 1rem;
        border-radius: 6px;
        font-size: 0.9rem;
        text-decoration: none;
        transition: all 0.3s ease;
      }
      .btn-edit {
        background: #0984e3;
        color: white;
        margin-right: 0.5rem;
      }
      .btn-delete {
        background: #d63031;
        color: white;
      }
      .btn-action:hover {
        opacity: 0.9;
        color: white;
        transform: translateY(-1px);
      }
      .status-badge {
        padding: 0.4rem 0.8rem;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
        white-space: nowrap;
      }
      .status-active {
        background: #e1f6ed;
        color: #00b894;
      }
      .status-inactive {
        background: #ffe9e9;
        color: #d63031;
      }
      /* Nút gradient hiện đại */
      .btn-gradient-blue {
        background: linear-gradient(90deg, #36d1c4 0%, #1976d2 100%);
        color: #fff;
        border: none;
        box-shadow: 0 2px 8px rgba(25, 118, 210, 0.15);
        transition: background 0.3s, transform 0.2s;
      }
      .btn-gradient-blue:hover {
        background: linear-gradient(90deg, #1976d2 0%, #36d1c4 100%);
        color: #fff;
        transform: translateY(-2px) scale(1.04);
      }
      .btn-gradient-green {
        background: linear-gradient(90deg, #43e97b 0%, #38f9d7 100%);
        color: #fff;
        border: none;
        box-shadow: 0 2px 8px rgba(67, 233, 123, 0.15);
        transition: background 0.3s, transform 0.2s;
      }
      .btn-gradient-green:hover {
        background: linear-gradient(90deg, #38f9d7 0%, #43e97b 100%);
        color: #fff;
        transform: translateY(-2px) scale(1.04);
      }
      .btn-gradient-blue:focus,
      .btn-gradient-green:focus {
        outline: none;
        box-shadow: 0 0 0 0.2rem rgba(25, 118, 210, 0.15);
      }
      .btn-icon {
        font-size: 1.1rem;
        margin-right: 0.4em;
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="main-content">
      <div class="container">
        <h1 class="page-title">
          <i class="fas fa-list"></i> Danh sách đơn hàng
        </h1>

        <div class="product-table">
          <table
            class="table table-bordered align-middle shadow-sm rounded-4 overflow-hidden"
          >
            <thead>
              <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Địa chỉ</th>
                <th>Số điện thoại</th>
                <th>Ngày đặt</th>
                <th class="text-center" style="width: 220px">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="order" items="${orders}">
                <tr>
                  <td>${ order.id }</td>
                  <td>
                    <div class="product-name">${order.ten}</div>
                  </td>
                  <td>
                    <div class="product-name">${order.diaChi}</div>
                  </td>
                  <td>
                    <div class="product-name">${order.sdt}</div>
                  </td>
                  <td>
                    <div class="product-name">${order.ngayDatFormatted}</div>
                  </td>
                  <td class="text-center">
                    <div class="d-flex flex-column align-items-center gap-2">
                      <a
                        href="${pageContext.request.contextPath}/order/detail/${order.id}"
                        class="btn btn-gradient-blue btn-sm rounded-pill shadow-sm d-inline-flex align-items-center gap-2 mb-1"
                      >
                        <i class="fas fa-eye btn-icon"></i>
                        <span>Chi tiết</span>
                      </a>
                      <c:if test="${order.status == 1}">
                        <button
                          class="btn btn-gradient-green btn-sm rounded-pill shadow-sm d-inline-flex align-items-center gap-2 btn-confirm-order"
                          data-order-id="${order.id}"
                          onclick="showConfirmModal('${order.id}', this)"
                        >
                          <i class="fas fa-check btn-icon"></i>
                          <span>Xác nhận đơn</span>
                        </button>
                      </c:if>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- Thêm jQuery trước Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      let isLoading = false;

      function showLoading() {
        isLoading = true;
        $(".product-table").css("opacity", "0.5");
        if (!$(".loading-overlay").length) {
          $(
            '<div class="loading-overlay"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>'
          ).appendTo(".main-content");
        }
      }

      function hideLoading() {
        isLoading = false;
        $(".product-table").css("opacity", "1");
        $(".loading-overlay").fadeOut(200, function () {
          $(this).remove();
        });
      }

      function loadProducts() {
        if (isLoading) return;

        showLoading();
        const keyword = $('input[name="keyword"]').val();
        const category = $('.search-input select[name="category"]').val();

        $.ajax({
          url: "${pageContext.request.contextPath}/product/search",
          type: "GET",
          data: {
            keyword: keyword,
            category: category,
          },
          success: function (response) {
            const newContent = $(response).find(".product-table").html();
            if (newContent) {
              $(".product-table").html(newContent);
            }
            hideLoading();
          },
          error: function () {
            showToast("Có lỗi xảy ra khi tải dữ liệu!", true);
            hideLoading();
          },
        });
      }

      // Xử lý khi thay đổi danh mục
      $('.search-input select[name="category"]').on("change", function (e) {
        e.preventDefault();
        loadProducts();
      });

      // Xử lý khi submit form tìm kiếm
      $("#searchForm").on("submit", function (e) {
        e.preventDefault();
        loadProducts();
      });

      // Thêm CSS cho loading overlay
      $("<style>")
        .text(
          `
                .loading-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(255,255,255,0.8);
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    z-index: 9999;
                }
            `
        )
        .appendTo("head");
    </script>
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
    </script>
    <!-- Toast thông báo -->
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1055">
      <div
        id="toastNotify"
        class="toast align-items-center text-bg-success border-0"
        role="alert"
        aria-live="assertive"
        aria-atomic="true"
      >
        <div class="d-flex">
          <div class="toast-body" id="toastNotifyMsg"></div>
          <button
            type="button"
            class="btn-close btn-close-white me-2 m-auto"
            data-bs-dismiss="toast"
            aria-label="Close"
          ></button>
        </div>
      </div>
    </div>
    <script>
      function showToast(msg, isError = false) {
        const toastEl = document.getElementById("toastNotify");
        const toastMsg = document.getElementById("toastNotifyMsg");
        toastMsg.innerText = msg;
        toastEl.classList.remove("text-bg-success", "text-bg-danger");
        toastEl.classList.add(isError ? "text-bg-danger" : "text-bg-success");
        const toast = new bootstrap.Toast(toastEl, { delay: 2000 });
        toast.show();
      }
    </script>

    <!-- Modal Xác nhận đơn hàng -->
    <div class="modal fade" id="confirmOrderModal" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Xác nhận đơn hàng</h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
            ></button>
          </div>
          <div class="modal-body">
            <form id="confirmOrderForm">
              <input type="hidden" id="orderId" name="orderId" />
              <div class="mb-3">
                <label class="form-label">Loại đơn hàng</label>
                <select class="form-select" id="loaiDon" name="loaiDon">
                  <option value="Online">Mua online</option>
                  <option value="Tại quán">Sử dụng tại quán</option>
                </select>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Đóng
            </button>
            <button
              type="button"
              class="btn btn-primary"
              onclick="confirmOrder()"
            >
              Xác nhận
            </button>
          </div>
        </div>
      </div>
    </div>

    <script>
      let confirmModal;
      document.addEventListener("DOMContentLoaded", function () {
        confirmModal = new bootstrap.Modal(
          document.getElementById("confirmOrderModal")
        );
      });
      let currentConfirmBtn = null;
      function showConfirmModal(orderId, btn) {
        document.getElementById("orderId").value = orderId;
        confirmModal.show();
        currentConfirmBtn = btn;
      }
      function confirmOrder() {
        const formData = new FormData(
          document.getElementById("confirmOrderForm")
        );
        const data = {
          orderId: formData.get("orderId"),
          loaiDon: formData.get("loaiDon"),
        };
        fetch("${pageContext.request.contextPath}/order/confirm", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: new URLSearchParams(data),
        })
          .then((response) => response.json())
          .then((result) => {
            if (result.error) {
              showToast(result.error, true);
            } else {
              confirmModal.hide();
              document
                .querySelectorAll(
                  `.btn-confirm-order[data-order-id='${data.orderId}']`
                )
                .forEach((btn) => btn.remove());
              showToast("Xác nhận đơn hàng thành công!", false);
              setTimeout(() => {
                location.reload();
              }, 1000);
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            showToast("Có lỗi xảy ra khi xác nhận đơn hàng", true);
          });
      }
    </script>
  </body>
</html>
