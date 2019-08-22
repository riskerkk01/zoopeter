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
@RequestMapping("/api/adbrix")
public class AdbrixApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdbrixApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private AdbrixService adbrixService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Adbrix sadbrix ){
		return "test";
	}
	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Adbrix> list(
			@RequestBody Adbrix sadbrix,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + sadbrix.getPage() );
		//logger.info( "seq:" + sadbrix.getSeq() );
		//logger.info( "searchkeyword:" + sadbrix.getSearchkeyword() );
		
		sadbrix.setStart( ( sadbrix.getPage() ) * sadbrix.getSize() );
		sadbrix.setCount( sadbrix.getSize() );
		
		String startdate = sadbrix.getStartdate();
		String enddate = sadbrix.getEnddate();
		if( "".equals(startdate) == false && startdate != null ) {
			startdate = startdate + " 00:00:00";
			sadbrix.setStartdate( startdate );
		}
		if( "".equals(enddate) == false && enddate != null ) {
			enddate = enddate + " 23:59:59";
			sadbrix.setEnddate( enddate );
		}
		
		List<Adbrix> adbrixList = null;
		adbrixList = adbrixService.getAdbrixList( sadbrix );
		int adbrixCount = adbrixService.countAdbrix( sadbrix );
		
		return new ResultPageDomain<Adbrix>( sadbrix.getPage(), sadbrix.getSize(), adbrixCount, adbrixList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Adbrix sadbrix, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		int newseq = adbrixService.setAdbrix( sadbrix );
		if( newseq == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{seq}", method=RequestMethod.GET ) 
	public Adbrix getinfo(@PathVariable int seq, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Adbrix tmp = adbrixService.getAdbrix( seq );
		if( tmp == null ) {
			tmp = new Adbrix();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int seq,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Adbrix adbrix,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Adbrix tmp = adbrixService.getAdbrix( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		adbrixService.updateAdbrix( adbrix );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int seq, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Adbrix tmp = adbrixService.getAdbrix( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		adbrixService.deleteAdbrix( seq );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
