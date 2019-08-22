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
@RequestMapping("/api/clicklog")
public class ClicklogApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(ClicklogApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private ClicklogService clicklogService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Clicklog sclicklog ){
		return "test";
	}
	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Clicklog> list(
			@RequestBody Clicklog sclicklog,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + sclicklog.getPage() );
		//logger.info( "seq:" + sclicklog.getSeq() );
		//logger.info( "searchkeyword:" + sclicklog.getSearchkeyword() );
		
		sclicklog.setStart( ( sclicklog.getPage() ) * sclicklog.getSize() );
		sclicklog.setCount( sclicklog.getSize() );
		
		String startdate = sclicklog.getStartdate();
		String enddate = sclicklog.getEnddate();
		if( "".equals(startdate) == false && startdate != null ) {
			startdate = startdate + " 00:00:00";
			sclicklog.setStartdate( startdate );
		}
		if( "".equals(enddate) == false && enddate != null ) {
			enddate = enddate + " 23:59:59";
			sclicklog.setEnddate( enddate );
		}
		
		List<Clicklog> clicklogList = null;
		clicklogList = clicklogService.getClicklogList( sclicklog );
		int clicklogCount = clicklogService.countClicklog( sclicklog );
		
		return new ResultPageDomain<Clicklog>( sclicklog.getPage(), sclicklog.getSize(), clicklogCount, clicklogList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Clicklog sclicklog, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		int newseq = clicklogService.setClicklog( sclicklog );
		if( newseq == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{seq}", method=RequestMethod.GET ) 
	public Clicklog getinfo(@PathVariable int seq, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Clicklog tmp = clicklogService.getClicklog( seq );
		if( tmp == null ) {
			tmp = new Clicklog();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int seq,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Clicklog clicklog,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Clicklog tmp = clicklogService.getClicklog( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		clicklogService.updateClicklog( clicklog );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int seq, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Clicklog tmp = clicklogService.getClicklog( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		clicklogService.deleteClicklog( seq );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
