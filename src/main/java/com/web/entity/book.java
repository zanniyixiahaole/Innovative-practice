package com.web.entity;

import java.util.Date;
import java.util.List;

/**
 * @author lj
 *
 */

public class book {
   private long bookid;
   private String bookname;
   private Integer bookpage;
   private String bookurl;
   private long userID;
   private Integer flag;
   private Date bookdatetime;
   private long bookmoney;
   private long bookbelonging;
   private Integer moneyflag;///用户自己上传的书为-1，等待确认的是0，已经确认的是1，管理员上传的初始化是2
   //book和bookRecord为1对多关系 --刘帅威
   private List<bookRecord> bookRecords;
   public Integer getMoneyflag() {
		return moneyflag;
	}
	public void setMoneyflag(Integer moneyflag) {
		this.moneyflag = moneyflag;
	}  
public List<bookRecord> getBookRecords() {
	return bookRecords;
}
public void setBookRecords(List<bookRecord> bookRecords) {
	this.bookRecords = bookRecords;
}
public long getBookid() {
	return bookid;
}
public void setBookid(long bookid) {
	this.bookid = bookid;
}
public String getBookname() {
	return bookname;
}
public void setBookname(String bookname) {
	this.bookname = bookname;
}
public Integer getBookpage() {
	return bookpage;
}
public void setBookpage(Integer bookpage) {
	this.bookpage = bookpage;
}
public String getBookurl() {
	return bookurl;
}
public void setBookurl(String bookurl) {
	this.bookurl = bookurl;
}
public long getUserID() {
	return userID;
}
public void setUserID(long userID) {
	this.userID = userID;
}
public Integer getFlag() {
	return flag;
}
public void setFlag(Integer flag) {
	this.flag = flag;
}
public Date getBookdatetime() {
	return bookdatetime;
}
public void setBookdatetime(Date bookdatetime) {
	this.bookdatetime = bookdatetime;
}


public long getBookmoney() {
	return bookmoney;
}
public void setBookmoney(long bookmoney) {
	this.bookmoney = bookmoney;
}
public long getBookbelonging() {
	return bookbelonging;
}
public void setBookbelonging(long bookbelonging) {
	this.bookbelonging = bookbelonging;
}
@Override
public String toString() {
	return "book [bookid=" + bookid + ", bookname=" + bookname + ", bookpage=" + bookpage + ", bookurl=" + bookurl
			+ ", userID=" + userID + ", flag=" + flag + ", bookdatetime=" + bookdatetime + ", bookmoney=" + bookmoney
			+ ", bookbelonging=" + bookbelonging + ", moneyflag=" + moneyflag + ", bookRecords=" + bookRecords + "]";
}



   
   }