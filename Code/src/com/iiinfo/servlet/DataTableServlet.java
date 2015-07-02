package com.iiinfo.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DataTableServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DataTableServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		//String json = "{ \"demo\":[[\"Shailendra\",\"Gohil\",\"11820 Parklawn Dr\",\"Suite 300\"],[\"Pramod\",\"Malhotra\",\"123 Main Street\",\"Suite 1200\"]]}";
		String json = "{"
+"  \"meta\": {"
+"    \"disclaimer\": \"openFDA is a beta research project and not for clinical use. While we make every effort to ensure that data is accurate, you should assume all results are unvalidated.\","
+"    \"license\": \"http://open.fda.gov/license\","
+"    \"last_updated\": \"2015-05-31\","
+"    \"results\": {"
+"      \"skip\": 0,"
+"      \"limit\": 1,"
+"      \"total\": 8016"
+"    }"
+"  },"
+"  \"results123\": ["
+"    {"
+"      \"recall_number\": \"F-0283-2013\","
+"      \"reason_for_recall\": \"During an FDA inspection, microbiological swabs were collected and the results found that 21 sub samples in zones 1, 2 & 3 are positive for Listeria Monocytogenes (L.M.), Listeria innocua (L.I.) or Listeria seeligeri (L.S.).  The firm is voluntarily recalling all products manufactured from August 20th to September 10th 2012 due to the possible contamination.  All products with sell by dates on or before 11-OCT. No illnesses have been reported.\","
+"      \"status\": \"Ongoing\","
+"      \"distribution_pattern\": \"MI and OH only.\","
+"      \"product_quantity\": \"520\","
+"      \"recall_initiation_date\": \"20120910\","
+"      \"state\": \"MI\","
+"      \"event_id\": \"63159\","
+"      \"product_type\": \"Food\","
+"      \"product_description\": \"#011 Zucchini Stir,Fry      0.75 pounds\","
+"      \"country\": \"US\","
+"      \"city\": \"Grand Rapids\","
+"      \"recalling_firm\": \"Spartan Central Kitchen\","
+"      \"report_date\": \"20121024\","
+"      \"@epoch\": 1424553174.836488,"
+"      \"voluntary_mandated\": \"Voluntary: Firm Initiated\","
+"      \"classification\": \"Class II\","
+"      \"code_info\": \"All with sell by dates on or before 15-Sep with UPC 0-11213-90380\","
+"      \"@id\": \"00028a950de0ef32fc01dc3963e6fdae7073912c0083faf0a1d1bcdf7a03c44c\","
+"      \"openfda\": {},"
+"      \"initial_firm_notification\": \"E-Mail\""
+"    }"
+"  ]"
+"}";
		out.println(json);
	}
}
