package com.web.dao;

import java.util.List;

import com.web.entity.count;

public interface countDao {
	List<count> selectTotalOfWord();
}