package com.web.web;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.util.UUID;

import cn.dsna.util.images.ValidateCode;
import com.fasterxml.jackson.databind.DatabindContext;
import com.web.tool.StringFix;
import javax.imageio.ImageIO;
import com.lowagie.text.pdf.codec.Base64.InputStream;
import com.lowagie.text.pdf.codec.Base64.OutputStream;
import com.web.tool.StringFix;
import com.web.tool.url;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.xml.sax.SAXException;
import com.web.entity.PhotoRecord;
import com.web.entity.PhotoWord;
import com.web.entity.Users;
import com.web.entity.book;
import com.web.entity.bookRecord;
import com.web.entity.bookword;
import com.web.entity.word;
import com.web.interceptor.Filemove;
import com.web.interceptor.SAXWrite;
import com.web.service.UserService;
import com.web.service.photorecordService;
import com.web.service.bookService;
import com.web.service.bookRecordService;
import com.web.service.bookwordService;
import com.web.service.photowordService;
import com.web.service.wordService;
import com.web.util.CutBigImage;
import com.web.util.ImageSplit;
import com.web.util.ScreenShot;
import com.web.util.posepoint;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import sun.misc.BASE64Decoder;
import org.apache.commons.codec.binary.Base64;
import com.web.tool.base64ToImg;;

@Controller
public class mainController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private photorecordService photorecordService;
	@Autowired
	private bookService bookService;
	@Autowired
	private bookRecordService bookRecordService;
	@Autowired
	private bookwordService bookwordService;
	@Autowired
	private photowordService photowordService;
	@Autowired
	private wordService wordService;
	private Object HttpSession;

	@RequestMapping("/shibeipingtai")
	public String shibeipingtai() {
		return "shibeipingtai";
	}

	@RequestMapping("/Index")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/notice")
	public String notice() {
		return "notice";
	}
	
	@RequestMapping("/first")
	public String first() {
		return "firstpage";
	}
	@RequestMapping("/aboutus")
	public String about() {
		return "aboutus";
	}
    //????????????
	@RequestMapping("/recognize2")
	@ResponseBody
	public JSONArray testJson(HttpServletRequest request, Model model) {
		System.out.println("before.............") ;
        System.gc();
		String ds = request.getParameter("ds");
		JSONArray json = JSONArray.fromObject(ds);
		
		System.out.println(json.toString());
		
		ImageSplit sp = new ImageSplit();
		ArrayList<posepoint> dirlist = null;
		try {
			dirlist = sp.splitImage2(json);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(dirlist);
//		System.gc();
		dirlist = userService.recongnize(dirlist);

		System.out.println("middle.............") ;

		JSONArray jsonArray = JSONArray.fromObject(dirlist);
//		System.out.println(jsonArray.toString());
		System.out.println("after.............") ;

//		dirlist.clear();
        System.gc();
		return jsonArray;
	}
	
	//???????????????????????????
	@RequestMapping("/screenShot")
	@ResponseBody
	public void screenShot(HttpServletRequest request){
		String photoName = request.getParameter("photoName");
		String prefixName = photoName.substring(photoName.indexOf("FTZ"),photoName.indexOf(".")).replaceAll("//", "/");
		ScreenShot.run(prefixName);
	}
	
	//??????????????????
	@RequestMapping("/recognize")
	public String recognize() {
		return "torecognize";
	}
	//??????????????????
	@RequestMapping("/fileupload")
	public String upload(HttpSession session,MultipartFile file, HttpServletRequest request, Model model) throws IOException {
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		Date d1 = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
		String res = sdf.format(new Date());
		// uploads???????????????
		String rootPath = url.dir;
		// ????????????
		String originalFileName = file.getOriginalFilename();
		// ????????????
		String newFileName = "sliver" + res + originalFileName.substring(originalFileName.lastIndexOf("."));
		// ?????????????????????
		Calendar date = Calendar.getInstance();
		File dateDirs = new File(userId.toString());

		// ?????????
		File newFile = new File(rootPath + File.separator + dateDirs + File.separator+"jpg" +File.separator+ newFileName);
		// ??????????????????????????????????????????
		if (!newFile.getParentFile().exists()) {
			// ???????????????????????????????????????????????????????????????
			newFile.getParentFile().mkdirs();
		}
		System.out.println(newFile);
		// ?????????????????????????????????
		file.transferTo(newFile);
		// ?????????url
		String fileUrl = url.dir +"/"+ userId.toString() + "/" +"jpg"+"/"
				+ newFileName;
		ArrayList<Object> listpoint = CutBigImage.cutBigImage(fileUrl);
		model.addAttribute("arrayList", listpoint);
		model.addAttribute("filename",
				userId.toString() + "/" +"jpg"+"/"+ newFileName);
		PhotoRecord PhotoRecord=new PhotoRecord();
		PhotoRecord.setUserId(userId);
		PhotoRecord.setDateTime(d1);
		PhotoRecord.setRecordUrl(userId.toString() + "/" +"jpg"+"/"+ newFileName);

		PhotoRecord.setRecognized(0);
		photorecordService.savePhotoRecord(PhotoRecord);
		model.addAttribute("flag",0);

//		newFile.delete();
		return "recognize1";
	}
	//????????????????????????????????????????????????
	@RequestMapping("/afterwardRecognized")
	public String afterwardRecognized(HttpServletRequest request, Model model,HttpSession session) throws IOException {
		String photoSrc = request.getParameter("photoSrc");
		int indexValue = Integer.valueOf(request.getParameter("indexValue"));
		//fromList=true?????????????????????????????????
		String fromList = request.getParameter("fromList");
		String fileUrl = photoSrc.substring(photoSrc.indexOf("FTZ")+4);
		System.out.println(fileUrl);
		
		ArrayList<Object> listpoint = CutBigImage.cutBigImage(url.dir+"/"+fileUrl);
		model.addAttribute("arrayList", listpoint);
		model.addAttribute("filename",fileUrl);
		model.addAttribute("indexValue",indexValue);
		model.addAttribute("fromList",fromList);
		if("photoList".equals(fromList)){//????????????photoList,???flag???0
			model.addAttribute("flag",0);
			//session.setAttribute("fromPDF", "0");////////////
		} else if("pdfPhotoList".equals(fromList)){
			model.addAttribute("flag",1);//????????????pdfPhotoList,???flag???1,??????bookId??????
		///	session.setAttribute("fromPDF", "1");///////////////////////////
			model.addAttribute("bookId",request.getParameter("bookId"));
		}
		
		return "recognize1";
	}
    //????????????
	@RequestMapping("/login")
	public String login() {
		return "tologin";
	}
	//????????????
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	private String tologin(@Param("phonenumber") String phonenumber, @Param("password") String password,
						   @Param("verifyCode") String verifyCode, Map<String, Object> map,
			HttpServletRequest request, HttpServletResponse response) {

		String codeValue = (String) request.getSession().getAttribute("verifyCodeValue");
		if(verifyCode.equalsIgnoreCase(verifyCode)){
			Users user = userService.getByPhonenumberAndPassword(phonenumber,password);
			HttpSession session = request.getSession();
			//	System.out.println("?????????sessionId???:"+session.getId());
		if (user != null) {
			// ==========??????
						// ??????????????????
						Date loginTime = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String ltime = sdf.format(loginTime);
						int num = user.getLoginNum().intValue() + 1;
//									System.out.println("??????????????????" + ltime);
//									System.out.println("??????????????????" + num);
						// ???????????????????????????????????????????????????????????????
						boolean flag = userService.UpdataTimeAndNum(ltime, num, user.getUserId());
//									if (flag == true)
//										System.out.println("??????????????????????????????");
						File file = new File(url.dir + "/temp.txt");
						if (!file.exists()) {
							try {
								file.createNewFile();
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
						FileWriter writer;
						try {
							writer = new FileWriter(file,true);//true?????????????????????
							System.out.println(ltime);
							writer.write(user.getPhonenumber()+"---"+ltime+", "+num);
							writer.write("\r\n");
							writer.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
						//???????????????
						List<Users> rank = userService.getRank();
						for(int i=0;i<rank.size();i++) {
							if(rank.get(i).getUserId().intValue()==user.getUserId().intValue()) {
								session.setAttribute("rank", i+1);//???????????????session???
							}
							System.out.println(i);
						}
						// ??????========
			session.setAttribute("user", user);// ??????session????????????????????????????????????????????????????????????
			System.out.println("???????????????");
			if((String) session.getAttribute("preurl")==null){
				return "index";
			}else{
				return (String) session.getAttribute("preurl");
			}
		} else {
			request.setAttribute("msg", "??????????????????????????????????????????");
			System.out.println("???????????????");
			return "tologin";
		}
		}
		else {
			request.setAttribute("msg","????????????????????????????????????");
			System.out.println("???????????????");
			return "tologin";
			}
	}
		/**
		 * ???????????????
		 */

	@RequestMapping("/verifyCode")
	public void verifyCode(HttpServletResponse response, HttpSession session)throws IOException{
			//??????????????????
		response.setContentType("img/jpeg");
			//??????????????????
			response.setHeader("Pragma","no-cache");
			response.setHeader("Cache-Control","no-cache");
			response.setHeader("Expires", String.valueOf(0));
			//??????????????????????????????
			ValidateCode verifyCode = new ValidateCode(180,40,5,50);
			verifyCode.write(response.getOutputStream());

			System.out.println("???????????????"+verifyCode.getCode());
			//?????????????????????session???
		session.setAttribute("verifyCodeValue", verifyCode.getCode());
		}
	// ??????
	// ??????????????????
	@RequestMapping("/regist")
	public String regist() {
		return "toregist";
	}
   //?????????????????????
	@RequestMapping(value = "/registCheck")
	public String toregist(Users user,@Param("phonenumber") String phonenumber, @Param("password") String password) {
		Date d=new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String regDate = sdf.format(d);
        user.setPhonenumber(phonenumber);//????????????
        user.setPassword(password);//????????????
		user.setRegDate(regDate);//??????????????????
		user.setIsVIP(0);//????????????VIP??????
		user.setMoneyWait(0.0);
		user.setBook(0);
		user.setPhoto(0);
		user.setMoney(0.0);
		user.setAdminFlag(0);
		user.setAge(0);
		user.setName("0");
		user.setOccupation("0");
		user.setSex(3);
		user.setLastLoginTime(regDate);// ??????????????????????????????????????????
		user.setLoginNum(0);// ?????????????????????0
		boolean flag = userService.saveUser(user);
		if (flag) {
			String filepath1=url.dir+"/"+user.getUserId();
            File file2=new File(filepath1);		
            if(!file2.exists()){//????????????????????????		
            	file2.mkdir();//???????????????	
            	}
			return "tologin";// ?????????????????????????????????
		} else {
			return "toregist";// ???????????????????????????
		}
	}
	//????????????
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
	//	System.out.println("?????????sessionId???:"+session.getId());
		session.invalidate();

	    return "redirect:/Index";

	}
	@RequestMapping("/download")
	@ResponseBody
	public String download(HttpServletRequest request, Model model,HttpSession session) throws Exception {
		Users user = (Users) session.getAttribute("user");
		Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		String ds = request.getParameter("dat");

		ds= StringFix.StringFix(ds);
		String flagpdf = request.getParameter("flagpdf");
		String dir = request.getParameter("dir");
		JSONArray json = JSONArray.fromObject(ds);
		dir = dir.replaceAll("//", "/");
		SAXWrite.savexml(json,dir);
		System.out.println("///////////////");
		System.out.println(dir);
		if ("1".equals(flagpdf))
		{	
			//System.out.println(dir);
			//???????????????123472//PDF//gushi20200421153307940//gushi_1.png?????????????????????????????????
			//???????????????123472//PDF//gushi20200421153307940/gushi_1.png???????????????????????????????????????
			//???????????????????????????????????????

			dir = dir.replaceAll("//", "/");

			char page = dir.charAt(dir.lastIndexOf(".")-1);
			String bookdir = dir.substring(0,dir.lastIndexOf("/"));
			bookdir = bookdir.replaceAll("/", "//");
			//char page=dir.split("\\.")[0].charAt(dir.split("\\.")[0].length()-1);
			//String bookdir=new String(dir.split("//")[0]+"//"+dir.split("//")[1]+"//"+dir.split("//")[2]);
			
			book book=bookService.selectByurl(bookdir);
			
            bookRecord bookrecord=bookRecordService.bookRecordbyidandpage(book.getBookid(),Integer.valueOf(String.valueOf(page)));
            Date d=new Date();
            bookrecord.setRecbookdatetime(d);
            bookrecord.setRecflag(1);
            bookRecordService.UpdataBookRecord(bookrecord);
            
          //??????????????????????????????
            book b=bookService.selectByurl(bookdir);
            if(b.getMoneyflag()==2&&b.getFlag()==1)
			{
				b.setMoneyflag(0);
				Users user2 =userService.getUserInfo(b.getBookbelonging());
				user2.setMoneyWait(user2.getMoneyWait()+b.getBookmoney());
				userService.UpdatePassword(user2);
				bookService.UpdataBook(b);
			}
            
            JSONObject jsonOne;
   		 for(int i=0;i<json.size()-1;i++){
   			 jsonOne = json.getJSONObject(i);
   			 word selectword_id= wordService.selectword_id(String.valueOf(jsonOne.get("word")));
//   			 if(wordService.selectword_id(String.valueOf(jsonOne.get("word")))==null) {
//   				selectword_id = wordService.selectword_id("???");
//   			 }
//   			 else {
//   				 selectword_id = wordService.selectword_id(String.valueOf(jsonOne.get("word")));
//   			 }
//   			 if (selectword_id==null){
//   				selectword_id =wordService.selectword_id("???");
//   			 }
   			 bookword bookword=new bookword();
   			 bookword.setWordid(selectword_id.getWordId());
   			 bookword.setRecord(bookrecord.getBookrecord());
   			 String wordUrl=new Filemove().filesave((String.valueOf(jsonOne.get("dir"))), String.valueOf(jsonOne.get("word")),userId);
   			 bookword.setWordurl(wordUrl);
   			 bookwordService.savebookword(bookword);
   		 }
		}
		else{
			PhotoRecord photorecord=photorecordService.getPhotoRecordID(dir);
			//?????????????????????1
			photorecord.setRecognized(1);
			photorecordService.updateRecognized(photorecord);
			//?????????????????????1
			 System.out.println(json);
			JSONObject jsonOne;
			 for(int i=0;i<json.size()-1;i++){
				
				 jsonOne = json.getJSONObject(i); 
				 System.out.println(jsonOne);
				 System.out.println(String.valueOf(jsonOne.get("word")));
				 word selectword_id = wordService.selectword_id(String.valueOf(jsonOne.get("word")));
				 System.out.println(selectword_id);
				 PhotoWord PhotoWord=new PhotoWord();
				 PhotoWord.setWordId(selectword_id.getWordId());
				 PhotoWord.setPhotoRecord(photorecord.getRecord());
				 String wordUrl=new Filemove().filesave((String.valueOf(jsonOne.get("dir"))), String.valueOf(jsonOne.get("word")),userId);
				 PhotoWord.setWordUrl(wordUrl);
				 photowordService.savePhotoWord(PhotoWord);
			 }
		}
		return "sucess";
	}
	
	@RequestMapping("/uploadImg")//??????????????????????????????????????????????????????????????????
	public String uploadImg(HttpSession session, HttpServletRequest request, Model model) throws IOException {
    
    	String recordurl = new String(request.getParameter("recordurl").getBytes("iso-8859-1"), "utf-8");
		// uploads???????????????
		String rootPath = url.dir+"/"+recordurl;


		// ?????????
		File newFile = new File(rootPath);
		// ??????????????????????????????????????????
		if (!newFile.getParentFile().exists()) {
			// ???????????????????????????????????????????????????????????????
			newFile.getParentFile().mkdirs(); 
		}
		System.out.println(newFile);

		ArrayList<Object> listpoint = CutBigImage.cutBigImage(rootPath);
		model.addAttribute("arrayList", listpoint);
		model.addAttribute("filename",
				recordurl);
		model.addAttribute("flag",0);
		return "recognize1";
	}

	/////??????????????????????????????

	@RequestMapping(value = { "saveSBphoto" }, method = { RequestMethod.POST })  
    @ResponseBody  
    public String petUpgradeTarget(HttpServletRequest request, String data) { 
		String imgStr=request.getParameter("myImage"); 
		String url=request.getParameter("URL");
//		System.out.println(url);
//		System.out.println(url.split("\\.")[0]);
//		System.out.println(url.split("\\.")[1]);
//		System.out.println(url.split("\\.")[1]);
//		System.out.println("/FTZ/"+url.split("\\.")[0]+"_rec."+url.split("\\.")[1]);

	
		boolean a=base64ToImg.base64ToImg(imgStr.split(",")[1],"/FTZ/"+url.split("/.")[0]+"_rec."+url.split("/.")[1]);
		if(a) {
			return "suceess";
		} else {
			return "fail";
		}

    }  
	
}

