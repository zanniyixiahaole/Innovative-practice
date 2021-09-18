package com.web.service;

import java.util.List;

import com.web.entity.Reply;
import com.web.entity.Resource;

public interface resourceService {
	List<Resource> getResources(int page,int limit);
	Resource getResource(Long resourceId);
	List<Reply> getReplys(Long resourceId,int page,int limit);
	List<Resource> getResourcesBykw(int page,int limit,String keyword);
	boolean addResource(Resource resource);
	Double getResourceCredit(Long resourceId);
	Long getUserId(Long resourceId);
}
