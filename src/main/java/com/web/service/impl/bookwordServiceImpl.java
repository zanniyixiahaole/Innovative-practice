package com.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.dao.bookwordDao;
import com.web.entity.bookword;
import com.web.service.bookwordService;
@Service
public class bookwordServiceImpl implements bookwordService{
	@Autowired
	private bookwordDao bookwordDao;
	@Override
	public boolean savebookword(bookword bookword) {
		// TODO Auto-generated method stub
		return bookwordDao.savebookword(bookword);
	}
	
	//根据bookRecord查询bookWord --刘帅威
	@Override
	public List<bookword>  getByBookRecord(Long record) {
		// TODO Auto-generated method stub
		return bookwordDao.getByBookRecord(record);
	}
}
