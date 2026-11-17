package com.daowen.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.daowen.util.JsonResult;

import jdk.nashorn.internal.scripts.JS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daowen.entity.Users;
import com.daowen.service.UsersService;
import com.daowen.ssm.simplecrud.SimpleController;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;


@Controller
public class AdminUserController extends SimpleController {

	@Autowired
	private UsersService usersService;


	@ResponseBody
	@PostMapping("/admin/login")
	public JsonResult login() {
		String usertype = request.getParameter("usertype");

		if (usertype != null && usertype.equals("1")) {
			return adminLogin();
		}
		return JsonResult.error(-2,"账户类型不对");

	}

	private JsonResult adminLogin() {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		HashMap<String,Object> map=new HashMap<>();
		map.put("username",username);
		Users u = usersService.loadPlus(map);
		if (u == null) {
			return JsonResult.error(-1,"用户名不存在");
		}

		if (password!=null&&!password.equals(u.getPassword())) {
			return JsonResult.error(-3,"用户名和密码不匹配");
		}
		HttpSession session = request.getSession();
		usersService.executeUpdate("update users set logtimes=logtimes+1 where id="+u.getId());
		session.setAttribute("users", u);
		return JsonResult.success(1,"登录成功");
	}

	@PostMapping("/adminuser/exit")
	@ResponseBody
	public JsonResult exit(){
		if (request.getSession().getAttribute("users") != null) {
			System.out.println("系统退出");
			request.getSession().removeAttribute("users");
		}
		return  JsonResult.success(1,"退出成功");
	}



}

