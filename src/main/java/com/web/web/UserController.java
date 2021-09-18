package com.web.web;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.web.entity.Users;
import com.web.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	//个人中心
	@RequestMapping("/personalCenter")
	public String personalCenter() {
		
		return "person/personalCenter";
	}
	
	@RequestMapping("/head")
	public String head(){
		return "head";
	}
	
}
