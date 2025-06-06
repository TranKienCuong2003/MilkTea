package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import beans.User;

public class AuthInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        
        // Cho phép truy cập các trang không cần xác thực
        if (isPublicPage(requestURI, contextPath)) {
            return true;
        }
        
        // Kiểm tra session
        HttpSession session = request.getSession(false);
        if (session != null) {
            User loggedInUser = (User) session.getAttribute("loggedInUser");
            if (loggedInUser != null) {
                return true;
            }
        }
        
        // Nếu chưa đăng nhập, chuyển hướng về trang login
        response.sendRedirect(contextPath + "/login");
        return false;
    }
    
    private boolean isPublicPage(String requestURI, String contextPath) {
        return requestURI.contains("/login") || 
               requestURI.contains("/resources/") || 
               requestURI.contains("/search") ||
               requestURI.equals(contextPath + "/") ||
               requestURI.equals(contextPath) ||
               requestURI.equals(contextPath + "/home") || 
               requestURI.contains("/product/detail") || 
               requestURI.contains("/api") || 
               requestURI.contains("/cart");
    }
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                User loggedInUser = (User) session.getAttribute("loggedInUser");
                if (loggedInUser != null) {
                    modelAndView.addObject("loggedInUser", loggedInUser);
                }
            }
        }
    }
    
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
            Exception ex) throws Exception {
    }
} 