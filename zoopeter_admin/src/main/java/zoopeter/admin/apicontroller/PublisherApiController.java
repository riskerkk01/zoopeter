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
@RequestMapping("/api/publisher")
public class PublisherApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(PublisherApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private PublisherService publisherService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Publisher spublisher ){
		return "test";
	}
	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Publisher> list(
			@RequestBody Publisher spublisher,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + spublisher.getPage() );
		//logger.info( "publisherid:" + spublisher.getSeq() );
		//logger.info( "searchkeyword:" + spublisher.getSearchkeyword() );
		
		spublisher.setStart( ( spublisher.getPage() ) * spublisher.getSize() );
		spublisher.setCount( spublisher.getSize() );
		
		List<Publisher> publisherList = null;
		publisherList = publisherService.getPublisherList( spublisher );
		int publisherCount = publisherService.countPublisher( spublisher );
		
		return new ResultPageDomain<Publisher>( spublisher.getPage(), spublisher.getSize(), publisherCount, publisherList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Publisher spublisher, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		Publisher tmp = publisherService.getPublisherByCode( spublisher.getCode() );
		if( tmp != null ) {
			res.setResult("error");
			res.setNote( "Code값이 이미 존재합니다.");
			
			return res;
		}
		
		int newpublisherid = publisherService.setPublisher( spublisher );
		if( newpublisherid == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{publisherid}", method=RequestMethod.GET ) 
	public Publisher getinfo(@PathVariable int publisherid, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Publisher tmp = publisherService.getPublisher( publisherid );
		if( tmp == null ) {
			tmp = new Publisher();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{publisherid}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int publisherid,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Publisher publisher,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Publisher tmp = publisherService.getPublisher( publisherid );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		Publisher tmp2 = publisherService.getPublisherByCode( publisher.getCode() );
		if( tmp2 != null ) {
			if( tmp2.getPublisherid() != tmp.getPublisherid() ) {
				res.setResult("error");
				res.setNote( "Code값이 이미 존재합니다.");
				return res;
			}
		}
		
		publisherService.updatePublisher( publisher );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{publisherid}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int publisherid, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Publisher tmp = publisherService.getPublisher( publisherid );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		publisherService.deletePublisher( publisherid );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
