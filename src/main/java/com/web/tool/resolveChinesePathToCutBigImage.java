package com.web.tool;

import com.sun.jna.platform.win32.Kernel32;
import com.sun.jna.win32.W32APIOptions;
import com.sun.jna.Native;
//..
public class resolveChinesePathToCutBigImage {
  private static Kernel32 kernel32 = (Kernel32) Native.loadLibrary(Kernel32.class, W32APIOptions.UNICODE_OPTIONS);
//..
  public static String convertToWindowsShortName(String longFilename) {
    char result[] = new char[longFilename.length()];
    kernel32.GetShortPathName(longFilename, result, longFilename.length());
    return new String(result).trim();
  }
}