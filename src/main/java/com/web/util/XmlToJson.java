package com.web.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.io.IOUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.XML;

public class XmlToJson {
	public static JSONObject xml2jsonString(String xmlUrl) throws JSONException, IOException {
		File file = new File(xmlUrl);
        //InputStream in = XmlToJson.class.getResourceAsStream(xmlUrl);
		InputStream in = new FileInputStream(file);
        String xml = IOUtils.toString(in);
        JSONObject xmlJSONObj = XML.toJSONObject(xml);
        return xmlJSONObj;
    }
}
