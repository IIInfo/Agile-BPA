package com.iiinfo.servlet;


import static org.junit.Assert.assertEquals;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.junit.Test;

public class TestFoodEnforcement {

  @Test
  public void testFormatRecallDate() {

   FoodEnforcementServlet foodEnforcementServlet = new FoodEnforcementServlet();
   
   String recall_initiation_date ="20150624";
   String actualRecallDate = foodEnforcementServlet.formatRecallInitationDate(recall_initiation_date);
   assertEquals("06/24/2015", actualRecallDate);
    
  }
  
  @Test
  public void testSearchResultsWithReportDate() throws Exception {
	  
	  String sURL = "https://api.fda.gov/food/enforcement.json?api_key=kb68BYbRY8GJX5g7DkFD9U6trS5l4sl0gGvHwjOB&limit=100&search=report_date:[20150403+TO+20150702]";
	  int resultSize = testUrl(sURL);
	  assertEquals(100, resultSize);
      
  }
  
  @Test
  public void testSearchResultsWithFoodName() throws Exception {
	  
	  String sURL = "https://api.fda.gov/food/enforcement.json?api_key=kb68BYbRY8GJX5g7DkFD9U6trS5l4sl0gGvHwjOB&limit=100&search=report_date:[20150403+TO+20150702]+AND+reason_for_recall:Peanut+Butter";
	  int resultSize = testUrl(sURL);
	  assertEquals(2, resultSize);
      
  }
  
  @Test
  public void testSearchResultsWithClassification() throws Exception {
	  
	  String sURL = "https://api.fda.gov/food/enforcement.json?api_key=kb68BYbRY8GJX5g7DkFD9U6trS5l4sl0gGvHwjOB&limit=100&search=report_date:[20150403+TO+20150702]+AND+classification:Class+II";
	  int resultSize = testUrl(sURL);
	  assertEquals(100, resultSize);
      
  }
  
  @Test
  public void testSearchResultsWithReportDateAndFoodName() throws Exception {
	  
	  String sURL = "https://api.fda.gov/food/enforcement.json?api_key=kb68BYbRY8GJX5g7DkFD9U6trS5l4sl0gGvHwjOB&limit=100&search=report_date:[20150601+TO+20150701]+AND+reason_for_recall:Chicken";
	  int resultSize = testUrl(sURL);
	  assertEquals(0, resultSize);
      
  }
  
  @Test
  public void testSearchResultsWithReportDateAndClassification() throws Exception {
	  
	  String sURL = "https://api.fda.gov/food/enforcement.json?api_key=kb68BYbRY8GJX5g7DkFD9U6trS5l4sl0gGvHwjOB&limit=100&search=report_date:[20150501+TO+20150701]+AND+classification:Class+I";
	  int resultSize = testUrl(sURL);
	  assertEquals(81, resultSize);
      
  }
  
  @Test
  public void testSearchResultsWithFoodNameAndClassification() throws Exception {
	  
	  String sURL = "https://api.fda.gov/food/enforcement.json?api_key=kb68BYbRY8GJX5g7DkFD9U6trS5l4sl0gGvHwjOB&limit=100&search=report_date:[20150403+TO+20150702]+AND+reason_for_recall:icecream+AND+classification:Class+I";
	  int resultSize = testUrl(sURL);
	  assertEquals(0, resultSize);
      
  }
  
  public int testUrl(String sURL) throws Exception {
	  	
	  	int resultSize = 0;
	  	JSONParser jp = new JSONParser(); 
	  	try{
	    URL url = new URL(sURL);
		HttpURLConnection request = (HttpURLConnection) url.openConnection();
		request.connect();
		if(request.getContent() != null){
		  	Object obj =  jp.parse(new InputStreamReader((InputStream) request.getContent()));
		  	
		  	JSONObject jsonObjects = (JSONObject)obj;
		  	JSONArray array = (JSONArray) jsonObjects.get("results");
		  	resultSize = array.size();
		}
	  	}
	  	catch(Exception e){
	  	}
		return resultSize;
	  
  }
  
  

} 

