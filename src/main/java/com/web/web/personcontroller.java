package com.web.web;
import com.web.tool.url;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.entity.bookRecord;
import com.web.service.bookRecordService;
import com.web.service.bookService;
import net.sf.json.JSONArray;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.web.entity.PhotoRecord;
import com.web.entity.PhotoWord;
import com.web.entity.Reply;
import com.web.entity.Users;
import com.web.entity.WordSourceInfo;
import com.web.entity.book;
import com.web.service.UserService;
import com.web.service.photorecordService;
import com.web.service.photowordService;
import com.web.service.replyService;
import com.web.service.wordService;
import com.web.service.bookService;
import com.web.service.bookRecordService;
import com.web.util.XmlToJson;

@Controller
public class personcontroller {
	@Autowired
	private UserService userService;
	@Autowired
	private photorecordService photorecordService;
	@Autowired
	private wordService wordService;
	@Autowired
	private photowordService photoWordService;
	@Autowired
	private replyService rservice;

	@Autowired
	private bookService bookService;
	@Autowired
	private bookRecordService bookRecordService;

	@RequestMapping("/personmain")
	public String personmain() {
		return "person/personmain";
	}
	@RequestMapping("/personleft")
	public String personleft() {
		return "person/personleft";
	}

	@RequestMapping("/personInformation")
	public String personInformation(HttpSession session,HttpServletRequest request,Map<String,String> map){
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		System.out.println("userId:"+userId);
		Users userInfo = userService.getUserInfo(userId);


		map.put("phonenumber",userInfo.getPhonenumber());
		map.put("password",userInfo.getPassword());
		map.put("regDate",userInfo.getRegDate());
		map.put("isVIP",userInfo.getIsVIP().toString());
		map.put("money",userInfo.getMoney().toString());
		map.put("money_wait",userInfo.getMoneyWait().toString());
		map.put("book",userInfo.getBook().toString());
		map.put("photo",userInfo.getPhoto().toString());
//		private long userid;
//		   private String sex;
//		   private String occupation;
//		   private long id;
//		   private Integer age;
//		   private String name;
		if(userInfo.getSex()==1)
			map.put("sex","男");
		else if(userInfo.getSex()==0)
			map.put("sex","女");
		else
			map.put("sex","非法读取，请重新设置性别");

		if(userInfo.getAge()==0)
			map.put("age","非法读取，请重新设置年龄");
		else
			map.put("age",userInfo.getAge().toString());

		if(userInfo.getName().equals("0"))
			map.put("name","非法读取，请重新设置姓名");
		else
			map.put("name",userInfo.getName());

		if(userInfo.getOccupation().equals("0"))
			map.put("occupation","非法读取，请重新设置职业");
		else
			map.put("occupation",userInfo.getOccupation());
		request.setAttribute("map", map);
		return "person/personInformation";
	}
	@RequestMapping("/ChangPasswordto")
	public String ChangPasswordto(HttpSession session,HttpServletRequest request,Map<String,String> map){
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		Users userInfo = userService.getUserInfo(userId);
		userInfo.setUserId(userId);
//		userInfo.setIsVIP(2);
//		userInfo.setMoney(2.0);
		String password = request.getParameter("password");
		String checkpassword = request.getParameter("checkpassword");
//		//测试为什么改变密码的时候，丢失其他数据。
//		System.out.println("====================================================================");
//		System.out.println(user.getRegDate());
//		System.out.println(user.getBook());
//		System.out.println(user.getMoney());
//		System.out.println(user.getIsVIP());
//		System.out.println(user.getMoneyWait());
//		System.out.println("====================================================================");
		if(password.equals(checkpassword)&&!checkpassword.equals(""))
		{
			userInfo.setPassword(checkpassword);
			userService.UpdatePassword(userInfo);
			return "success";
		}
		else{
			return "fail";
		}

	}

	@RequestMapping("/ChangPassword")
	public String ChangPassword(HttpSession session,HttpServletRequest request,Map<String,String> map){

		return "person/ChangPassword";
	}
	@RequestMapping("/Changeinfo")
	public String Chang_info(HttpSession session,HttpServletRequest request,Map<String,String> map){

		return "person/Changeinfo";
	}
	//ChangInfoto
	@RequestMapping("/ChangInfoto")
	public String ChangInfoto(HttpSession session,HttpServletRequest request,Map<String,String> map) throws IOException {
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		Users usersinfo=userService.getUserInfo(userId);
		usersinfo.setUserId(userId);

		String sex = new String(request.getParameter("sex").getBytes("iso-8859-1"), "utf-8");//解决获取的前端数据中文乱码的问题
		String age = request.getParameter("age");

		String name = new String(request.getParameter("name").getBytes("iso-8859-1"), "utf-8");
		String occupation = new String(request.getParameter("occupation").getBytes("iso-8859-1"), "utf-8");
		System.out.println(sex+age+name+occupation);
		if((!sex.equals(""))&&(!age.equals(""))&&(!name.equals(""))&&(!occupation.equals("")))
		{


			usersinfo.setAge(Integer.parseInt(age));
			if(sex.equals("男"))
				usersinfo.setSex(1);
			else if(sex.equals("女"))
				usersinfo.setSex(0);
			else
				usersinfo.setSex(2);
			usersinfo.setName(name);
			usersinfo.setOccupation(occupation);
			userService.UpdatePassword(usersinfo);
			return "success";
		}
		else{
			return "fail";
		}

	}

	@RequestMapping("/personmage")
	public String personmage(HttpSession session,HttpServletRequest request,Map<String,String> map) {
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		System.out.println("userId:"+userId);
		Users userInfo = userService.getUserInfo(userId);
		map.put("phonenumber",userInfo.getPhonenumber());
		map.put("password",userInfo.getPassword());
		map.put("regDate",userInfo.getRegDate());
		map.put("isVIP",userInfo.getIsVIP().toString());
		map.put("money",userInfo.getMoney().toString());
		map.put("money_wait",userInfo.getMoneyWait().toString());
		map.put("book",userInfo.getPhoto().toString());
		map.put("photo",userInfo.getPhoto().toString());
		request.setAttribute("map", map);
		return  "person/topersonCenter";
	}
	@RequestMapping("/personalPhotoList")
	public String personalPhotoList(HttpSession session,HttpServletRequest request){

		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId  = u.getUserId();

		List<String> urls = photorecordService.personalPhotoList(userId);
		int indexValue ;
		//判断请求参数是否有indexValue
		if(request.getParameter("indexValue") == null){//没有则表示请求从用户个人中心或管理员平台发出
			indexValue = 1;//置为默认值1
		} else {//有则表示请求从用户对未识别的图片进行识别后发出
			indexValue = Integer.parseInt(request.getParameter("indexValue"));
		}
		request.setAttribute("urls", urls);
		request.setAttribute("indexValue", indexValue);
		return "personalPhoto/personalPhotoList";
	}
	//personalPhotoListReadedJSON

	///动态json传输
	@RequestMapping("/personalPhotoListReadedJSON")
	@ResponseBody
	public JSONArray personalPhotoListReadedJSON(HttpServletRequest request,HttpSession session) {

		JSONArray array = new JSONArray();
		System.out.println("------------------------------------------------");
		System.out.println("------------------------------------------------");
//	    	ArrayList<bookRecord> bookrecord = null;
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();

		System.out.println("-------------------------------------");
		List <PhotoRecord> photorecord=photorecordService.getPhotoRecordByUserId(userId);

		System.out.println("___________________________________________");
		for(int i = 0 ; i < photorecord.size() ; i++) {
			JSONObject ob=new JSONObject();
			//ob.put("record", photorecord.get(i).getRecord());
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			String regDate = sdf.format(photorecord.get(i).getDateTime());
			ob.put("datetime",regDate );
			List<PhotoWord> Photoword=photoWordService.getPhotoWordByRecord(photorecord.get(i).getRecord());
			ob.put("photoWordCount",Photoword.size() );
			ob.put("Recognized",photorecord.get(i).getRecognized());
			ob.put("recordurl", photorecord.get(i).getRecordUrl());

			array.add(ob);
		}
		System.out.print(array.toString());
		return array;
	}
	@RequestMapping("/searchChar")
	public String selectChar(HttpSession session,HttpServletRequest request){
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		request.setAttribute("userId", userId);
		return "personalPhoto/searchChar";
	}
	@RequestMapping(value = "/searchByUserIdAndWord")
	@ResponseBody
	public String searchByUserIdAndWord(@Param("userId") String userId,@Param("word") String word) {
		PhotoRecord temPr = null;
		List<PhotoWord> pw = null;
		PhotoWord temPw = null;
		List<Map<Object,Object>> dataList = new ArrayList ();
		Map<Object, Object> map = new HashMap ();
		int wordId;
		if(word == null||word==""||userId==null||userId==""){

		} else {
			try {
				wordId = wordService.getWord(new String(word.getBytes("ISO-8859-1"), "UTF-8")).getWordId();
				pw = photoWordService.getPhotoWordByUserIdAndWordId(Long.valueOf(userId), wordId);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Iterator<PhotoWord> iter = pw.iterator();
			while(iter.hasNext()){
				temPw = iter.next();
				temPr = photorecordService.photoRecord(temPw.getPhotoRecord());
				Map<Object, Object> dataMap = new HashMap ();
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
//	@RequestMapping("/recDetail")
//	public String recDetail(@Param("record") String record){
//		List<PhotoWord> pw = null;
//		if(record == null||record==""){
//			return "";
//		} else {
//			pw = photoWordService.getPhotoWordByRecord(Long.valueOf(record));
//			String jpgUrl = photorecordService.photoRecord(Long.valueOf(record)).getRecordUrl();
//			String xmlUrl = jpgUrl.substring(0, jpgUrl.length()-4) + ".xml";
//			//System.out.println(xmlUrl);
//			try {
//				JSONObject json = XmlToJson.xml2jsonString("E:/FTZ/"+xmlUrl)) ;
//			} catch (JSONException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
//		return "personalPhoto/recDetail";
//	}

	@RequestMapping("/recognizeDetail2")
	public String show(HttpServletRequest request) throws JSONException, IOException{
		String photoSrc = request.getParameter("photoSrc");
		//System.out.println(photoSrc);
		String xmlUrl = url.dire+"//" + photoSrc.substring(photoSrc.indexOf("FTZ")).split("\\.")[0] + ".xml";
		//System.out.println(xmlUrl);
		String dataJson;
		dataJson = XmlToJson.xml2jsonString(xmlUrl).getJSONObject("wordandpoints").getJSONArray("point").toString();
		request.setAttribute("photoSrc", photoSrc);
		request.setAttribute("dataJson", dataJson);
		return "personalPhoto/recognizeDetail2";
	}
	//通过url查询是否识别
	@RequestMapping("/selectRecognized")
	@ResponseBody
	public int selectRecognized(HttpServletRequest request){
		String photoSrc = request.getParameter("photoSrc");
		String recordUrl = photoSrc.substring(photoSrc.indexOf("FTZ")+4);
		Integer recognized = photorecordService.selectRecognizedByUrl(recordUrl);
		//之前的脏数据recognized字段为null
		return recognized==null?0:recognized;
	}
	@RequestMapping("/personreply")
	public String personreply(HttpSession session,HttpServletRequest request,int page,int size){
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		System.out.println("userId:"+userId);
		List<Reply> list = rservice.getReplys(userId,page,size);
		PageInfo pageInfo = new PageInfo(list);
		request.setAttribute("pageInfo", pageInfo);
		return "person/topersonReply";
	}
	@RequestMapping("replydelete")
	public void replydelete(HttpSession session,HttpServletRequest request,HttpServletResponse response,Long replyId) throws Exception{
		rservice.deleteReply(replyId);
		request.getRequestDispatcher("/personreply?page=1&size=10").forward(request, response);
		return;
	}

	@RequestMapping("/personfeedback")
	public String personfeedback(HttpSession session,HttpServletRequest request,int page,int size){
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		System.out.println("userId:"+userId);
		List<Reply> list = rservice.getFeedbacks(userId,page,size);
		PageInfo pageInfo = new PageInfo(list);
		request.setAttribute("pageInfo", pageInfo);
		return "person/tofeedback";
	}

	@RequestMapping("feedbackdelete")
	public void feedbackdelete(HttpSession session,HttpServletRequest request,HttpServletResponse response,Long replyId) throws Exception{
		rservice.deleteFeedback(replyId);
		request.getRequestDispatcher("/personfeedback?page=1&size=10").forward(request, response);
		return;
	}

	@RequestMapping("/addfeedback")
	public String addfeedback() {
		return "person/feedback";
	}

	@RequestMapping("/addfeedback2")
	public void addfeedback2(HttpServletRequest request,HttpServletResponse response,HttpSession session,String phonenumber,Long resourceId,String replyContent) throws Exception{
		Users u = userService.getUserID(phonenumber);
		Long userId = u.getUserId();
		replyContent = new String(replyContent.getBytes("ISO-8859-1"), "UTF-8");
		Reply reply = new Reply();
		reply.setUserId(userId);
		reply.setResourceId(resourceId);
		reply.setReplyContent(replyContent);
		rservice.addReply(reply);
		request.getRequestDispatcher("/personfeedback?page=1&size=10").forward(request, response);
		return;
	}

	//从书籍查找文字来源,跳转到searchCharFormPdf.jsp页面
	@RequestMapping("/searchCharFromPdf")
	public String searchCharFromPdf(HttpSession session,HttpServletRequest request){
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		request.setAttribute("userId", userId);
		return "personalPdf/searchCharFromPdf";
	}
	//从书籍查找文字来源，返回json数据
	@RequestMapping(value = "/searchByUserIdAndWordFromPdf")
	@ResponseBody
	public String searchByUserIdAndWordFromPdf(@Param("userId") String userId,@Param("word") String word){
		List<WordSourceInfo> wsi = new ArrayList ();;
		int wordId;
		Map<Object, Object> map = new HashMap ();
		if(word == null||word==""||userId==null||userId==""){

		} else {
			try {
				wordId = wordService.getWord(new String(word.getBytes("ISO-8859-1"), "UTF-8")).getWordId();
				wsi = bookService.searchWordSource(Long.valueOf(userId), wordId);
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
	//用户个人书籍列表
	@RequestMapping(value = "/personalPdfList")
	public String personalPdfList(HttpSession session,HttpServletRequest request){
		Long userId ;
		//判断请求来源
		if(request.getParameter("userId")==null){//请求来源为用户图片管理，userId从session获得
			Users user = (Users) session.getAttribute("user");
			Users u = userService.getUserID(user.getPhonenumber());
			userId = u.getUserId();
		} else {//请求来源为管理员查看用户图片详情，userId从request获得
			userId = Long.parseLong(request.getParameter("userId"));
		}
		List<book> books = bookService.select(userId);
		Iterator<book> iter = books.iterator();
		@SuppressWarnings("rawtypes")
		List<Map> mapList = new ArrayList ();
		while(iter.hasNext()){
			book tempBook = iter.next();
			Map<String,Object> bookInfoMap = new HashMap ();
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
		request.setAttribute("userId", userId);
		request.setAttribute("bookInfoJson", JSONObject.toJSONString(mapList));
		return "personalPdf/personalPdfList";
	}
	//用户个人书籍详情：书籍图片列表
	@RequestMapping(value = "/pdfDetail")
	public String pdfDetail(HttpSession session,HttpServletRequest request){
//			Users user = (Users) session.getAttribute("user");
//			Users u = userService.getUserID(user.getPhonenumber());
//			Long userId = u.getUserId();
		Long bookId = Long.parseLong(request.getParameter("bookId"));
		book bk = bookService.selectById(bookId);
		String bookName = bk.getBookname();
		Integer bookPage = bk.getBookpage();
		String bookUrl = bk.getBookurl();
		@SuppressWarnings("rawtypes")
		List<Map> infoList = new ArrayList ();
		for(int i = 1; i <= bookPage ; i++){
			String tempUrl = "" + bookUrl + "/" + bookName + "_" + i + ".jpg";
			Integer tempRecFlag = bookRecordService.searchRecognizedBybookIdAndRecPage(bookId,i);
			Map<String, Object> infoMap = new HashMap ();
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

		return "personalPdf/pdfPhotoList";
	}
	@RequestMapping(value = "/TaskManageList")
	public String TaskManageList(HttpSession session,HttpServletRequest request){
		Long userId ;
		//判断请求来源

		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		userId = u.getUserId();
		List<book> books=null;
		if(request.getParameter("flag").equals("0"))
		{
			books = bookService.selectByBookBelonging((long)1);
		}
		else
		{
			books = bookService.selectByBookBelonging(userId);
		}
		////看看都查到的是什么内容
//	      for(int i=0;i<books.size();i++)
//	      {
//	    	  System.out.println(books.get(i));
//	      }
		Iterator<book> iter = books.iterator();
		@SuppressWarnings("rawtypes")
		List<Map> mapList = new ArrayList ();
		while(iter.hasNext()){
			book tempBook = iter.next();
			Map<String,Object> bookInfoMap = new HashMap ();
			bookInfoMap.put("bookId", tempBook.getBookid());
			bookInfoMap.put("userId", tempBook.getUserID());
			bookInfoMap.put("bookName", tempBook.getBookname());
			bookInfoMap.put("bookPage", tempBook.getBookpage());
			bookInfoMap.put("bookUrl", tempBook.getBookurl());
			bookInfoMap.put("flag", tempBook.getFlag());
			bookInfoMap.put("dateTime", tempBook.getBookdatetime());
			bookInfoMap.put("bookMoney", tempBook.getBookmoney());
//	        int recognizedWordsNum = bookService.getRecognizedWordsNum(tempBook.getBookid());
//	        bookInfoMap.put("recognizedWordsNum", recognizedWordsNum);
			mapList.add(bookInfoMap);
		}
		session.setAttribute("manageFlag",request.getParameter("flag"));
		request.setAttribute("userId", userId);
		request.setAttribute("bookInfoJson", JSONObject.toJSONString(mapList));
		return "person/taskManageList";
	}
	//用户个人任务领取书籍详情：书籍图片列表
	@RequestMapping(value = "/TaskDetail")
	public String TaskDetail(HttpSession session,HttpServletRequest request){

		Long bookId = Long.parseLong(request.getParameter("bookId"));
		book bk = bookService.selectById(bookId);
		String bookName = bk.getBookname();
		Integer bookPage = bk.getBookpage();
		String bookUrl = bk.getBookurl();
		@SuppressWarnings("rawtypes")
		List<Map> infoList = new ArrayList ();
		for(int i = 1; i <= bookPage ; i++){
			String tempUrl = "" + bookUrl + "/" + bookName + "_" + i + ".png";
			Integer tempRecFlag = bookRecordService.searchRecognizedBybookIdAndRecPage(bookId,i);
			Map<String, Object> infoMap = new HashMap ();
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

		return "person/TaskPhotoList";
	}
	/// /taskGet
	//用户领取书籍与放弃书籍。
	@RequestMapping(value = "/taskGet")
	public String taskGet(HttpSession session,HttpServletRequest request){
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();

		Long bookId = Long.parseLong(request.getParameter("bookId"));
//	      System.out.println(bookId);
		book bk = bookService.selectById(bookId);
		List<book> books=null;
		if(session.getAttribute("manageFlag").equals("0"))
		{
			bk.setBookbelonging(userId);
			bk.setMoneyflag(0);

			bookService.UpdataBook(bk);
			books = bookService.selectByBookBelonging((long)1);
		}
		else
		{
			bk.setBookbelonging((long)1);
			bk.setMoneyflag(2);
			if("1".equals(request.getParameter("flag")))
			{
				request.setAttribute("msg", "已经识别不能放弃任务");
			}
			else
				bookService.UpdataBook(bk);
			books = bookService.selectByBookBelonging(userId);
		}




		Iterator<book> iter = books.iterator();
		@SuppressWarnings("rawtypes")
		List<Map> mapList = new ArrayList ();
		while(iter.hasNext()){
			book tempBook = iter.next();
			Map<String,Object> bookInfoMap = new HashMap ();
			bookInfoMap.put("bookId", tempBook.getBookid());
			bookInfoMap.put("userId", tempBook.getUserID());
			bookInfoMap.put("bookName", tempBook.getBookname());
			bookInfoMap.put("bookPage", tempBook.getBookpage());
			bookInfoMap.put("bookUrl", tempBook.getBookurl());
			bookInfoMap.put("flag", tempBook.getFlag());
			bookInfoMap.put("dateTime", tempBook.getBookdatetime());
			bookInfoMap.put("bookMoney", tempBook.getBookmoney());
//	      int recognizedWordsNum = bookService.getRecognizedWordsNum(tempBook.getBookid());
//	      bookInfoMap.put("recognizedWordsNum", recognizedWordsNum);
			mapList.add(bookInfoMap);
		}
		request.setAttribute("userId", userId);
		request.setAttribute("bookInfoJson", JSONObject.toJSONString(mapList));
		return "person/taskManageList";
	}

}
