package com.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.web.entity.PhotoRecord;
import com.web.entity.Users;

public interface UsersDao {
	
	Users checkPhonenumberAndPassword(@Param("phonenumber") String phonenumber,@Param("password") String password) ;
	/*
	 * 根据用户名从数据库中查询对应的记录,注册用，使用手机号注册的话，此方法作废
	 * @param userID
	 * @return 用户名存在，不可用 /不存在,可用
	 */
	Users getUserID(String phonenumber) ;
	/*
	 *根据电话号码获取用户信息
	 * @param user
	 */
	boolean saveUser(Users user) ;
	/*
	 * 将记录添加到数据库中
	 */
	Users getUserInfo(@Param("userId") Long userId);
	//通过用户id获取用户信息
	List<Users> getAllUsers();
	//通过所有用户信息
	Users getUser(String phonenumber);
	//通过电话号码获取用户信息
	boolean updatePermission(@Param("userId")Long userId,@Param("value")Integer value);
	//修改权限
	boolean UpdataUser(Users user);
	//更新用户信息或修改密码

	boolean updateMoney(@Param("userId")Long userId,@Param("value")Double value);
	//更新用户积分

	
	//更新用户登录时间和次数
	boolean UpdataTimeAndNum(@Param("lastLoginTime")String lastLoginTime,@Param("loginNum")Integer loginNum,@Param("userId")Long userId);
	//活跃度排名
	List<Users> getRank();

}
