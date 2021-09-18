package com.web.tool;

public class StringFix {
    public static String StringFix (String ds){
        StringBuffer newDs = new StringBuffer(ds);
        String yStr = "\"y\":";
        String rStr = "}";

        int yPosition,rPosition,index = 0;

        for(yPosition = 1; yPosition > 0; index = rPosition + 2) {
            yPosition = newDs.indexOf(yStr,index);
            rPosition = newDs.indexOf(rStr,index);
            int yLength = rPosition - 4 - yPosition;
            char [] tcArray = new char[yLength];

            newDs.getChars(yPosition+4, rPosition,tcArray, 0);
            String ts = new String(tcArray, 0, yLength);
            int ti = Integer.valueOf(ts) + 25;
            newDs.delete(yPosition+4, rPosition);
            newDs.insert(yPosition+4, ti);
            yPosition = newDs.indexOf(yStr, rPosition + 2);
        }

        return newDs.toString();
    }
}
