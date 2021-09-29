package com.roc.bookshop.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.roc.bookshop.bean.User;
import com.roc.bookshop.exception.UserException;
import com.roc.bookshop.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	// 用户名是否注册校验
	@ResponseBody
	@RequestMapping("/ajaxValidateLoginName")
	public boolean ajaxValidateLoginName(@RequestParam("loginName") String loginName) {
		// System.out.println("LoginName==>" + loginName);
		boolean isExistLoginName = userService.ajaxValidateLoginName(loginName);
		System.out.println("controller:" + isExistLoginName);
		return isExistLoginName;
	}

	// 邮箱是否注册校验
	@ResponseBody
	@RequestMapping("/ajaxValidateEmail")
	public boolean ajaxValidateEmail(@RequestParam("email") String email) {
		// System.out.println("Email==>" + email);
		boolean isExistEmail = userService.ajaxValidateEmail(email);
		return isExistEmail;
	}

	// 验证码是否正确校验
	@ResponseBody
	@RequestMapping("/ajaxValidateVerifyCode")
	public boolean ajaxValidateVerifyCode(@RequestParam("verifyCode") String verifyCode, HttpSession session) {
		// 输入框中的验证码
		// System.out.println("VerifyCode==>" + verifyCode);
		// 获取图片上真实的验证码
		String vCode = (String) session.getAttribute("vCode");
		// 进行忽略大小写比较
		boolean isSame = verifyCode.equalsIgnoreCase(vCode);
		return isSame;
	}

	// 注册功能
	@RequestMapping("/regist")
	public String regist(User user, HttpServletRequest request) {
		// 表单数据封装在User中
		// System.out.println("User==>" + user);
		// 校验，如果校验失败，将错误信息保存并返回regist.jsp显示
		Map<String, String> errors = validateRegist(user, request.getSession());
		if (errors.size() > 0) {
			request.setAttribute("user", user);
			request.setAttribute("errors", errors);
			return "jsps/user/regist";
		}
		// 业务注册
		userService.regist(user);
		// 保存成功信息，转发到msg.jsp显示
		request.setAttribute("code", "success");
		request.setAttribute("msg", "注册功能，请马上到邮箱激活");
		return "jsps/msg";
	}

	// 注册校验
	// 对表单的字段进行逐个校验，如果有错误，使用当前字段名称为key，错误信息为value，保存到map中
	private Map<String, String> validateRegist(User user, HttpSession session) {
		Map<String, String> errors = new HashMap<String, String>();
		// 校验登录名
		String loginName = user.getLoginName();
		if (loginName == null || loginName.trim().isEmpty()) {
			errors.put("loginName", "用户名不能为空");
		} else if (loginName.length() < 3 || loginName.length() > 20) {
			errors.put("loginName", "用户名长度必须在3~20之间");
		} else if (userService.ajaxValidateLoginName(loginName)) {
			errors.put("loginName", "用户名已被注册");
		}
		// 校验密码
		String loginPwd = user.getLoginPwd();
		if (loginPwd == null || loginPwd.trim().isEmpty()) {
			errors.put("loginPwd", "密码不能为空");
		} else if (loginPwd.length() < 3 || loginPwd.length() > 20) {
			errors.put("loginPwd", "密码长度必须在3~20之间");
		}
		// 确认密码校验
		String reLoginPwd = user.getReLoginPwd();
		if (reLoginPwd == null || reLoginPwd.trim().isEmpty()) {
			errors.put("reLoginPwd", "确认密码不能为空");
		} else if (!reLoginPwd.equals(loginPwd)) {
			errors.put("reLoginPwd", "两次输入不一致");
		}
		// 校验Email
		String email = user.getEmail();
		if (email == null || email.trim().isEmpty()) {
			errors.put("email", "Email不能为空");
		} else if (!email.matches("^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]{2,3}){1,2})$")) {
			errors.put("email", "Email格式错误");
		} else if (userService.ajaxValidateEmail(email)) {
			errors.put("email", "Email已被注册");
		}
		// 校验验证码
		String verifyCode = user.getVerifyCode();
		String vCode = (String) session.getAttribute("vCode");
		if (verifyCode == null || verifyCode.trim().isEmpty()) {
			errors.put("verifyCode", "验证码不能为空");
		} else if (!verifyCode.equalsIgnoreCase(vCode)) {
			errors.put("verifyCode", "验证码错误");
		}
		// 返回错误Map
		return errors;
	}

	// 激活功能
	@RequestMapping("/activation")
	public String activation(HttpServletRequest req) {
		/*
		 * 1. 获取参数激活码
		 * 2. 用激活码调用service方法完成激活
		 *   > service方法有可能抛出异常, 把异常信息拿来，保存到request中，转发到msg.jsp显示
		 * 3. 保存成功信息到request，转发到msg.jsp显示。
		 */
		String code = req.getParameter("activationCode");
		try {
			userService.activation(code);
			req.setAttribute("code", "success");// 通知msg.jsp显示√
			req.setAttribute("msg", "恭喜激活成功，请马上登录！");
		} catch (UserException e) {
			// 说明service抛出了异常
			req.setAttribute("msg", e.getMessage());
			req.setAttribute("code", "error");// 通知msg.jsp显示X
		}
		return "jsps/msg";
	}

	// 登录功能
	@RequestMapping("/login")
	public String login(User user, HttpServletRequest request, HttpServletResponse response) {
		/*
		 * 4. 查看用户是否存在，如果不存在：
		 *   * 保存错误信息：用户名或密码错误
		 *   * 保存用户数据：为了回显
		 *   * 转发到login.jsp
		 * 5. 如果存在，查看状态，如果状态为false：
		 *   * 保存错误信息：您没有激活
		 *   * 保存表单数据：为了回显
		 *   * 转发到login.jsp
		 * 6. 登录成功：
		 * 　　* 保存当前查询出的user到session中
		 *   * 保存当前用户的名称到cookie中，注意中文需要编码处理。
		 */
		// 1. 封装表单数据到User
		// 2. 校验表单数据
		Map<String, String> errors = validateLogin(user, request.getSession());
		if(errors.size() > 0) {
			request.setAttribute("user", user);
			request.setAttribute("errors", errors);
			return "user/login";
		}
		// 3. 使用service查询，得到User
		User userFind = userService.login(user);
		// 4. 判断
		if(userFind == null) {
			request.setAttribute("msg", "用户名或密码错误！");
			request.setAttribute("user", user);
			return "user/login";
		} else {
			if(!userFind.isStatus()) {
				request.setAttribute("msg", "您还没有激活！");
				request.setAttribute("user", user);
				return "user/login";				
			} else {
				// 保存用户到session
				request.getSession().setAttribute("sessionUser", userFind);
				// 获取用户名保存到cookie中
				String loginName = user.getLoginName();
				try {
					loginName = URLEncoder.encode(loginName, "utf-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				Cookie cookie = new Cookie("loginName", loginName);
				cookie.setMaxAge(60 * 60 * 24 * 10);//保存10天
				response.addCookie(cookie);
				return "redirect:/index.jsp";//重定向到主页
			}
		}
	}

	private Map<String, String> validateLogin(User user, HttpSession session) {
		Map<String, String> errors = new HashMap<String, String>();
		// 校验登录名
				String loginName = user.getLoginName();
				if (loginName == null || loginName.trim().isEmpty()) {
					errors.put("loginName", "用户名不能为空");
				} else if (loginName.length() < 3 || loginName.length() > 20) {
					errors.put("loginName", "用户名长度必须在3~20之间");
				} else if (!userService.ajaxValidateLoginName(loginName)) {
					errors.put("loginName", "用户不存在");
				}
				// 校验密码
				String loginPwd = user.getLoginPwd();
				if (loginPwd == null || loginPwd.trim().isEmpty()) {
					errors.put("loginPwd", "密码不能为空");
				} else if (loginPwd.length() < 3 || loginPwd.length() > 20) {
					errors.put("loginPwd", "密码长度必须在3~20之间");
				}
				// 校验验证码
				String verifyCode = user.getVerifyCode();
				String vCode = (String) session.getAttribute("vCode");
				if (verifyCode == null || verifyCode.trim().isEmpty()) {
					errors.put("verifyCode", "验证码不能为空");
				} else if (!verifyCode.equalsIgnoreCase(vCode)) {
					errors.put("verifyCode", "验证码错误");
				}
				// 返回错误Map
				return errors;
	}

	// 修改密码
	@RequestMapping("/updatePassword")
	public String updatePassword(User user, HttpServletRequest request) {
		User sessionUser = (User) request.getSession().getAttribute("sessionUser");
		if (sessionUser == null) {
			request.setAttribute("msg", "您还未登录!");
			return "user/login";
		}
		try {
			userService.updatePassword(sessionUser.getUId(), user.getNewLoginPwd(), user.getLoginPwd());
			request.setAttribute("msg", "修改密码成功，请重新登录");
			request.setAttribute("code", "success");
			request.getSession().invalidate();
			return "jsps/msg";
		} catch (UserException e) {
			request.setAttribute("msg", e.getMessage());
			request.setAttribute("user", user);
//			request.setAttribute("code", "error");
			return "jsps/user/pwd";
		}
	}

	// 退出
	@RequestMapping("/quit")
	public String quit(HttpSession session) {
		session.invalidate();
		return "jsps/user/login";
	}
}