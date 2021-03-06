package zoopeter.access.notused;

//import java.util.Iterator;
import java.util.List;



import java.io.UnsupportedEncodingException;
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
@RequestMapping("/notused/siteconfig")
public class SiteconfigApiController {
	
	//private String m_pagename = "siteconfig";
	//private int pagesize = 10;
	
	private static final Logger logger = LoggerFactory.getLogger(SiteconfigApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private SiteconfigService siteconfigService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Siteconfig ssiteconfig ){
		return "test";
	}

	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Siteconfig> list(
			@RequestBody Siteconfig ssiteconfig,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + ssiteconfig.getPage() );
		//logger.info( "seq:" + ssiteconfig.getSeq() );
		//logger.info( "searchkeyword:" + ssiteconfig.getSearchkeyword() );
		
		ssiteconfig.setStart( ( ssiteconfig.getPage() ) * ssiteconfig.getSize() );
		ssiteconfig.setCount( ssiteconfig.getSize() );
		
		List<Siteconfig> siteconfigList = null;
		siteconfigList = siteconfigService.getSiteconfigList( ssiteconfig );
		int siteconfigCount = siteconfigService.countSiteconfig( ssiteconfig );
		
		return new ResultPageDomain<Siteconfig>( ssiteconfig.getPage(), ssiteconfig.getSize(), siteconfigCount, siteconfigList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Siteconfig ssiteconfig, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		Siteconfig tmp = siteconfigService.getSiteconfigByName( ssiteconfig.getName() );
		if( tmp != null ) {
			res.setResult("error");
			res.setNote( "Name값이 이미 존재합니다.");
			
			return res;
		}
		
		int newseq = siteconfigService.setSiteconfig( ssiteconfig );
		if( newseq == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{seq}", method=RequestMethod.GET ) 
	public Siteconfig getinfo(@PathVariable int seq, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Siteconfig tmp = siteconfigService.getSiteconfig( seq );
		if( tmp == null ) {
			tmp = new Siteconfig();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int seq,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Siteconfig siteconfig,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Siteconfig tmp = siteconfigService.getSiteconfig( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		siteconfigService.updateSiteconfig( siteconfig );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int seq, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Siteconfig tmp = siteconfigService.getSiteconfig( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		siteconfigService.deleteSiteconfig( seq );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
