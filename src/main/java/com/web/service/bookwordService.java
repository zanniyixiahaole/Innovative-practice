package com.web.service;

import java.util.List;

import com.web.entity.bookword;

public interface bookwordService {
	boolean savebookword(bookword bookword) ;
	
	//根据bookRecord的Id查询所有的bookWord --刘帅威
	List<bookword> getByBookRecord(Long record);
}
