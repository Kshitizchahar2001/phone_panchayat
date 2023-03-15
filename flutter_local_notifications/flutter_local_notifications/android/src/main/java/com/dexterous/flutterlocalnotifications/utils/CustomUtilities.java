package com.dexterous.flutterlocalnotifications.utils;


import java.util.*;
import java.lang.*;
import com.google.gson.*;
import com.google.gson.stream.JsonReader;
import java.io.StringReader;


public class CustomUtilities {

    public static String getWhatsappShareUrl(String payload) {
        JsonObject jsonObject =  JavaJsonOperations.getJsonObjectFromString(payload);
        String shareMessage = jsonObject.get("shareMessage").getAsString();
        return "whatsapp://send?text=" + shareMessage;
    }

    public static String addReadNewsButtonClickPropertyToPayload(String payload) {
        JsonObject jsonObject= JavaJsonOperations.getJsonObjectFromString(payload);
        jsonObject.addProperty("readFullNewsButtonClicked",true);
        String newPayload = jsonObject.toString();
       return newPayload;
    }
    
}
