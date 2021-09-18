package com.web.interceptor;

import java.io.*;
import com.web.tool.url;
import java.util.*;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.sax.SAXTransformerFactory;
import javax.xml.transform.sax.TransformerHandler;
import javax.xml.transform.stream.StreamResult;
import org.xml.sax.SAXException;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;



public class SAXWrite {
    // 句柄
    private TransformerHandler handler = null;
    // 输出流
    private OutputStream outStream = null;
    // 根节点
    private String rootElement;
    public static String dirft=url.dir+"/";

    public SAXWrite(String fileName, String rootElement) throws Exception {
        this.rootElement = rootElement;

        // 创建句柄，并设置初始参数
        SAXTransformerFactory fac = (SAXTransformerFactory) SAXTransformerFactory
                .newInstance();
        handler = fac.newTransformerHandler();
        Transformer transformer = handler.getTransformer();
        transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "no");

        outStream = new FileOutputStream(fileName);
        handler.setResult(new StreamResult(outStream));

    }

    public void start() throws Exception {
        handler.startDocument();
        handler.characters("\n".toCharArray(), 0, "\n".length());//给子元素节点添加缩进
        handler.startElement("", "", rootElement, null);
    }

    // 这个函数是最重要的，它可以控制各个细节：是否写入属性值，文本值又是多少等等
    public void write(HashMap<String, String> map, String element)
            throws SAXException {
        handler.characters("\n  ".toCharArray(), 0, "\n  ".length());//给子元素节点添加缩进
        handler.startElement("", "", element, null);
        Iterator<String> it = map.keySet().iterator();
        while (it.hasNext()) {
            String key = (String) it.next();
            String value = map.get(key);
            handler.characters("\n    ".toCharArray(), 0, "\n    ".length());//给子元素节点添加缩进
            handler.startElement("", "", key, null);
            handler.characters(value.toCharArray(), 0, value.length());
            handler.endElement("", "", key);
        }
        handler.characters("\n  ".toCharArray(), 0, "\n  ".length());//给子元素节点添加缩进
        handler.endElement("", "", element);
    }

    public void end() throws Exception {
        handler.endElement("", "", rootElement);
        handler.endDocument();
        outStream.close();
    }

    public static void savexml(JSONArray json,String fileUrl) throws Exception {
        SAXWrite xml = new SAXWrite(dirft+fileUrl.split("/.")[0]+".xml", "wordandpoints");
        xml.start();
        JSONObject jsonOne;
		 for(int i=0;i<json.size()-1;i++){
	        	jsonOne = json.getJSONObject(i); 
	        	HashMap<String, String> map = new HashMap<String, String>();
	        	 map.put("word",String.valueOf(jsonOne.get("word")));
	             map.put("x",String.valueOf(jsonOne.get("x")));
	             map.put("y", String.valueOf(jsonOne.get("y")));
	             map.put("height", String.valueOf(jsonOne.get("height")));
	             map.put("width", String.valueOf(jsonOne.get("width")));
	             xml.write(map, "point");
		 }
        xml.end();
    }

	
   
}
