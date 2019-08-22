package zoopeter.access.controller;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping( "/errorpage" )
public class ErrorpageController {

	protected Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/noPermission", method=RequestMethod.GET ) 
	public String noPermission(Model model, HttpServletResponse response, HttpServletRequest request) {

		return "errorpage/noPermission";
	}
	
}
