package zoopeter.admin.controller;

import java.io.UnsupportedEncodingException;



import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.util.UriComponents;

import zoopeter.module.domain.*;
import zoopeter.module.services.*;
//import click.services.AdminuserService;

@Controller
public class SessionController {

	protected Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired private AdminService g_adminService;
	
	//@Autowired private AdminuserService userauthService;

//	@Autowired
	//LoginSessionNotUse loginSession;
	
	@RequestMapping("/logout")
	public String logout(HttpSession session, Model model, HttpServletResponse response, HttpServletRequest request) {
		
		Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	        	//if( "IAM".equals( cookie.getName() ) == true || "LoginCookie".equals( cookie.getName() ) == true ) {
	        		cookie.setValue("0");
	            	cookie.setDomain("nmn.io");
	        		cookie.setPath("/");
	        		cookie.setMaxAge(0);
	        		response.addCookie(cookie);
	        	//}
	        }
	    }
	    
	    session.removeAttribute( "SESSION_USERAUTH" );
	    //HexaSession hexaSession = new HexaSession();
		//String initres = hexaSession.init(model, request, response, false, userauthService );
		/*
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null){    
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		*/
	    
		ServletUriComponentsBuilder.fromServletMapping(request);
		UriComponents uri = ServletUriComponentsBuilder.fromPath("/logout_after").build();
		return "redirect:" + uri.toUriString();
		//return "redirect: https://p.nmn.io/logout.aspx";
		//return "redirect: "+request.getContextPath()+"/logout_after";
	}

	@RequestMapping("/logout_after")
	public String logout_after(Model model, HttpServletResponse response, HttpServletRequest request) {
		return "login/logout_after";
	}
	
	@RequestMapping( value = "/loginact", method=RequestMethod.POST )
	public String loginact( HttpSession session, Model model, HttpServletResponse response, HttpServletRequest request,
			@RequestParam(value="id", required=true) String p_id,
			@RequestParam(value="passwd_sha256", required=true) String p_passwd,
			@RequestParam(value="id_save", required=false, defaultValue="0") int p_id_save
			) {
		logger.info( "Welcome loginact222 {}", session.getId() );
				
		logger.info( "id : {}", p_id );
		logger.info( "passwd : {}", p_passwd ); 
		
		if( "".equals( p_id ) == false ) {
			
			Admin admin = g_adminService.getAdminById( p_id );
			if( admin != null ) {
				if( p_passwd.equals( admin.getPasswd() ) == true ) {
					session.setAttribute( "SESSION_USERAUTH", admin );	
					ServletUriComponentsBuilder.fromServletMapping(request);
					UriComponents uri = ServletUriComponentsBuilder.fromPath("/").build();
					return "redirect:" + uri.toUriString();
				} else {
					model.addAttribute( "errmsg", "비밀번호가 틀립니다." );
				}
			} else {
				model.addAttribute( "errmsg", "사용자가 없습니다." );
			}
		} 
		
		return "login/login";
	}
	
	@RequestMapping( value = "/login", method=RequestMethod.GET )
	public String login( HttpSession session, Model model, HttpServletResponse response, HttpServletRequest request )
	{
		logger.info( "Welcome login {}", session.getId() );

		URL url=null;
		try {
			url = new URL(request.getRequestURL().toString());
		} catch (MalformedURLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	    String host  = url.getHost();
	    String userInfo = url.getUserInfo();
	    String scheme = url.getProtocol();
	    int port = url.getPort();
	    String path = (String) request.getAttribute("javax.servlet.forward.request_uri");
	    String query = (String) request.getAttribute("javax.servlet.forward.query_string");
	    String encodedUri="";
	    try {
			URI uri = new URI(scheme,userInfo,host,port,path,query,null);
			try {
				encodedUri = URLEncoder.encode( uri.toString(), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    model.addAttribute( "selfurl", encodedUri );
		
		return "login/login";
	}
}
