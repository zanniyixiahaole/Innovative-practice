package com.web.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.web.entity.PhotoRecord;
import com.web.entity.Users;
import com.web.util.posepoint;

public interface UserService {
	ArrayList<posepoint> recongnize(ArrayList<posepoint> dirlist);
	//识别文字功能，缓存识别文字图片，待下载后再存入文件夹
	Users getByPhonenumberAndPassword(String phonenumber,String password);
	//根据用户名密码查询用户记录（登录用）
	boolean saveUser(Users user);
	//用户注册将记录添加到数据库中
	Users getUserID(String phonenumber) ;
	//根据电话号码获取用户信息
	Users getUserInfo(@Param("userId") Long userId);
	//通过用户id获取用户信息
	List<Users> getAllUsers();
	//通过所有用户信息
	Users getUser(String phonenumber);
	//通过电话号码获取用户信息
	boolean updatePermission(Long userId,Integer value);
	//更新用户权限
	boolean UpdatePassword(Users user);
	//更新用户信息或修改密码

	boolean updateMoney(Long userId,Double value);
	//更新用户积分

	boolean UpdataTimeAndNum(@Param("lastLoginTime")String lastLoginTime,@Param("loginNum")Integer loginNum,@Param("userId")Long userId);
	//活跃度排名
	List<Users> getRank();
}
