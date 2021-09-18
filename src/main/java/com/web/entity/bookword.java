package com.web.entity;


public class bookword {
	   private long bookwordid;
	   private Integer wordid;
	   private long record;
	   private String wordurl;
	   
	   
	   public bookword() {
		super();
		// TODO Auto-generated constructor stub
	   }

	public bookword(long bookwordid, Integer wordid, long record, String wordurl) {
		super();
		this.bookwordid = bookwordid;
		this.wordid = wordid;
		this.record = record;
		this.wordurl = wordurl;
	}
	
	public long getBookwordid() {
		return bookwordid;
	}
	public void setBookwordid(long bookwordid) {
		this.bookwordid = bookwordid;
	}
	public Integer getWordid() {
		return wordid;
	}
	public void setWordid(Integer wordid) {
		this.wordid = wordid;
	}
	public long getRecord() {
		return record;
	}
	public void setRecord(long record) {
		this.record = record;
	}
	public String getWordurl() {
		return wordurl;
	}
	public void setWordurl(String wordurl) {
		this.wordurl = wordurl;
	}

	@Override
	public String toString() {
		return "bookword [bookwordid=" + bookwordid + ", wordid=" + wordid + ", record=" + record + ", wordurl="
				+ wordurl + "]";
	}
	
	   
}
