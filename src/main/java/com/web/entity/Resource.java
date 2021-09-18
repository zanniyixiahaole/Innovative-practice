package com.web.entity;

import java.util.Date;
import com.web.util.DateUtils;

public class Resource {
	private Long resourceId;
	private Long userId;
	private Date resourceDate;
	private String resourceDatestr;
	private String resourceName;
	private String resourceUrl;
	private String resourceDescription;
	private Integer resourceCredit;
	public Integer getResourceCredit() {
		return resourceCredit;
	}
	public void setResourceCredit(Integer resourceCredit) {
		this.resourceCredit = resourceCredit;
	}
	public Long getResourceId() {
		return resourceId;
	}
	public void setResourceId(Long resourceId) {
		this.resourceId = resourceId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Date getResourceDate() {
		return resourceDate;
	}
	public void setResourceDate(Date resourceDate) {
		this.resourceDate = resourceDate;
	}
	public String getResourceDatestr() {
		if(resourceDate!=null){
			resourceDatestr = DateUtils.date2String(resourceDate, "yyyy-MM-dd HH:mm:ss");
		}
		return resourceDatestr;
	}
	public void setResourceDatestr(String resourceDatestr) {
		this.resourceDatestr = resourceDatestr;
	}
	public String getResourceName() {
		return resourceName;
	}
	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}
	public String getResourceUrl() {
		return resourceUrl;
	}
	public void setResourceUrl(String resourceUrl) {
		this.resourceUrl = resourceUrl;
	}
	public String getResourceDescription() {
		return resourceDescription;
	}
	public void setResourceDescription(String resourceDescription) {
		this.resourceDescription = resourceDescription;
	}
	@Override
	public String toString() {
		return "Resource [resourceId=" + resourceId + ", userID=" + userId + ", resourceDate=" + resourceDate
				+ ", resourceDatestr=" + resourceDatestr + ", resourceName=" + resourceName + ", resourceUrl="
				+ resourceUrl + ", resourceDescription=" + resourceDescription + ", resourceCredit=" + resourceCredit
				+ "]";
	}
	
	
}
