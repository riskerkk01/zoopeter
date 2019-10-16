package zoopeter.admin.apicontroller;

//import java.util.Iterator;
import java.util.List;



import java.io.UnsupportedEncodingException;
//import java.text.DateFormat;
//import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.ConfigurableWebApplicationContext;

import zoopeter.module.domain.*;
import zoopeter.module.services.*;


@RestController
@RequestMapping("/api/session")
public class SessionApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(SessionApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;

	@RequestMapping(value = "", method=RequestMethod.GET ) 
	public Admin getinfo( Model model, HttpSession session,
			HttpServletResponse response, HttpServletRequest request ) {

		Admin admin = (Admin) session.getAttribute( "SESSION_USERAUTH");
		if( admin == null ) {
			admin = new Admin();
		}
		
		return admin;
	}
	
}
