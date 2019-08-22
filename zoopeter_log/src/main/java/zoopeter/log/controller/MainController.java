package zoopeter.log.controller;

//import org.apache.log4j.Logger;
import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import zoopeter.module.domain.*;
import zoopeter.module.services.AdminService;

import java.text.DateFormat;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class MainController {
	protected Logger logger = LoggerFactory.getLogger(this.getClass());
	private String m_pagecode = "home";
	@Autowired	private AdminService adminService;
	
	@RequestMapping("/test")
	public String index( HttpSession session, Model model, 
			HttpServletResponse response, HttpServletRequest request) {
		
			Date date = new Date();		
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG);		
			String formattedDate = dateFormat.format(date);		
			String str = formattedDate;		
			model.addAttribute("serverTime", str);		
			
			return "main";
	}
}
