package com.web.service;

import java.util.List;


import com.web.entity.bookRecord;

public interface bookRecordService {
	 List<bookRecord> bookRecordSelect(Long bookid);
	    //根据bookid查询bookRecord的信息---即一本书所有的图片记录
	 boolean UpdataBookRecord(bookRecord bookrecord);
	  //更新书籍中单个图片bookRecord信息
	 boolean saveBookRecord(bookRecord bookrecord) ;
	    //保存书籍中单个图片bookRecord信息
	 bookRecord bookRecordbyidandpage(Long bookid,int recflage);
	    //通过id和当前页数查询bookrecord--刘俊
	  
	 Integer searchRecognizedBybookIdAndRecPage(Long bookId,Integer recPage);
	 //根据bookId(书籍Id)和rec_page(页码数)查询是否已经被识别   --刘帅威
	 
	 Integer getRecognizedPageNumByBookId(Long bookId);
	//根据bookId查询已识别的页码数量
}
