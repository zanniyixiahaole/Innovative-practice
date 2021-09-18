package com.web.service;

import java.util.List;

import com.web.entity.WordSourceInfo;
import com.web.entity.book;

public interface bookService {
	 List<book> select(Long UserID);
	 //根据用户ID查询识别书的信息--存在多条
	 book selectById(Long BookId);
	 //根据书籍ID查询识别书的信息--单条  
	 List<book> selectByUserIDAndbookname(Long UserID,String bookname);
	//根据用户ID和书名查询识别书的信息
	 boolean UpdataBook(book book);
	  //更新book信息
	 boolean saveBook(book book) ;
	  //保存书籍信息
	//通过url查询book   -刘俊
	 book selectByurl(String url);
	 
	 
	//根据userId和wordId查找文字来源——刘帅威
	 List<WordSourceInfo> searchWordSource(Long userId,int wordId);
	 
	 //根据bookID查询书籍中已识别的文字个数——刘帅威
	 Integer getRecognizedWordsNum(Long bookId);
	 //查询所有book信息——刘帅威
	 List<book> selectAll();
	 //管理员查找文字来源--刘帅威
	 List<WordSourceInfo> searchWordSourceAdmin(int wordId);

	List<book> selectByBookBelonging(Long bookbelonging);

	List<book> selectByBookBelongingNotIn();///查询已经分配给用户的函数
	List<book> selectBymoneyflag(Integer moneyflag);///根据书是否在等待到钱的标志，查
}
