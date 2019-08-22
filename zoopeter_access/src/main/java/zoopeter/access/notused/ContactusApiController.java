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
@RequestMapping("/notused/contactus")
public class ContactusApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(ContactusApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private ContactusService contactusService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Contactus scontactus ){
		return "test";
	}
	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Contactus> list(
			@RequestBody Contactus scontactus,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + scontactus.getPage() );
		//logger.info( "seq:" + scontactus.getSeq() );
		//logger.info( "searchkeyword:" + scontactus.getSearchkeyword() );
		
		scontactus.setStart( ( scontactus.getPage() ) * scontactus.getSize() );
		scontactus.setCount( scontactus.getSize() );
		
		List<Contactus> contactusList = null;
		contactusList = contactusService.getContactusList( scontactus );
		int contactusCount = contactusService.countContactus( scontactus );
		
		return new ResultPageDomain<Contactus>( scontactus.getPage(), scontactus.getSize(), contactusCount, contactusList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Contactus scontactus, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		/*
		Contactus tmp = contactusService.getContactusByCode( scontactus.getCode() );
		if( tmp != null ) {
			res.setResult("error");
			res.setNote( "Code값이 이미 존재합니다.");
			
			return res;
		}
		*/
		
		int newseq = contactusService.setContactus( scontactus );
		if( newseq == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{seq}", method=RequestMethod.GET ) 
	public Contactus getinfo(@PathVariable int seq, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Contactus tmp = contactusService.getContactus( seq );
		if( tmp == null ) {
			tmp = new Contactus();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int seq,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Contactus contactus,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Contactus tmp = contactusService.getContactus( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		contactusService.updateContactus( contactus );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int seq, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Contactus tmp = contactusService.getContactus( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		contactusService.deleteContactus( seq );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
