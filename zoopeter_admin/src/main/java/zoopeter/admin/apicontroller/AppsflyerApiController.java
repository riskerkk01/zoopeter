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
@RequestMapping("/api/appsflyer")
public class AppsflyerApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(AppsflyerApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private AppsflyerService appsflyerService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Appsflyer sappsflyer ){
		return "test";
	}
	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Appsflyer> list(
			@RequestBody Appsflyer sappsflyer,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + sappsflyer.getPage() );
		//logger.info( "seq:" + sappsflyer.getSeq() );
		//logger.info( "searchkeyword:" + sappsflyer.getSearchkeyword() );
		
		sappsflyer.setStart( ( sappsflyer.getPage() ) * sappsflyer.getSize() );
		sappsflyer.setCount( sappsflyer.getSize() );
		
		String startdate = sappsflyer.getStartdate();
		String enddate = sappsflyer.getEnddate();
		if( "".equals(startdate) == false && startdate != null ) {
			startdate = startdate + " 00:00:00";
			sappsflyer.setStartdate( startdate );
		}
		if( "".equals(enddate) == false && enddate != null ) {
			enddate = enddate + " 23:59:59";
			sappsflyer.setEnddate( enddate );
		}
		
		List<Appsflyer> appsflyerList = null;
		appsflyerList = appsflyerService.getAppsflyerList( sappsflyer );
		int appsflyerCount = appsflyerService.countAppsflyer( sappsflyer );
		
		return new ResultPageDomain<Appsflyer>( sappsflyer.getPage(), sappsflyer.getSize(), appsflyerCount, appsflyerList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Appsflyer sappsflyer, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		int newseq = appsflyerService.setAppsflyer( sappsflyer );
		if( newseq == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{seq}", method=RequestMethod.GET ) 
	public Appsflyer getinfo(@PathVariable int seq, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Appsflyer tmp = appsflyerService.getAppsflyer( seq );
		if( tmp == null ) {
			tmp = new Appsflyer();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int seq,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Appsflyer appsflyer,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Appsflyer tmp = appsflyerService.getAppsflyer( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		appsflyerService.updateAppsflyer( appsflyer );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int seq, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Appsflyer tmp = appsflyerService.getAppsflyer( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		appsflyerService.deleteAppsflyer( seq );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
