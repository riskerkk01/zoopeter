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
@RequestMapping("/api/adbrixre")
public class AdbrixreApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdbrixreApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private AdbrixreService adbrixreService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Adbrixre sadbrixre ){
		return "test";
	}
	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Adbrixre> list(
			@RequestBody Adbrixre sadbrixre,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + sadbrixre.getPage() );
		//logger.info( "seq:" + sadbrixre.getSeq() );
		//logger.info( "searchkeyword:" + sadbrixre.getSearchkeyword() );
		
		sadbrixre.setStart( ( sadbrixre.getPage() ) * sadbrixre.getSize() );
		sadbrixre.setCount( sadbrixre.getSize() );
		
		String startdate = sadbrixre.getStartdate();
		String enddate = sadbrixre.getEnddate();
		if( "".equals(startdate) == false && startdate != null ) {
			startdate = startdate + " 00:00:00";
			sadbrixre.setStartdate( startdate );
		}
		if( "".equals(enddate) == false && enddate != null ) {
			enddate = enddate + " 23:59:59";
			sadbrixre.setEnddate( enddate );
		}
		
		List<Adbrixre> adbrixreList = null;
		adbrixreList = adbrixreService.getAdbrixreList( sadbrixre );
		int adbrixreCount = adbrixreService.countAdbrixre( sadbrixre );
		
		return new ResultPageDomain<Adbrixre>( sadbrixre.getPage(), sadbrixre.getSize(), adbrixreCount, adbrixreList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Adbrixre sadbrixre, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		int newseq = adbrixreService.setAdbrixre( sadbrixre );
		if( newseq == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{seq}", method=RequestMethod.GET ) 
	public Adbrixre getinfo(@PathVariable int seq, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Adbrixre tmp = adbrixreService.getAdbrixre( seq );
		if( tmp == null ) {
			tmp = new Adbrixre();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int seq,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Adbrixre adbrixre,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Adbrixre tmp = adbrixreService.getAdbrixre( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		adbrixreService.updateAdbrixre( adbrixre );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int seq, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Adbrixre tmp = adbrixreService.getAdbrixre( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		adbrixreService.deleteAdbrixre( seq );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
