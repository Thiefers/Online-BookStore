package com.roc.bookshop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.roc.bookshop.bean.Admin;
import com.roc.bookshop.bean.User;

public class LoginInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("sessionUser");
		Admin admin = (Admin) session.getAttribute("admin");
		if (user != null || admin != null) {
			// 身份OK，放行
			return true;
		} else {
			String url = request.getRequestURI();
//			System.out.println("uri:"+url);
			if (url.contains("cartItem") || url.contains("order")) {
				request.setAttribute("code", "error");
				request.setAttribute("msg", "您尚未登录，资源无法访问！");
				request.getRequestDispatcher("/jsps/msg.jsp").forward(request, response);
				return false;
			} else if (url.contains("admin")) {
				if (url.contains("admin/login")) {
					return true;
				} else {
					request.setAttribute("msg", "您还未登录，请先登录");
					request.getRequestDispatcher("/adminjsps/login.jsp").forward(request, response);
					return false;
				}
			} else {
				return true;
			}
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}