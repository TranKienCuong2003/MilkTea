<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-mug-hot"></i> Milk Tea Shop
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="nav nav-pills">
                    <c:if test="${not empty loggedInUser}">
                    	<c:if test="${ permission == 'quản lý' || permission == 'chủ quán' }">
                    		<li class="nav-item">
                            	<a class="nav-link ${ active == 'productMgm' ? 'active' : '' }" href="${pageContext.request.contextPath}/product/view">
                                	<i class="fas fa-box"></i> Quản lý sản phẩm
                            	</a>
                        	</li>
                        	<li class="nav-item">
                            	<a class="nav-link ${ active == 'categoryMgm' ? 'active' : '' }" href="${pageContext.request.contextPath}/category/view">
                                	<i class="fas fa-folder"></i> Quản lý danh mục
                            	</a>
                        	</li>
                        	<li class="nav-item">
                            	<a class="nav-link ${ active == 'employeeMgm' ? 'active' : '' }" href="${pageContext.request.contextPath}/user/view">
                                	<i class="fas fa-folder"></i> Quản lý nhân viên
                            	</a>
                        	</li>
                    	</c:if>
                    	<c:if test="${ permission == 'nhân viên kho' }">
                    		<li class="nav-item">
                            	<a class="nav-link ${ active == 'warehouseMgm' ? 'active' : '' }" href="${pageContext.request.contextPath}/warehouse/view">
                                	<i class="fas fa-box"></i> Quản lý kho
                            	</a>
                        	</li>
                    	</c:if>
                    	<c:if test="${ permission == 'quản lý' }">
                    		<li class="nav-item">
                            	<a class="nav-link ${ active == 'supplierMgm' ? 'active' : '' }" href="${pageContext.request.contextPath}/supplier/view">
                                	<i class="fas fa-box"></i> Quản lý nhà cung cấp
                            	</a>
                        	</li>
                        	<li class="nav-item">
                            	<a class="nav-link ${ active == 'voucherMgm' ? 'active' : '' }" href="${pageContext.request.contextPath}/voucher/view">
                                	<i class="fas fa-box"></i> Quản lý voucher
                            	</a>
                        	</li>
                    	</c:if>
                    	<c:if test="${ permission == 'nhân viên order' }">
                    		<li class="nav-item">
                            	<a class="nav-link ${ active == 'orderMgm' ? 'active' : '' }" href="${pageContext.request.contextPath}/order/view">
                                	<i class="fas fa-box"></i> Quản lý đơn hàng
                            	</a>
                        	</li>
                    	</c:if>
                    	<c:if test="${ permission == 'nhân viên pha chế' }">
                    		<li class="nav-item">
                            	<a class="nav-link ${ active == 'baristaOrders' ? 'active' : '' }" href="${pageContext.request.contextPath}/barista/orders">
                                	<i class="fas fa-mug-hot"></i> Quản lý đơn hàng cần pha
                            	</a>
                        	</li>
                    	</c:if>
                    	<c:if test="${ permission == 'nhân viên thu ngân' }">
						    <li class="nav-item">
						        <a class="nav-link ${ active == 'cashierReport' ? 'active' : '' }" href="${pageContext.request.contextPath}/cashier/revenue">
						            <i class="fas fa-chart-bar"></i> Báo cáo thống kê
						        </a>
						    </li>
						    <li class="nav-item">
						        <a class="nav-link ${ active == 'cashierPayment' ? 'active' : '' }" href="${pageContext.request.contextPath}/cashier/orders/waiting-payment">
						            <i class="fas fa-cash-register"></i> Hóa đơn thanh toán
						        </a>
						    </li>
						</c:if>
                    	<c:if test="${empty loggedInUser}">
                    		<li class="nav-item">
                    			<a class="nav-link position-relative me-3" href="${pageContext.request.contextPath}/cart/view">
                    				<i class="fas fa-shopping-cart"></i>
                    				<span class="position-absolute badge rounded-pill bg-danger"
                    					  style="top: 25%; left: 75%; transform: translate(-50%, -50%);" id="countCart">
                    					0
                    				</span>
                    			</a>
                    		</li>
                    	</c:if>
                    	<c:if test="${not empty loggedInUser && permission == 'khách hàng'}">
                    		<li class="nav-item">
                    			<a class="nav-link position-relative me-3" href="${pageContext.request.contextPath}/cart/view">
                    				<i class="fas fa-shopping-cart"></i>
                    				<span class="position-absolute badge rounded-pill bg-danger"
                    					  style="top: 25%; left: 75%; transform: translate(-50%, -50%);" id="countCart">
                    					0
                    				</span>
                    			</a>
                    		</li>
                    	</c:if>
                    </c:if>
                    <c:if test="${permission == 'khách hàng'}">
                        <li class="nav-item">
                            <a class="nav-link ${active == 'voucherList' ? 'active' : ''}" href="${pageContext.request.contextPath}/voucher/view">
                                <i class="fas fa-ticket-alt"></i> Danh sách Voucher
                            </a>
                        </li>
                    </c:if>
                </ul>
                <c:choose>
                    <c:when test="${empty loggedInUser}">
                        <div class="nav-item d-flex align-items-center gap-2">
                            <a class="nav-link position-relative me-3" href="${pageContext.request.contextPath}/cart/view">
                                <i class="fas fa-shopping-cart"></i>
                                <span class="position-absolute badge rounded-pill bg-danger"
                                      style="top: 25%; left: 75%; transform: translate(-50%, -50%);" id="countCart">
                                    0
                                </span>
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="fas fa-sign-in-alt"></i> Đăng nhập
                            </a>
                            <a class="btn btn-outline-primary ms-2" href="${pageContext.request.contextPath}/register">
                                <i class="fas fa-user-plus me-1"></i> Đăng ký
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="nav-item dropdown">
						  <a class="nav-link dropdown-toggle d-flex align-items-center" 
						     href="#" 
						     id="userDropdown" 
						     role="button" 
						     data-bs-toggle="dropdown" 
						     aria-expanded="false">
						     
						    <span class="user-avatar me-2">
						      <i class="fas fa-user-circle"></i>
						    </span>
						    <span>${loggedInUser.hoTen}</span>
						  </a>
						
						  <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
						    <li>
						      <a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
						        <i class="fas fa-user-cog me-2"></i>Thông tin cá nhân
						      </a>
						    </li>
						    <li><hr class="dropdown-divider"></li>
						    <li>
						      <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
						        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
						      </a>
						    </li>
						  </ul>
						</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>
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
    $(document).ready(function(){
        setCountCart();
    });
</script>