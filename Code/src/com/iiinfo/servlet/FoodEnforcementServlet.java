package com.iiinfo.servlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * Servlet implementation class FoodEnforcementServlet
 */
public class FoodEnforcementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodEnforcementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGetCall(request, response);
	}
    
    
    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    public void doGetCall(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String comingFrom = request.getParameter("comingFrom");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		String reasonForRecall = request.getParameter("reasonForRecall");
		String classification = request.getParameter("classification");
		String recallNumber = request.getParameter("recallNumber");
		String event = request.getParameter("event");
		String eventId = request.getParameter("eventId");
		
		if(recallNumber != null && comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcement")){
			response.sendRedirect("foodEnforcementProductDetail.jsp?recallNumber="+recallNumber+"");
		}
		else if(eventId != null && comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcement")){
			response.sendRedirect("foodEnforcementEventDetail.jsp?eventId="+eventId+"");
		}
		else if(event != null && event.equalsIgnoreCase("Home")){
			response.sendRedirect("foodEnforcement.jsp");
		}
		else if(event != null && event.equalsIgnoreCase("downloadCsv")){
			downloadCsv(request,response);
		}
		else if(comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcement")){
			response.sendRedirect("foodEnforcement.jsp?fromDate="+fromDate+"&toDate="+toDate+"&reasonForRecall="+reasonForRecall+"&classification="+classification+"");
		}
		else if(comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcementProductDetail")){
			response.sendRedirect("foodEnforcementEventDetail.jsp?eventId="+eventId+"");
		}
		
	}
    
   
    
    public void downloadCsv(HttpServletRequest request, HttpServletResponse response)
    {	
    
    	 DateFormat df = new SimpleDateFormat("yyyy-MM-dd_hh:mm:ss");
    	 String date = df.format(new Date());
    	 
    	 String outputResult ="RECALL DATE" + "," + "PRODUCT DESCRIPTION" + "," + "CLASSIFICATION" + "," + "REASON FOR RECALL" + "," + "RECALLING FIRM" + "," + "DISTRIBUTION PATTERN" + "\n";
    	 String jsonString = request.getParameter("dataObject");
    	 JSONParser parser=new JSONParser();
    	 try
         {
            Object obj = parser.parse(jsonString);
            JSONArray array = (JSONArray)obj;
          
            for(Object arrayObject:array){
            	JSONObject arrayObj = (JSONObject)arrayObject;
            	
            	String recall_initiation_date = "";
            	if(arrayObj.get("recall_initiation_date")!=null){
            		recall_initiation_date = formatRecallInitationDate((String) arrayObj.get("recall_initiation_date"));
            	}
            	
            	String product_description = "";
            	if(arrayObj.get("product_description")!=null){
	            	product_description = (String) arrayObj.get("product_description");
	            	product_description = product_description.replaceAll(",", ";");
	            	product_description = product_description.replaceAll("\n", ";");
            	}
            	
            	String classification = "";
            	if(arrayObj.get("classification")!=null){
            		classification = (String) arrayObj.get("classification");
            	}
            	
            	String reason_for_recall = "";
            	if(arrayObj.get("reason_for_recall")!=null){
	            	reason_for_recall = (String) arrayObj.get("reason_for_recall");
	            	reason_for_recall = reason_for_recall.replaceAll(",", ";");
	            	reason_for_recall = reason_for_recall.replaceAll("\n", ";");
            	}
            	
            	String recalling_firm = "";
            	if(arrayObj.get("recalling_firm")!=null){
	            	recalling_firm = (String) arrayObj.get("recalling_firm");
	            	recalling_firm = recalling_firm.replaceAll(",", ";");
	            	recalling_firm = recalling_firm.replaceAll("\n", ";");
            	}
            	
            	String distribution_pattern = "";
            	if(arrayObj.get("distribution_pattern")!=null){
	            	distribution_pattern = (String) arrayObj.get("distribution_pattern");
	            	distribution_pattern = distribution_pattern.replaceAll(",", ";");
	            	distribution_pattern = distribution_pattern.replaceAll("\n", ";");
            	}
            	
            	outputResult += recall_initiation_date + "," + product_description + "," + classification + "," + reason_for_recall + "," + recalling_firm + "," + distribution_pattern + "\n";
            }
          
            String fileName = "foodEnforcementResults" + date;
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename="+fileName+".csv");
       
            OutputStream outputStream = response.getOutputStream();
            
            outputStream.write(outputResult.getBytes());
            outputStream.flush();
            outputStream.close();
        }
        catch(Exception e)
        {
            System.out.println(e.toString());
        }
    }
    
    public String formatRecallInitationDate(String recall_initiation_date){
    	String recallInitiationDate = null;
    	if(recall_initiation_date!=null){
	    	String year = recall_initiation_date.substring(0, 4);
	    	String month = recall_initiation_date.substring(4, 6);
	    	String day = recall_initiation_date.substring(6, 8);
	    	recallInitiationDate = month +"/"+ day +"/"+ year;
    	}
		return recallInitiationDate;
	}
    
    public void csvDownload(HttpServletRequest request, HttpServletResponse response){
    	
	    HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet1 = wb.createSheet("sheet1");
	 
	 	HSSFRow row = sheet1.createRow(0);
	 	HSSFCell cell0 = row.createCell(0);
		cell0.setCellValue("RECALL DATE");

		HSSFCell cell1 = row.createCell(1);
		cell1.setCellValue("PRODUCT DESCRIPTION");

		HSSFCell cell2 = row.createCell(2);
		cell2.setCellValue("CLASSIFICATION");
		
		HSSFCell cell3 = row.createCell(2);
		cell3.setCellValue("REASON FOR RECALL");
		
		HSSFCell cell4 = row.createCell(2);
		cell4.setCellValue("RECALLING FIRM");
		
		HSSFCell cell5 = row.createCell(2);
		cell5.setCellValue("DISTRIBUTION PATTERN");
    	
	   	String jsonString = request.getParameter("dataObject");
	   	JSONParser parser=new JSONParser();
	   	 int i = 1;
	   	 try
	        {
	           Object obj = parser.parse(jsonString);
	           JSONArray array = (JSONArray)obj;
	         
	           for(Object arrayObject:array){
        	   
        	 	JSONObject arrayObj = (JSONObject)arrayObject;
               	String recall_initiation_date = formatRecallInitationDate((String) arrayObj.get("recall_initiation_date"));
               	String product_description = (String) arrayObj.get("product_description");
               	String classification = (String) arrayObj.get("classification");
               	String reason_for_recall = (String) arrayObj.get("reason_for_recall");
               	String recalling_firm = (String) arrayObj.get("recalling_firm");    	
               	String distribution_pattern = (String) arrayObj.get("distribution_pattern");
        	
	        	HSSFRow rowA = sheet1.createRow(i);
	        	HSSFCell cellA0 = rowA.createCell(0);
	        	cellA0.setCellValue(recall_initiation_date);
	
	   			HSSFCell cellA1 = rowA.createCell(1);
	   			cellA1.setCellValue(product_description);
	
	   			HSSFCell cellA2 = rowA.createCell(2);
	   			cellA2.setCellValue(classification);
	   			
	   			HSSFCell cellA3 = rowA.createCell(2);
	   			cellA3.setCellValue(reason_for_recall);
	   			
	   			HSSFCell cellA4 = rowA.createCell(2);
	   			cellA4.setCellValue(recalling_firm);
	   			
	   			HSSFCell cellA5 = rowA.createCell(2);
	   			cellA5.setCellValue(distribution_pattern);
	   			
	            i++;
           }
	        FileOutputStream fileOut = new FileOutputStream("c:\\Temp\\drops1.xls");
	   		wb.write(fileOut);

           response.setContentType("text/xls");
           response.setHeader("Content-Disposition", "attachment; filename=\"userDirectory.xls\"");
      
           
           wb.close();
       }
       catch(Exception e)
       {
           System.out.println(e.toString());
       }
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPostCall(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doPostCall(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comingFrom = request.getParameter("comingFrom");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		String reasonForRecall = request.getParameter("reasonForRecall");
		String classification = request.getParameter("classification");
		String recallNumber = request.getParameter("recallNumber");
		String event = request.getParameter("event");
		String eventId = request.getParameter("eventId");
		
		if(recallNumber != null && comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcement")){
			response.sendRedirect("foodEnforcementProductDetail.jsp?recallNumber="+recallNumber+"");
		}
		else if(eventId != null && comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcement")){
			response.sendRedirect("foodEnforcementEventDetail.jsp?eventId="+eventId+"");
		}
		else if(event != null && event.equalsIgnoreCase("Home")){
			response.sendRedirect("foodEnforcement.jsp");
		}
		else if(event != null && event.equalsIgnoreCase("downloadCsv")){
			downloadCsv(request,response);
		}
		else if(comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcement")){
			response.sendRedirect("foodEnforcement.jsp?fromDate="+fromDate+"&toDate="+toDate+"&reasonForRecall="+reasonForRecall+"&classification="+classification+"");
		}
		else if(comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcementProductDetail")){
			response.sendRedirect("foodEnforcementEventDetail.jsp?eventId="+eventId+"");
		}
	}

}
