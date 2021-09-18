package com.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.web.entity.bookRecord;
import com.web.service.bookRecordService;

import com.web.dao.bookrecordDao;
@Service
public class bookRecordServiceImpl implements bookRecordService{
	@Autowired
	private bookrecordDao bookrecordDao;
	@Override
	public List<bookRecord>  bookRecordSelect(Long bookid) {
		// TODO Auto-generated method stub
		return bookrecordDao.bookRecordSelect(bookid);
	}
	@Override
	public boolean UpdataBookRecord(bookRecord bookrecord)
	{
		return bookrecordDao.UpdataBookRecord(bookrecord);
	}
	@Override
	  //更新book信息
	public    boolean saveBookRecord(bookRecord bookrecord) 
	{
		return bookrecordDao.saveBookRecord(bookrecord);
	}
	@Override
	public bookRecord bookRecordbyidandpage(Long bookid, int recflage) {
		// TODO Auto-generated method stub
		return bookrecordDao.bookRecordbyidandpage(bookid, recflage);
	}
	
	//根据bookId(书籍Id)和rec_page(页码数)查询是否已经被识别 --刘帅威
	@Override
	public Integer searchRecognizedBybookIdAndRecPage(Long bookId, Integer recPage) {
		// TODO Auto-generated method stub
		return bookrecordDao.searchRecognizedBybookIdAndRecPage(bookId,recPage);
	}
	//根据bookId查询已识别的页码数量
	@Override
	public Integer getRecognizedPageNumByBookId(Long bookId) {
		// TODO Auto-generated method stub
		return bookrecordDao.getRecognizedPageNumByBookId(bookId);
	}
}
