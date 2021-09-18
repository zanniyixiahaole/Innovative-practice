package com.web.util;

import java.io.IOException;

import org.deeplearning4j.nn.conf.MultiLayerConfiguration;
import org.deeplearning4j.nn.modelimport.keras.KerasModelImport;
import org.deeplearning4j.nn.modelimport.keras.exceptions.InvalidKerasConfigurationException;
import org.deeplearning4j.nn.modelimport.keras.exceptions.UnsupportedKerasConfigurationException;
import org.deeplearning4j.nn.multilayer.MultiLayerNetwork;
import org.nd4j.linalg.io.ClassPathResource;

public class model {
	public static MultiLayerNetwork loadModel(){
		System.out.println("===========加载模型============");
		String modelJson;
		try {
			modelJson = new ClassPathResource("model_12.20_gen.json").getFile().getPath();
//          modelJson ="/usr/local/apache-tomcat-8.5.64/webapps/ssmAndDl4j-0.0.1-SNAPSHOT/WEB-INF/classes/model_12.20_gen.json";
//			modelJson = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.5\\webapps\\ssmAndDl4j_war\\WEB-INF\\classes\\model_12.20_gen.json";
            System.out.println(modelJson);
			try {
				MultiLayerConfiguration modelConfig = KerasModelImport.importKerasSequentialConfiguration(modelJson);
				String modelWeights = new ClassPathResource("model_12.20_gen.h5").getFile().getPath();
//                String modelWeights = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.5\\webapps\\ssmAndDl4j_war\\WEB-INF\\classes\\model_12.20_gen.h5";
				MultiLayerNetwork network = KerasModelImport.importKerasSequentialModelAndWeights(modelJson, modelWeights);
				System.out.println("===========模型加载成功！==========");
				return network;
			} catch (InvalidKerasConfigurationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (UnsupportedKerasConfigurationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;	
	}
}
