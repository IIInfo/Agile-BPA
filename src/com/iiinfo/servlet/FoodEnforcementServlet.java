package com.iiinfo.servlet;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		if(classification!=null && classification.equalsIgnoreCase("All")){
			classification = null;
		}
		
		if(recallNumber != null && comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcement")){
			response.sendRedirect("foodEnforcementProductDetail.jsp?recallNumber="+recallNumber+"");
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
			String eventId = request.getParameter("eventId");
			response.sendRedirect("foodEnforcementEventDetail.jsp?eventId="+eventId+"");
		}
	}
    
   
    
    public void downloadCsv(HttpServletRequest request, HttpServletResponse response)
    {	
    	 String outputResult ="RECALL DATE" + "," + "PRODUCT DESCRIPTION" + "," + "CLASSIFICATION" + "," + "REASON FOR RECALL" + "," + "RECALLING FIRM" + "," + "DISTRIBUTION PATTERN" + "\n";
    	 String jsonString = request.getParameter("dataObject");
    	 JSONParser parser=new JSONParser();
    	 try
         {
            Object obj = parser.parse(jsonString);
            JSONArray array = (JSONArray)obj;
          
            for(Object arrayObject:array){
            	JSONObject arrayObj = (JSONObject)arrayObject;
            	String recall_initiation_date = formatRecallInitationDate((String) arrayObj.get("recall_initiation_date"));
            	
            	String product_description = (String) arrayObj.get("product_description");
            	product_description = product_description.replaceAll(",", ";");
            	product_description = product_description.replaceAll("\n", ";");
            	
            	String classification = (String) arrayObj.get("classification");
            	String reason_for_recall = (String) arrayObj.get("reason_for_recall");
            	reason_for_recall = reason_for_recall.replaceAll(",", ";");
            	reason_for_recall = reason_for_recall.replaceAll("\n", ";");
            	
            	String recalling_firm = (String) arrayObj.get("recalling_firm");
            	recalling_firm = recalling_firm.replaceAll(",", ";");
            	recalling_firm = recalling_firm.replaceAll("\n", ";");
            	
            	String distribution_pattern = (String) arrayObj.get("distribution_pattern");
            	distribution_pattern = distribution_pattern.replaceAll(",", ";");
            	distribution_pattern = distribution_pattern.replaceAll("\n", ";");
            	
            	outputResult += recall_initiation_date + "," + product_description + "," + classification + "," + reason_for_recall + "," + recalling_firm + "," + distribution_pattern + "\n";
            }
          

            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"userDirectory.csv\"");
       
            OutputStream outputStream = response.getOutputStream();
            //String outputResult = "xxxx, yyyy, zzzz, aaaa, bbbb, ccccc, dddd, eeee, ffff, gggg\n";
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
		
		if(classification!=null && classification.equalsIgnoreCase("All")){
			classification = null;
		}
		
		if(recallNumber != null && comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcement")){
			response.sendRedirect("foodEnforcementProductDetail.jsp?recallNumber="+recallNumber+"");
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
			String eventId = request.getParameter("eventId");
			response.sendRedirect("foodEnforcementEventDetail.jsp?eventId="+eventId+"");
		}
	}

}
