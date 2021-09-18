package com.web.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Scan {
	public static Map scan(int[] a,int iog) {
		Map<String, ArrayList<Integer>> map = new HashMap<String, ArrayList<Integer>>();
		int pos=0;
		int start=0;
		ArrayList<Integer> V_start = new ArrayList<Integer>();
		ArrayList<Integer> V_end = new ArrayList<Integer>();
		for(int i=0;i<a.length;i++) {
			if(a[i]>iog&&start==0) {
				V_start.add(i);
				start=1;
			}
			if(a[i]<=iog&&start==1) {
				if(i-V_start.get(V_start.size()-1)<pos)
					continue;
				V_end.add(i);
				start=0;
			}
		}
		map.put("V_start",V_start);
		map.put("V_end",V_end);
		return map;
	}
}
