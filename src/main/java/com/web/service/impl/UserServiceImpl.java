package com.web.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.datavec.image.loader.NativeImageLoader;
import org.deeplearning4j.nn.modelimport.keras.exceptions.InvalidKerasConfigurationException;
import org.deeplearning4j.nn.modelimport.keras.exceptions.UnsupportedKerasConfigurationException;
import org.deeplearning4j.nn.multilayer.MultiLayerNetwork;
import org.nd4j.linalg.api.ndarray.INDArray;
import org.nd4j.linalg.factory.Nd4j;
import org.nd4j.linalg.indexing.NDArrayIndex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.dao.UsersDao;
import com.web.entity.PhotoRecord;
import com.web.entity.Users;
import com.web.service.UserService;
import com.web.util.GetInfo;
import com.web.util.model;
import com.web.util.posepoint;

import javax.annotation.Resource;

@Service
public class UserServiceImpl implements UserService {
	@Resource
	private UsersDao userDao;
	// 获取汉字
	String[] info = GetInfo.Handle();
	List<String> list = Arrays.asList(info);
	String result=null; 
	MultiLayerNetwork network = model.loadModel();



	@Override
	public ArrayList<posepoint> recongnize(ArrayList<posepoint> pathlist) {
		NativeImageLoader loader = new NativeImageLoader(64, 64);
		INDArray image = null;
		try {
			image = loader.asMatrix(new File(pathlist.get(0).getDir()));
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		for (int i = 1; i < pathlist.size(); i++) {
            NativeImageLoader loader1 = new NativeImageLoader(64, 64);
			try {
				image = Nd4j.vstack(image, loader1.asMatrix(new File(pathlist.get(i).getDir())));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		INDArray output = network.output(image);
		long wordnum = output.length() / 3495;
		INDArray out = output.reshape(wordnum, 3495);
		INDArray rowout;
		for (int i = 0; i < wordnum; i++) {
			rowout = out.getRow(i);
			Double max = (Double) rowout.maxNumber();
			for (int j = 0; j < 3495; j++) {
				if (max == rowout.getDouble(0, j)) {
					result = list.get(j);
					pathlist.get(i).setWord(result);

					break;
				}
			}
		}
		loader=null;
		image=null;
		out=null;
		rowout=null;
		output=null;
        System.gc();


		return pathlist;

	}
	@Override
	public Users getByPhonenumberAndPassword(String phonenumber, String password) {
		return userDao.checkPhonenumberAndPassword(phonenumber, password);
	}
	@Override
	public boolean saveUser(Users user) {
		boolean flag = userDao.saveUser(user);
		if(flag) {
			return true;
		}else		
			return false;
	}

	@Override
	public Users getUserID(String phonenumber) {
		Users userID = userDao.getUserID(phonenumber);
		return userID;
	}
	@Override
	public Users getUserInfo(Long userId) {
		return userDao.getUserInfo(userId);
	}

	@Override
	public List<Users> getAllUsers() {
		// TODO Auto-generated method stub
		return userDao.getAllUsers();
	}

	@Override
	public Users getUser(String phonenumber) {
		// TODO Auto-generated method stub
		return userDao.getUser(phonenumber);
	}

	@Override
	public boolean updatePermission(Long userId, Integer value) {
		// TODO Auto-generated method stub
		return userDao.updatePermission(userId,value);
	}
	@Override
	public boolean UpdatePassword(Users user) {
		// TODO Auto-generated method stub
		
		return userDao.UpdataUser(user);
	}
	@Override
	public boolean updateMoney(Long userId, Double value) {
		// TODO Auto-generated method stub
		return userDao.updateMoney(userId, value);
	}  
	@Override

	public boolean UpdataTimeAndNum(String lastLoginTime, Integer loginNum, Long userId) {
		// TODO Auto-generated method stub
		return userDao.UpdataTimeAndNum(lastLoginTime, loginNum, userId);
	}
	@Override
	public List<Users> getRank() {
		// TODO Auto-generated method stub
		return userDao.getRank();
	}

}
