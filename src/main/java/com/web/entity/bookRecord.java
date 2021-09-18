package com.web.entity;

import java.util.Date;
import java.util.List;

public class bookRecord {
   private long bookrecord;
   private long bookid;
   private Integer recpage;
   private Integer recflag;
   private Date recbookdatetime;
   
   //bookRecord和bookWord为1对多关系 --刘帅威
   private List<bookword> bookWords;
   
public List<bookword> getBookWords() {
	return bookWords;
}
public void setBookWords(List<bookword> bookWords) {
	this.bookWords = bookWords;
}
public long getBookrecord() {
	return bookrecord;
}
public void setBookrecord(long bookrecord) {
	this.bookrecord = bookrecord;
}
public long getBookid() {
	return bookid;
}
public void setBookid(long bookid) {
	this.bookid = bookid;
}
public Integer getRecpage() {
	return recpage;
}
public void setRecpage(Integer recpage) {
	this.recpage = recpage;
}
public Integer getRecflag() {
	return recflag;
}
public void setRecflag(Integer recflag) {
	this.recflag = recflag;
}
public Date getRecbookdatetime() {
	return recbookdatetime;
}
public void setRecbookdatetime(Date recbookdatetime) {
	this.recbookdatetime = recbookdatetime;
}
@Override
public String toString() {
	return "bookRecord [bookrecord=" + bookrecord + ", bookid=" + bookid + ", recpage=" + recpage + ", recflag="
			+ recflag + ", recbookdatetime=" + recbookdatetime + ", bookWords=" + bookWords + "]";
}
   
   
   }