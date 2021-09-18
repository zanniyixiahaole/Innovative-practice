package com.web.util;

import java.util.Comparator;

class SortX implements Comparator {
    public int compare(Object o1, Object o2) {
     posepoint s1 = (posepoint) o1;
     posepoint s2 = (posepoint) o2;
    if (s1.getX() > s2.getX())
      return 1;
     return -1;
    }
   }