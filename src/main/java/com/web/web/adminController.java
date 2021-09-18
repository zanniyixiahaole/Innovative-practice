package com.web.web;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.text.SimpleDateFormat;
import java.io.File;
import java.util.Date;
import java.io.FileWriter;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.entity.PhotoRecord;
import com.web.entity.PhotoWord;
import com.web.entity.Users;
import com.web.entity.WordSourceInfo;
import com.web.entity.book;
import com.web.entity.bookRecord;
import com.web.entity.bookword;
import com.web.service.UserService;
import com.web.service.bookService;
import com.web.service.bookRecordService;
import com.web.service.bookwordService;
import com.web.service.photorecordService;
import com.web.service.photowordService;
import com.web.service.wordService;
import com.alibaba.fastjson.JSONObject;
import com.web.service.bookService;
import com.web.tool.PDF2IMAGE;
import com.web.tool.url;

@Controller
public class adminController {
	@Autowired
	private photorecordService photorecordService;
	@Autowired
	private photowordService photoWordService;
	@Autowired
	private wordService wordService;
	@Autowired
	private UserService userService;
	@Autowired
	private bookService bookService;
	@Autowired
	private bookRecordService bookRecordService;
	@Autowired
	private bookwordService bookWordService;
	
	@RequestMapping("/adminlogin")
	public String adminlogin(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		Users user=(Users)session.getAttribute("user");
		if(user==null)
		{
			return "admin/adminlogin";
		}
		else if(user.getAdminFlag()==1)
		{
			return "admin/loginIndex";
		}
		else if(user.getAdminFlag()==0){
			request.setAttribute("msg", "此账号不是管理员账号，请重新登录！");
			System.out.println("登录失败！");
			return "admin/adminlogin";
		}else{
			return "admin/adminlogin";
		}
		
	}

	@RequestMapping("/loginIndex")
	public String loginIndex(@Param("username") String username, @Param("password") String password, Map<String, Object> map,
			HttpServletRequest request, HttpServletResponse response) {
		Users user = userService.getByPhonenumberAndPassword(username, password);
		HttpSession session = request.getSession();
	//	System.out.println("当前的sessionId是:"+session.getId());
		if (user!=null) {
			if(user.getAdminFlag()==1){
			// ==========新增
			// 保存登录时间
			Date loginTime = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String ltime = sdf.format(loginTime);
			int num = user.getLoginNum().intValue() + 1;
//						System.out.println("登录时间为：" + ltime);
//						System.out.println("登录次数为：" + num);
			// 更新数据库中用户的上一次登录时间和登录次数
			boolean flag = userService.UpdataTimeAndNum(ltime, num, user.getUserId());
//						if (flag == true)
//							System.out.println("时间和次数更新成功！");
			File file = new File(url.dir + "\\temp.txt");
			if (!file.exists()) {
				try {
					file.createNewFile();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			FileWriter writer;
			try {
				writer = new FileWriter(file,true);//true表示可追加写入
				System.out.println(ltime);
				writer.write(user.getPhonenumber()+"---"+ltime+", "+num);
				writer.write("\r\n");
				writer.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			//活跃度排名
			List<Users> rank = userService.getRank();
			for(int i=0;i<rank.size();i++) {
				if(rank.get(i).getUserId().intValue()==user.getUserId().intValue())
					session.setAttribute("rank", i+1);//将排名放入session中
				System.out.println(i);
			}
			// 新增========

			session.setAttribute("user", user);// 放在session域中，执行某些操作需要先判断用户是否登录
			System.out.println("登录成功！");
			return "admin/loginIndex";
			}
			else 
			{
				request.setAttribute("msg", "此账号不是管理员账号，请重新登录！");
				System.out.println("登录失败！");
				return "admin/adminlogin";
				
			}
		} 
		
		else  
		{
			request.setAttribute("msg", "账号或密码错误，请重新登录！");
			System.out.println("登录失败！");
			return "admin/adminlogin";
		}
	}

	@RequestMapping("/adminleft")
	public String adminleft() {
		return "admin/left";
	}

	@RequestMapping("/admintop")
	public String admintop() {
		return "admin/adminhead";
	}

	@RequestMapping("/adminbottom")
	public String adminbottom() {
		return "admin/bottom";
	}

	@RequestMapping("/adminswitch")
	public String adminswitch() {
		return "admin/switch";
	}

	@RequestMapping("/adminmain")
	public String adminmain() {
		return "admin/main";
	}

	@RequestMapping("/table")
	public String table(HttpServletRequest request) {
		return "admin/table";
	}

	@RequestMapping(value = "/searchByUserId")
	@ResponseBody
	public String search(@Param("userId") String userId) {
		List<PhotoRecord> pr = null;
		Map<Object, Object> map = new HashMap();
		if(userId==null||userId==""){
			pr = photorecordService.photoList();
		} else {
			pr = photorecordService.photoRecords(Long.valueOf(userId));			
		}
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", pr.size());
		map.put("data", pr);
		return JSONObject.toJSONString(map);
	}
	@RequestMapping("/userList")
	public String userList() {
		return "admin/userList";
	}
	
	@RequestMapping(value = "/getUsers")
	@ResponseBody
	public String searchUsers(@Param("phoneNumber") String phoneNumber) {
		List<Users> u = null;
		Map<Object, Object> map = new HashMap();
		if(phoneNumber==null||phoneNumber==""){
			u = userService.getAllUsers();
		} else {
			u = new ArrayList();
			u.add(userService.getUser(phoneNumber));			
		}
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", u.size());
		map.put("data", u);
		return JSONObject.toJSONString(map);
	}
	
	@RequestMapping("/searchCharAdmin")
	public String selectChar(){
		return "admin/searchCharAdmin";
	}
	//通过文字查询所有识别记录
	@RequestMapping(value = "/searchByWord")
	@ResponseBody
	public String searchByWord(@Param("word") String word) {
		PhotoRecord temPr = null;
		List<PhotoWord> pw = null;
		PhotoWord temPw = null;
		List<Map<Object,Object>> dataList = new ArrayList();
		Map<Object, Object> map = new HashMap();
		int wordId;
		if(word == null||word==""){

		} else {
			try {
				wordId = wordService.getWord(new String(word.getBytes("ISO-8859-1"), "UTF-8")).getWordId();
				pw = photoWordService.getPhotoWordByWordId(wordId);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Iterator<PhotoWord> iter = pw.iterator();
			while(iter.hasNext()){
				temPw = iter.next();
				temPr = photorecordService.photoRecord(temPw.getPhotoRecord());
				Map<Object, Object> dataMap = new HashMap();
				dataMap.put("userId",temPr.getUserId());
				dataMap.put("photoWordRecord",temPw.getPhotoWordRecord());
				dataMap.put("photoRecord",temPw.getPhotoRecord());
				dataMap.put("dateTime",temPr.getDateTime());
				dataMap.put("recordUrl",temPr.getRecordUrl());
				dataMap.put("wordUrl",temPw.getWordUrl());
				dataList.add(dataMap);
			}
		}
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", dataList.size());
		map.put("data", dataList);
		return JSONObject.toJSONString(map);
	}
	//跳转识别详情
	@RequestMapping(value = "/recognizeDetail")
	public String recognizeDetail(HttpServletRequest request) {
		String photoSrc = request.getParameter("photoSrc");
		String sourcePhotoSrc = "http://localhost:8080/FTZ/" + photoSrc;
		String simplifiedPhotoSrc = sourcePhotoSrc.split("\\.")[0] + "_Simplified.jpg";
		request.setAttribute("sourcePhotoSrc", sourcePhotoSrc);
		request.setAttribute("simplifiedPhotoSrc", simplifiedPhotoSrc);
		return "personalPhoto/recognizeDetail";
	}
	
	//更新用户权限
	@RequestMapping("/updatePermission")
	@ResponseBody
	public int updatePermission(HttpServletRequest request){
		Long userId = Long.parseLong(request.getParameter("userId"));
		Integer value = Integer.parseInt(request.getParameter("value"));
		if(userService.updatePermission(userId,value)){
			return 1;
		} else {
			return 0;
		}
	}
	@RequestMapping("/adminTopSwitch")
	public String adminTopSwitch() {
		return "admin/topSwitch";
	}
	//根据userId取得用户所有信息，包括个人信息，book信息，bookRecord信息，bookWord信息，PhotoRecord信息，PhotoWord信息
	@RequestMapping("/getAllInfoByUserId")
	@ResponseBody
	public String getAllInfoByUserId(HttpServletRequest request){
		Long userId = Long.parseLong(request.getParameter("userId"));
		Users user = userService.getUserInfo(userId);
		//查找PhotoRecord信息
		List<PhotoRecord> photoRecords = photorecordService.photoRecords(userId);
		user.setPhotoRecords(photoRecords);
		Iterator<PhotoRecord> prIter = photoRecords.iterator();
		while(prIter.hasNext()){
			PhotoRecord tempPhotoRecord = prIter.next();
			Long tempRecord = tempPhotoRecord.getRecord();
			//查找PhotoWord信息
			List<PhotoWord> photoWords = photoWordService.getPhotoWordByRecord(tempRecord);
			tempPhotoRecord.setWordList(photoWords);
		}
		//查找book信息
		List<book> books = bookService.select(userId);
		user.setBooks(books);
		Iterator<book> bkIter = books.iterator();
		while(bkIter.hasNext()){
			book tempBook = bkIter.next();
			Long tempBookId = tempBook.getBookid();
			//查找bookRecord信息
			List<bookRecord> bookRecords = bookRecordService.bookRecordSelect(tempBookId);
			tempBook.setBookRecords(bookRecords);
			Iterator<bookRecord> brIter = bookRecords.iterator();
			while(brIter.hasNext()){
				bookRecord tempBookRecord = brIter.next();
				Long tempRecord = tempBookRecord.getBookrecord();
				//查找bookWord信息
				List<bookword> bookWords = bookWordService.getByBookRecord(tempRecord);
				tempBookRecord.setBookWords(bookWords);
			}
		}
		return JSONObject.toJSONString(user);
	}
	@RequestMapping(value = "/pdfList")
	public String pdfList(HttpServletRequest request){
		List<book> books;
		String idStr = request.getParameter("userId");
		if(idStr!=null){
			if(idStr.equals("")){//参数userId为空字符串，表示查询所有用户的book信息
				books = bookService.selectAll();
			} else {//参数userId不为空字符串，表示查询一个用户的book信息
				books = bookService.select(Long.parseLong(idStr));	
			}
		} else {//参数userId为空，表示查询所有用户的book信息
			books = bookService.selectAll();
		}
		Iterator<book> iter = books.iterator();
		@SuppressWarnings("rawtypes")
		List<Map> mapList = new ArrayList();
		while(iter.hasNext()){
			book tempBook = iter.next();
			Map<String,Object> bookInfoMap = new HashMap();
			bookInfoMap.put("bookId", tempBook.getBookid());
			bookInfoMap.put("userId", tempBook.getUserID());
			bookInfoMap.put("bookName", tempBook.getBookname());
			bookInfoMap.put("bookPage", tempBook.getBookpage());
			bookInfoMap.put("bookUrl", tempBook.getBookurl());
			bookInfoMap.put("flag", tempBook.getFlag());
			bookInfoMap.put("dateTime", tempBook.getBookdatetime());
			bookInfoMap.put("bookMoney", tempBook.getBookmoney());
			//根据bookId查询已识别的页码数量
			int recognizedPageNum = bookRecordService.getRecognizedPageNumByBookId(tempBook.getBookid());
			String recognizedProgress = new DecimalFormat("#").format(((double)recognizedPageNum*100)/tempBook.getBookpage());
			bookInfoMap.put("recognizedProgress", recognizedProgress);
			int recognizedWordsNum = bookService.getRecognizedWordsNum(tempBook.getBookid());
			bookInfoMap.put("recognizedWordsNum", recognizedWordsNum);
			mapList.add(bookInfoMap);
		}
		request.setAttribute("bookInfoJson", JSONObject.toJSONString(mapList));
		return "admin/PdfList";
	}
	@RequestMapping(value = "/pdfPhotoListAdmin")
	public String pdfPhotoListAdmin(HttpServletRequest request){
		List<bookRecord> br = null;
		String idStr = request.getParameter("bookId");
		Long bookId = Long.parseLong(idStr);
		book bk = bookService.selectById(bookId);
		br = bookRecordService.bookRecordSelect(bookId);
		@SuppressWarnings("rawtypes")
		List<Map> mapList = new ArrayList();
		Iterator<bookRecord> brIter = br.iterator();
		while(brIter.hasNext()){
			Map<String,Object> tempMap = new HashMap();
			bookRecord tempBr = brIter.next();
			tempMap.put("page", tempBr.getRecpage());
			tempMap.put("recognized", tempBr.getRecflag());
			tempMap.put("photoSrc", bk.getBookurl() + "/" + bk.getBookname() + "_" +tempBr.getRecpage() + ".jpg");
			mapList.add(tempMap);
		}
		request.setAttribute("pdfPhotoListJson", JSONObject.toJSONString(mapList));;
		return "admin/pdfPhotoListAdmin";
	}
	//从书籍查找文字来源,跳转到searchCharFormPdfAdmin.jsp页面
	@RequestMapping("/searchCharFromPdfAdmin")
	public String searchCharFromPdfAdmin(){
		return "admin/searchCharFromPdfAdmin";
	}
	//从书籍查找文字来源，返回json数据
	@RequestMapping(value = "/searchCharByWordFromPdf")
	@ResponseBody
	public String searchCharByWordFromPdf(@Param("word") String word){
		List<WordSourceInfo> wsi = new ArrayList();;
		int wordId;
		Map<Object, Object> map = new HashMap();
		if(word == null||word==""){
			
		} else {
			try {
				wordId = wordService.getWord(new String(word.getBytes("ISO-8859-1"), "UTF-8")).getWordId();
				wsi = bookService.searchWordSourceAdmin(wordId);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", wsi.size());
		map.put("data", wsi);
		return JSONObject.toJSONString(map);
	}
	//管理平台图片管理：图片列表
	@RequestMapping("/photoList")
	public String photoList(HttpServletRequest request) {
		List<PhotoRecord> pr = null;
		String idStr = request.getParameter("userId");
		if(idStr!=null){
			if(idStr.equals("")){//参数userId为空字符串，表示查询所有用户的photo信息
				pr = photorecordService.photoList();
			} else {//参数userId不为空字符串，表示查询一个用户的photo信息
				pr = photorecordService.photoRecords(Long.valueOf(request.getParameter("userId")));	
			}
		} else {//参数userId为空，表示查询所有用户的photo信息
			pr = photorecordService.photoList();
		}
		request.setAttribute("photoListJson", JSONObject.toJSONString(pr));;
		return "admin/photoList";
	}
	///管理员添加pdf
		@RequestMapping("/adminaddpdf")
	    @ResponseBody
	  	public String adminaddpdf(@RequestParam("file") MultipartFile file, HttpServletRequest request,HttpSession session,Model model) {  
	        // 判断文件是否为空  
	    	String fname=request.getParameter("fname");
	    	String lname=request.getParameter("lname");
	    	String phonenumber=request.getParameter("phonenumber");
	    	System.out.println(lname);
	    	String flag=new String();
	        if (!file.isEmpty()) {  
	            try {  
	            	//获取时间
	                Date d1 = new Date();
	                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
	        		String res = sdf.format(new Date());//20200227125641769   类似于这个东西
	                // 文件保存路径  
	            	Users user = (Users) session.getAttribute("user");
	                Users u = userService.getUserID(user.getPhonenumber());
	        		Long userId = u.getUserId();
	        		String filepath1=url.dir+"\\"+ userId.toString()+"\\PDF";
	                File file2=new File(filepath1);		
	                if(!file2.exists()){//如果文件夹不存在		
	                	file2.mkdir();//创建文件夹	
	                	}
	                String filePath = url.dir+"\\"+ userId.toString()+"\\PDF" 
	                        + System.getProperty("file.separator") 
	                       +file.getOriginalFilename().split("\\.")[0]+res+"."+file.getOriginalFilename().split("\\.")[1];  
	                // 转存文件  
	                file.transferTo(new File(filePath)); 

	                int page=PDF2IMAGE.pdf2Image(filePath,filepath1,res, 300,fname);///扔进pdf转照片的方法中
	                book savebook=new book();
	                String name=file.getOriginalFilename().split("\\.")[0];///获取书的名字（不带扩展名）
					savebook.setBookname(fname);
					savebook.setBookpage(page);  
					savebook.setBookurl( userId.toString()+"//PDF//"+name+res);
					savebook.setFlag(0);  
					savebook.setUserID(userId);
					savebook.setBookdatetime(d1);
					savebook.setBookmoney(Long.valueOf(lname));
					if("".equals(phonenumber)||phonenumber==null)
						savebook.setBookbelonging(1);
					else 
					{
						savebook.setBookbelonging(userService.getUserID(phonenumber).getUserId());
						
						
					}
					savebook.setMoneyflag(2);
					bookService.saveBook(savebook);//////往book表写入数据	
					bookRecord savebookRecord=new bookRecord();
					savebookRecord.setBookid(savebook.getBookid());
					savebookRecord.setRecflag(0);
					savebookRecord.setRecbookdatetime(d1);
					for(int i=1;i<=page;i++)
					{
						savebookRecord.setRecpage(i);
						bookRecordService.saveBookRecord(savebookRecord);
					}//将pdf每页数据写入book_record。
					flag=String.valueOf(savebook.getBookid());
	            } catch (Exception e) {  
	                e.printStackTrace();  
	            }  

	            return flag;  
	        }
	        else
	        { 	flag="error";
	        return flag; } 
	  		}
		@RequestMapping("/pdfrenwu")
	  	public String pdfrenwuadd(HttpSession session,HttpServletRequest request) {
	    	//flagPage
	    	if("0".equals(request.getParameter("flagPage")))
	    	{
	    		return "pdf/adminaddpdf";
	    	}
	    	else if("1".equals(request.getParameter("flagPage")))
	    	{
	    		request.setAttribute("flagPage", "1");
	    		return "admin/TaskDistributionAndModify";
	    	}
	    	else if("2".equals(request.getParameter("flagPage")))
	    	{
	    		request.setAttribute("flagPage", "2");
	    		return "admin/TaskDistributionAndModify";
	    	}
	    	else if("3".equals(request.getParameter("flagPage")))
	    	{
	    		 
	  	       
	  	        Users user = (Users) session.getAttribute("user");
	  	        Users u = userService.getUserID(user.getPhonenumber());
	  	        Long userId = u.getUserId();
	  	        List<book> books=bookService.selectBymoneyflag(0);
		  	     
	  	      Iterator<book> iter = books.iterator();
	  	      @SuppressWarnings("rawtypes")
	  	      List<Map> mapList = new ArrayList();
	  	      while(iter.hasNext()){
	  	        book tempBook = iter.next();
	  	        Map<String,Object> bookInfoMap = new HashMap();
	  	        bookInfoMap.put("bookId", tempBook.getBookid());
	  	        bookInfoMap.put("phonenumber",userService.getUserInfo(tempBook.getBookbelonging()).getPhonenumber() );
	  	        bookInfoMap.put("userId", tempBook.getUserID());
	  	        bookInfoMap.put("bookName", tempBook.getBookname());
	  	        bookInfoMap.put("bookPage", tempBook.getBookpage());
	  	        bookInfoMap.put("bookUrl", tempBook.getBookurl());
	  	        bookInfoMap.put("flag", tempBook.getFlag());
	  	        bookInfoMap.put("dateTime", tempBook.getBookdatetime());
	  	        bookInfoMap.put("bookMoney", tempBook.getBookmoney());
//	  	        int recognizedWordsNum = bookService.getRecognizedWordsNum(tempBook.getBookid());
//	  	        bookInfoMap.put("recognizedWordsNum", recognizedWordsNum);
	  	        mapList.add(bookInfoMap);
	  	      }
	  	      request.setAttribute("userId", userId);
	  	      request.setAttribute("bookInfoJson", JSONObject.toJSONString(mapList));
	  	      return "admin/taskCheckList";
	    		
	    	}
	    	else{
	    		return "fail";
	    	}
	  			
	  	}
		//ModifyTask
		////修改PDF任务
			@RequestMapping("/ModifyTask")
			public String ModifyTask(HttpServletRequest request){
				String phonenumber =request.getParameter("phonenumber");
				String flagpage =request.getParameter("flagpage");
				String bookida=request.getParameter("bookida");
				//System.out.println(phonenumber);
				//System.out.println(flagpage);
				//System.out.println(bookida);
				
				if(phonenumber==null||"".equals(phonenumber)||userService.getUserID(phonenumber)==null||bookida==null||"".equals(bookida))
				{
					request.setAttribute("flagPage", flagpage);
					request.setAttribute("msg", "分配的用户不能为空或者分配人的手机号不存在或者该书不存在");
		    		return "admin/TaskDistributionAndModify";
				}
				else{
					Users user=userService.getUserID(phonenumber);
					long userid=user.getUserId();
					book b=bookService.selectById(Long.parseLong(bookida));
					if(b.getFlag()==1)
					{
						request.setAttribute("msg", "已经被用户"+userService.getUserInfo(b.getBookbelonging()).getPhonenumber()+"识别过了");
						
						request.setAttribute("flagPage", flagpage);
			    		return "admin/TaskDistributionAndModify";
					}
					else
					{
						b.setBookbelonging(userid);
						bookService.UpdataBook(b);
						if("1".equals(flagpage))
							request.setAttribute("msg", "任务分配成功");
						else if("2".equals(flagpage))
							request.setAttribute("msg", "任务修改成功");
						else
							request.setAttribute("msg", "后台flagpage不正确请重试");
						
						request.setAttribute("flagPage", flagpage);
			    		return "admin/TaskDistributionAndModify";
					}
					
				}
			}
			
			
			
		
			//管理员任务校验的查看识别效果的响应。
		    @RequestMapping(value = "/TaskMoneywaitDetail")
		    public String pdfDetail(HttpSession session,HttpServletRequest request){

		      Long bookId = Long.parseLong(request.getParameter("bookId"));
		      book bk = bookService.selectById(bookId);
		      String bookName = bk.getBookname();
		      Integer bookPage = bk.getBookpage();
		      String bookUrl = bk.getBookurl();
		      @SuppressWarnings("rawtypes")
		      List<Map> infoList = new ArrayList();
		      for(int i = 1; i <= bookPage ; i++){
		        String tempUrl = "" + bookUrl + "/" + bookName + "_" + i + ".jpg";
		        Integer tempRecFlag = bookRecordService.searchRecognizedBybookIdAndRecPage(bookId,i);
		        Map<String, Object> infoMap = new HashMap();
		        infoMap.put("url", tempUrl);
		        infoMap.put("recFlag", tempRecFlag);
		        infoList.add(infoMap);
		      }
		      if(request.getParameter("indexValue")==null){
		        request.setAttribute("indexValue", 1);
		      } else {
		        request.setAttribute("indexValue", Integer.parseInt(request.getParameter("indexValue")));
		      }
		      request.setAttribute("bookId", bookId);
		      request.setAttribute("infoJson", JSONObject.toJSONString(infoList));
		      
		      return "admin/TaskCheckPhotoList";
		    }
		    //管理员将积分发放给用户。
		    @RequestMapping(value = "/MoneyGet")
		    public String taskGet(HttpSession session,HttpServletRequest request){
		      Users user = (Users) session.getAttribute("user");
		      Users u = userService.getUserID(user.getPhonenumber());
		      Long userId = u.getUserId();
		     
		      Long bookId = Long.parseLong(request.getParameter("bookId"));
//		      System.out.println(bookId);
		      book bk = bookService.selectById(bookId);
		      bk.setMoneyflag(1);
		      bookService.UpdataBook(bk);
		      Users user2=userService.getUserInfo(bk.getBookbelonging());
		      user2.setMoney(user2.getMoney()+bk.getBookmoney());//更新money
		      user2.setMoneyWait(user2.getMoneyWait()-bk.getBookmoney());
		      userService.UpdatePassword(user2);//更新所有信息
		      
		      List<book> books=bookService.selectBymoneyflag(0);
		    Iterator<book> iter = books.iterator();
		    @SuppressWarnings("rawtypes")
		    List<Map> mapList = new ArrayList();
		    while(iter.hasNext()){
		      book tempBook = iter.next();
		      Map<String,Object> bookInfoMap = new HashMap();
		      bookInfoMap.put("bookId", tempBook.getBookid());
		      bookInfoMap.put("userId", tempBook.getUserID());
		      bookInfoMap.put("bookName", tempBook.getBookname());
		      bookInfoMap.put("bookPage", tempBook.getBookpage());
		      bookInfoMap.put("bookUrl", tempBook.getBookurl());
		      bookInfoMap.put("flag", tempBook.getFlag());
		      bookInfoMap.put("dateTime", tempBook.getBookdatetime());
		      bookInfoMap.put("bookMoney", tempBook.getBookmoney());
//		      int recognizedWordsNum = bookService.getRecognizedWordsNum(tempBook.getBookid());
//		      bookInfoMap.put("recognizedWordsNum", recognizedWordsNum);
		      mapList.add(bookInfoMap);
		    }
		    request.setAttribute("userId", userId);
		    request.setAttribute("bookInfoJson", JSONObject.toJSONString(mapList));
		    return "admin/taskCheckList";
		    }
}
