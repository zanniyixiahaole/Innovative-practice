package com.web.web;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.web.entity.PhotoRecord;
import com.web.entity.Users;
import com.web.entity.book;
import com.web.entity.bookRecord;
import com.web.service.UserService;
import com.web.service.bookService;
import com.web.service.bookRecordService;
//import com.web.tool.ChangePdfToImg;
import com.web.tool.PDF2IMAGE;
import com.web.util.CutBigImage;
import com.web.util.posepoint;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONException;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import com.web.tool.url;
@Controller
public class pdfController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private bookService bookservice;
	@Autowired
	private bookRecordService bookRecordService;
	//转到上传新的pdf页面
    @RequestMapping("/pdfIndex1")
	public String pdfupload1() {
			return "uploadpdf";
		}
  
    //转到我已上传的pdf页面
	@RequestMapping("/pdfIndex2")
	public String pdfupload2() {
			return "toUploadPDF";
		}
	//转到我的书籍识别任务的pdf页面
	@RequestMapping("/pdfIndex3")
	public String pdfupload3() {
			return "pdf/pdfTask";
		}
	//保存pdf
    @RequestMapping("/SavePDF")
    @ResponseBody
    public String uploaderResumes(@RequestParam("file") MultipartFile file, HttpServletRequest request,HttpSession session,Model model) {  
        // 判断文件是否为空  
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
        		String filepath1=url.dir+"/"+ userId.toString()+"/PDF";
                File file2=new File(filepath1);		
                if(!file2.exists()){//如果文件夹不存在		
                	file2.mkdir();//创建文件夹	
                	}
                String filePath = url.dir+"/"+ userId.toString()+"/PDF"
                        + System.getProperty("file.separator") 
                       +file.getOriginalFilename().split("\\.")[0]+res+"."+file.getOriginalFilename().split("\\.")[1];
                // 转存文件  
                file.transferTo(new File(filePath)); 
                String name=file.getOriginalFilename().split("\\.")[0];///获取书的名字（不带扩展名）
                int page=PDF2IMAGE.pdf2Image(filePath,filepath1,res, 100,name);///扔进pdf转照片的方法中
                book savebook=new book();
                
				savebook.setBookname(name);
				savebook.setBookpage(page);  
				savebook.setBookurl( userId.toString()+"/PDF/"+name+res);
				savebook.setFlag(0);  
				savebook.setUserID(userId);
				savebook.setBookdatetime(d1);
				savebook.setBookmoney(0);
				savebook.setBookbelonging(0);
				savebook.setMoneyflag(-1);///用户自己上传的书是-1
				bookservice.saveBook(savebook);//////往book表写入数据	
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
   
    ///上传pdf--保存pdf后发送前台该pdf的图片信息
    @RequestMapping("/sendjsonImgFromPDF")
    @ResponseBody
	public JSONArray jsonTranslation(HttpServletRequest request,HttpSession session) {
    	String bookid = request.getParameter("dat");
    	JSONArray array = new JSONArray();
		List<bookRecord> thisBookRecord=bookRecordService.bookRecordSelect(Long.valueOf(bookid));
		book bb=bookservice.selectById(Long.valueOf(bookid));
		for(int i = 0 ; i < thisBookRecord.size() ; i++) {
			JSONObject ob=new JSONObject();
	    	ob.put("bookname", bb.getBookname());
	    	ob.put("recpage", thisBookRecord.get(i).getRecpage());
	    	ob.put("bookurl", bb.getBookurl());
	    	ob.put("recflag", thisBookRecord.get(i).getRecflag());
	    	array.add(ob);
		}
		return array;
	}
    //根据taskFlag返回我已上传pdf信息或者我的任务。
    @RequestMapping("/sendjsonPDF")
    @ResponseBody
	public JSONArray jsonPdfTranslation(HttpServletRequest request,HttpSession session) {
    	JSONArray array1 = new JSONArray();
    	Users user = (Users) session.getAttribute("user");
        Users u = userService.getUserID(user.getPhonenumber());
		Long userId = u.getUserId();
		List<book> b=null;
		System.out.println(request.getParameter("taskFlag"));

		String flagPage=request.getParameter("flag");////标记从哪里来的，这是管理中心的任务分配与任务重新分配

		if("1".equals(request.getParameter("taskFlag")))
		{
			b=bookservice.selectByBookBelonging(userId);
		}else
		{
			if("1".equals(flagPage))
	    	{
				 b=bookservice.selectByBookBelonging((long)1);
	    	}
	    	else if("2".equals(flagPage))
	    	{
	    		b=bookservice.selectByBookBelongingNotIn();
	    		for(int i = 0 ; i < b.size() ; i++) {
	    			if(b.get(i).getFlag()==0)/////已经分配了并且已经被用户识别的，管理员不能够再分配。
	    			{
	    				JSONObject ob=new JSONObject();
		    	    	ob.put("bookname", b.get(i).getBookname());
		    	    	ob.put("bookid", b.get(i).getBookid());
		    	    	ob.put("bookurl", b.get(i).getBookurl());
		    	    	ob.put("bookflag", b.get(i).getFlag());
		    	    	array1.add(ob);
	    			}
	    		}
	    		//System.out.print(array1.toString());
	    		return array1;
	    	}
	    	else
	    	{
	    		 b=bookservice.select(userId);
	    	}

		}
		for(int i = 0 ; i < b.size() ; i++) {
			JSONObject ob=new JSONObject();
	    	ob.put("bookname", b.get(i).getBookname());
	    	ob.put("bookid", b.get(i).getBookid());
	    	ob.put("bookurl", b.get(i).getBookurl());
	    	ob.put("bookflag", b.get(i).getFlag());
	    	array1.add(ob);
		}
		return array1;
	}
    
    //处理选择下拉列表已上传的pdf的具体页面信息
    @RequestMapping("/LoadingImgFromOneOfPDF")
    @ResponseBody
	public JSONArray LoadingImg(HttpServletRequest request,HttpSession session, Model model) {
    	JSONArray array1 = new JSONArray();
    	Long id=Long.parseLong(request.getParameter("bookid"));
    	List<bookRecord> selectbookRecord=bookRecordService.bookRecordSelect(id);
		book b=bookservice.selectById(id);
		for(int i = 0 ; i < selectbookRecord.size() ; i++) {
			JSONObject ob=new JSONObject();
	    	ob.put("bookname", b.getBookname());
	    	ob.put("recpage", selectbookRecord.get(i).getRecpage());
	    	ob.put("bookurl", b.getBookurl());
	    	ob.put("recflag", selectbookRecord.get(i).getRecflag());
	    	System.out.println(b.getBookbelonging());
	    	if(!(b.getBookbelonging()==0||b.getBookbelonging()==1))
	    	{
	    		ob.put("phonenumber", userService.getUserInfo(b.getBookbelonging()).getPhonenumber());
	    	}
	    	array1.add(ob);
		}
		//request.setAttribute("phonenumber", userService.getUserInfo(b.getBookbelonging()).getPhonenumber());
		//System.out.println(userService.getUserInfo(b.getBookbelonging()).getPhonenumber());
		//model.addAttribute("phonenumber", userService.getUserInfo(b.getBookbelonging()).getPhonenumber());
		return array1;
	}
    //上传pdf中的某张图片去识别
    @RequestMapping("/uploadImgOfpdf")
	public String uploadImgOfPDF(HttpSession session, HttpServletRequest request, Model model) throws IOException {
    	String bookurl = new String(request.getParameter("bookurl").getBytes("iso-8859-1"), "utf-8");
    	String recpage=request.getParameter("recpage");
    	//String bookname=request.getParameter("bookname");
    	String bookname = new String(request.getParameter("bookname").getBytes("iso-8859-1"), "utf-8");
		Date d1 = new Date();
		String rootPath = url.dir+"/"+bookurl+"/"+bookname+"_"+recpage+".png";
		System.out.println(rootPath);
		ArrayList<Object> listpoint = CutBigImage.cutBigImage(rootPath);
		model.addAttribute("arrayList", listpoint);
		model.addAttribute("filename",bookurl+"/"+bookname+"_"+recpage+".png");
		model.addAttribute("flag",1);
		return "recognize1";
	}
    @RequestMapping("/toImagepdf")
   	public String toImagepdf(HttpSession session, HttpServletRequest request, Model model) throws IOException {
       	String bookid=request.getParameter("bookid");
       	model.addAttribute("bookid", bookid);
   		return "pdf/toImagepdf";
   	}
    
}
