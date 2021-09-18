package com.web.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import com.web.entity.book;
import com.web.service.bookService;
@Controller
public class bookController {
	@Autowired
	bookService bookservice;
//	public book a;
	@RequestMapping("/bookselect")
	public String bookselect() {
		
		book a = new book();
		a.setBookid(3);
		a.setBookname("test2");
		a.setBookpage(6);
		a.setBookurl("testurl");
		a.setFlag(1);
		a.setUserID((long)123456);
//		System.out.print(bookservice.saveBook(a));
		bookservice.UpdataBook(a);
		List<book> b=bookservice.select((long) 123456);
		for(int i = 0 ; i < b.size() ; i++) {System.out.print(b.get(i).getBookname());}
//		System.out.print(bookservice.select((long) 123456));
		
		
		return "";
	}
}
