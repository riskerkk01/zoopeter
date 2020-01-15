package zoopeter.admin.apicontroller;

//import java.util.Iterator; 

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.ConfigurableWebApplicationContext;
import zoopeter.module.domain.Common;
import zoopeter.module.domain.ResultBaseDomain;
import zoopeter.module.domain.ResultPageDomain;
import zoopeter.module.services.CommonService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.UnsupportedEncodingException;
import java.util.List;

//import java.text.DateFormat;
//import java.util.Date;
//import org.springframework.web.bind.annotation.PostMapping;


@RestController
@RequestMapping("/api/common")
public class CommonApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private CommonService commonService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Common scommon ){
		return "test";
	}
	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Common> list(
			@RequestBody Common scommon,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + scommon.getPage() );
		//logger.info( "seq:" + scommon.getSeq() );
		//logger.info( "searchkeyword:" + scommon.getSearchkeyword() );
		
		scommon.setStart( ( scommon.getPage() ) * scommon.getSize() );
		scommon.setCount( scommon.getSize() );
		
		String startdate = scommon.getStartdate();
		String enddate = scommon.getEnddate();
		if( "".equals(startdate) == false && startdate != null ) {
			startdate = startdate + " 00:00:00";
			scommon.setStartdate( startdate );
		}
		if( "".equals(enddate) == false && enddate != null ) {
			enddate = enddate + " 23:59:59";
			scommon.setEnddate( enddate );
		}
		
		List<Common> commonList = null;
		commonList = commonService.getCommonList( scommon );
		int commonCount = commonService.countCommon( scommon );
		
		return new ResultPageDomain<Common>( scommon.getPage(), scommon.getSize(), commonCount, commonList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Common scommon, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		int newseq = commonService.setCommon( scommon );
		if( newseq == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{seq}", method=RequestMethod.GET ) 
	public Common getinfo(@PathVariable int seq, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Common tmp = commonService.getCommon( seq );
		if( tmp == null ) {
			tmp = new Common();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int seq,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Common common,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Common tmp = commonService.getCommon( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		commonService.updateCommon( common );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int seq, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Common tmp = commonService.getCommon( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		commonService.deleteCommon( seq );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
