package com.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.dao.countDao;
import com.web.entity.count;
import com.web.service.countService;

@Service
public class countServiceImpl implements countService {

	@Autowired
	private countDao countDao;
	@Override
	public List<count> selectTotalOfWord() {
		return countDao.selectTotalOfWord();
	}

}