package com.dexterous.flutterlocalnotifications.utils;


import java.util.*;
import java.lang.*;
import com.google.gson.*;
import com.google.gson.stream.JsonReader;
import java.io.StringReader;


public class JavaJsonOperations {

    public static JsonObject getJsonObjectFromString(String str){
        Gson gson = new Gson();
        JsonReader jr = new JsonReader(new StringReader(str.trim()));
        jr.setLenient(true);
        JsonObject jsonObject = gson.fromJson(jr, JsonObject.class);
        return jsonObject;

    }

    
    
    static HashMap<String, String> getHashMapFromString(String input) {
        HashMap<String, String> map = new HashMap<String, String>();
        String arr[] = input.split(",", -1);
        for (int i = 0; i < arr.length; i++) {
            String key = arr[i].split(":")[0];
            String value = arr[i].split(":")[1];
            map.put(key, value);
            System.out.println("key" + key);
            System.out.println("value" + value);
        }
        return map;
    }
    

}

