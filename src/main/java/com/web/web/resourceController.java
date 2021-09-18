package com.web.web;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;
import com.web.entity.PhotoRecord;
import com.web.entity.Reply;
import com.web.entity.Resource;
import com.web.entity.Users;
import com.web.service.UserService;
import com.web.service.replyService;
import com.web.service.resourceService;
import com.web.tool.url;
import com.web.util.CutBigImage;

import net.sf.json.JSONArray;

@Controller
public class resourceController {
	
	@Autowired
	private resourceService rs;
	
	@Autowired
	private UserService us;
	
	@Autowired
	private replyService rps;
	
	@RequestMapping("/resource")
	public String resource(){
		return "resource";
	}
	
	@RequestMapping("/resource2")
	@ResponseBody
	public JSONArray resource2(int page,int limit,String keyword) throws UnsupportedEncodingException{
		if(keyword!=null){
			keyword = "%"+new String(keyword.getBytes("ISO-8859-1"), "UTF-8")+"%";
			List<Resource> list = rs.getResourcesBykw(page, limit,keyword);
			PageInfo pageInfo = new PageInfo(list);
			JSONArray jsonArray = JSONArray.fromObject(pageInfo);
			return jsonArray;
		}else{
			List<Resource> list = rs.getResources(page, limit);
			PageInfo pageInfo = new PageInfo(list);
			JSONArray jsonArray = JSONArray.fromObject(pageInfo);
			return jsonArray;
		}
	}
	
	@RequestMapping("/resourcedetail")
	public String resourcedetail(HttpSession session,Long resourceId){
		session.setAttribute("resourceId", resourceId);
		return "resourcedetail";
	}
	
	@RequestMapping("/resourcedetail2")
	@ResponseBody
	public JSONArray resourcedetail2(HttpSession session){
		Long resourceId = (Long)session.getAttribute("resourceId");
		Resource resource = rs.getResource(resourceId);
		JSONArray jsonArray = JSONArray.fromObject(resource);
		return jsonArray;
	}
	
	@RequestMapping("/reply")
	@ResponseBody
	public JSONArray reply(HttpSession session,int page,int limit){
		Long resourceId = (Long)session.getAttribute("resourceId");
		List<Reply> list = rs.getReplys(resourceId, page, limit);
		PageInfo pageInfo = new PageInfo(list);
		JSONArray jsonArray = JSONArray.fromObject(pageInfo);
		return jsonArray;
	}
	
	@RequestMapping("/addreply")
	public void addreply(HttpServletRequest request,HttpServletResponse response,HttpSession session,String phonenumber,Long resourceId,String replyContent) throws Exception{
		Users u = us.getUserID(phonenumber);
		Long userId = u.getUserId();
//		replyContent = new String(replyContent.getBytes("ISO-8859-1"), "UTF-8");
		replyContent = request.getParameter("replyContent");
		Reply reply = new Reply();
		reply.setUserId(userId);
		reply.setResourceId(resourceId);
		reply.setReplyContent(replyContent);
		rps.addReply(reply);
		request.getRequestDispatcher("/resourcedetail?resourceId="+resourceId).forward(request, response);
		return; 
	}
	
	@RequestMapping("/resourceupload")
	public String resourceupload(){
		return "resourceupload";
	}
	
	@RequestMapping("/resourceupload2")
	@ResponseBody
	public JSONArray resourceupload2(HttpSession session,String name,String description,MultipartFile file,Integer credit) throws Exception{
		Users user = (Users) session.getAttribute("user");
		Users u = us.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		Date d1 = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
		String res = sdf.format(new Date());
		// uploads文件夹位置
		String rootPath = url.dir;
		// 原始名称
		String originalFileName = file.getOriginalFilename();
		// 新文件名
		String newFileName = "sliver" + res + originalFileName.substring(originalFileName.lastIndexOf("."));
		// 创建年月文件夹
		Calendar date = Calendar.getInstance();
		File dateDirs = new File(userId.toString());

		// 新文件
		File newFile = new File(rootPath + File.separator + dateDirs + File.separator+"resource" +File.separator+ newFileName);
		// 判断目标文件所在目录是否存在
		if (!newFile.getParentFile().exists()) {
			// 如果目标文件所在的目录不存在，则创建父目录
			newFile.getParentFile().mkdirs();
		}
		System.out.println(newFile);
		// 将内存中的数据写入磁盘
		file.transferTo(newFile);
		// 完整的url
		String fileUrl = url.dir +"/"+ userId.toString() + "/" +"resource"+"/"+ newFileName;
		Resource resource = new Resource();
		resource.setResourceName(name);
		resource.setResourceDescription(description);
		resource.setResourceUrl(userId.toString() + "/" +"resource"+"/"+ newFileName);
		resource.setUserId(userId);
		resource.setResourceCredit(credit);
		rs.addResource(resource);
		return null;
	}
	
	@RequestMapping("/resourcedownload")
	public ResponseEntity<byte[]> resourcedownload(HttpSession session,HttpServletRequest request,Long resourceId) throws Exception{
		Users user = (Users) session.getAttribute("user");
		Users u = us.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		Double umoney = user.getMoney();
		Double credit = rs.getResourceCredit(resourceId);
		us.updateMoney(userId, umoney-credit);
		user.setMoney(umoney-credit);
		System.out.println(user.getMoney());
		session.setAttribute("user", user);
		
		Long ruserId = rs.getUserId(resourceId);
		Users r = us.getUserInfo(ruserId);
		Double rmoney = r.getMoney();
		us.updateMoney(ruserId, rmoney+credit);
		
		String path = url.dir;
		Resource resource = rs.getResource(resourceId);
		String fileName = resource.getResourceUrl();
		String realname = resource.getResourceName();
		File file=new File(path+File.separator+fileName);
		if(!file.isFile()){
			return null;
		}
		@SuppressWarnings("resource")
		InputStream input=new FileInputStream(file);
		byte[] buff=new byte[input.available()]; // 获取文件大小
		input.read(buff) ;
		HttpHeaders headers=new HttpHeaders();
		realname = URLEncoder.encode(realname,"utf-8");
		headers.add("Content-Disposition", "attachment;filename="+realname+"."+fileName.split("\\.")[1]);
		HttpStatus status=HttpStatus.OK;
		ResponseEntity<byte[]> entity=new ResponseEntity<byte[]>(buff,headers,status);
		return  entity;
	}
}
