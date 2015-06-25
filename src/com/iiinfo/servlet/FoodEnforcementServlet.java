package com.iiinfo.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String comingFrom = request.getParameter("comingFrom");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		String recallNumber = request.getParameter("recallNumber");
		String event = request.getParameter("event");
		
		if(recallNumber != null && comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcement")){
			response.sendRedirect("foodEnforcementProductDetail.jsp?recallNumber="+recallNumber+"");
		}
		else if(event != null ){
			response.sendRedirect("foodEnforcement.jsp");
		}
		else if(comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcement") && fromDate!=null && toDate!=null){
			response.sendRedirect("foodEnforcement.jsp?fromDate="+fromDate+"&toDate="+toDate+"");
		}else if(comingFrom!=null && comingFrom.equalsIgnoreCase("foodEnforcementProductDetail")){
			String eventId = request.getParameter("eventId");
			response.sendRedirect("foodEnforcementEventDetail.jsp?eventId="+eventId+"");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
