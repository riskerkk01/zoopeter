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
@RequestMapping("/notused/sitecode")
public class SitecodeApiController {
	
	//private String m_pagecode = "sitecode";
	//private int pagesize = 10;
	
	private static final Logger logger = LoggerFactory.getLogger(SitecodeApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private SitecodeService sitecodeService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Sitecode ssitecode ){
		return "test";
	}

	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Sitecode> list(
			@RequestBody Sitecode ssitecode,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + ssitecode.getPage() );
		//logger.info( "seq:" + ssitecode.getSeq() );
		//logger.info( "searchkeyword:" + ssitecode.getSearchkeyword() );
		
		ssitecode.setStart( ( ssitecode.getPage() ) * ssitecode.getSize() );
		ssitecode.setCount( ssitecode.getSize() );
		
		List<Sitecode> sitecodeList = null;
		sitecodeList = sitecodeService.getSitecodeList( ssitecode );
		int sitecodeCount = sitecodeService.countSitecode( ssitecode );
		
		return new ResultPageDomain<Sitecode>( ssitecode.getPage(), ssitecode.getSize(), sitecodeCount, sitecodeList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Sitecode ssitecode, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		Sitecode tmp = sitecodeService.getSitecodeByCode( ssitecode.getCode() );
		if( tmp != null ) {
			res.setResult("error");
			res.setNote( "Code값이 이미 존재합니다.");
			
			return res;
		}
		
		int newseq = sitecodeService.setSitecode( ssitecode );
		if( newseq == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{seq}", method=RequestMethod.GET ) 
	public Sitecode getinfo(@PathVariable int seq, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Sitecode tmp = sitecodeService.getSitecode( seq );
		if( tmp == null ) {
			tmp = new Sitecode();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int seq,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Sitecode sitecode,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Sitecode tmp = sitecodeService.getSitecode( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		Sitecode tmp2 = sitecodeService.getSitecodeByCode( sitecode.getCode() );
		if( tmp2 != null ) {
			if( tmp2.getSeq() != tmp.getSeq() ) {
				res.setResult("error");
				res.setNote( "Code값이 이미 존재합니다.");
				return res;
			}
		}
		
		
		sitecodeService.updateSitecode( sitecode );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int seq, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Sitecode tmp = sitecodeService.getSitecode( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		sitecodeService.deleteSitecode( seq );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
