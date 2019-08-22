package zoopeter.access.notused;

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
@RequestMapping("/notused/adjust")
public class AdjustApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdjustApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private AdjustService adjustService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Adjust sadjust ){
		return "test";
	}
	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Adjust> list(
			@RequestBody Adjust sadjust,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + sadjust.getPage() );
		//logger.info( "seq:" + sadjust.getSeq() );
		//logger.info( "searchkeyword:" + sadjust.getSearchkeyword() );
		
		sadjust.setStart( ( sadjust.getPage() ) * sadjust.getSize() );
		sadjust.setCount( sadjust.getSize() );
		
		String startdate = sadjust.getStartdate();
		String enddate = sadjust.getEnddate();
		if( "".equals(startdate) == false && startdate != null ) {
			startdate = startdate + " 00:00:00";
			sadjust.setStartdate( startdate );
		}
		if( "".equals(enddate) == false && enddate != null ) {
			enddate = enddate + " 23:59:59";
			sadjust.setEnddate( enddate );
		}
		
		List<Adjust> adjustList = null;
		adjustList = adjustService.getAdjustList( sadjust );
		int adjustCount = adjustService.countAdjust( sadjust );
		
		return new ResultPageDomain<Adjust>( sadjust.getPage(), sadjust.getSize(), adjustCount, adjustList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Adjust sadjust, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		int newseq = adjustService.setAdjust( sadjust );
		if( newseq == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{seq}", method=RequestMethod.GET ) 
	public Adjust getinfo(@PathVariable int seq, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Adjust tmp = adjustService.getAdjust( seq );
		if( tmp == null ) {
			tmp = new Adjust();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int seq,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Adjust adjust,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Adjust tmp = adjustService.getAdjust( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		adjustService.updateAdjust( adjust );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int seq, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Adjust tmp = adjustService.getAdjust( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		adjustService.deleteAdjust( seq );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
