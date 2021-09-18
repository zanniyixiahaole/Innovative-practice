package com.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.web.dao.replyDao;
import com.web.dao.resourceDao;
import com.web.entity.Reply;
import com.web.entity.Resource;
import com.web.service.resourceService;

@Service
public class resourceServiceImpl implements resourceService{
	@Autowired
	private resourceDao rdao;
	@Autowired
	private replyDao rpdao;
	@Override
	public List<Resource> getResources(int page, int limit) {
		// TODO Auto-generated method stub
		PageHelper.startPage(page, limit);
		List<Resource> list = rdao.getResources();
		return list;
	}

	@Override
	public Resource getResource(Long resourceId) {
		// TODO Auto-generated method stub
		return rdao.getResource(resourceId);
	}

	@Override
	public List<Reply> getReplys(Long resourceId, int page, int limit) {
		// TODO Auto-generated method stub
		PageHelper.startPage(page, limit);
		List<Reply> list = rpdao.getReplysbyRid(resourceId);
		return list;
	}

	@Override
	public List<Resource> getResourcesBykw(int page, int limit,String keyword) {
		// TODO Auto-generated method stub
		PageHelper.startPage(page, limit);
		List<Resource> list = rdao.getResourcesBykw(keyword);
		return list;
	}

	@Override
	public boolean addResource(Resource resource) {
		// TODO Auto-generated method stub
		if(rdao.addResource(resource)){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public Double getResourceCredit(Long resourceId) {
		// TODO Auto-generated method stub
		return rdao.getResourceCredit(resourceId);
	}

	@Override
	public Long getUserId(Long resourceId) {
		// TODO Auto-generated method stub
		return rdao.getUserId(resourceId);
	}

}
