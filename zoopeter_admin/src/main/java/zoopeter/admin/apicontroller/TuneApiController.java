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
@RequestMapping("/api/tune")
public class TuneApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(TuneApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private TuneService tuneService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Tune stune ){
		return "test";
	}
	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Tune> list(
			@RequestBody Tune stune,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + stune.getPage() );
		//logger.info( "seq:" + stune.getSeq() );
		//logger.info( "searchkeyword:" + stune.getSearchkeyword() );
		
		stune.setStart( ( stune.getPage() ) * stune.getSize() );
		stune.setCount( stune.getSize() );
		
		String startdate = stune.getStartdate();
		String enddate = stune.getEnddate();
		if( "".equals(startdate) == false && startdate != null ) {
			startdate = startdate + " 00:00:00";
			stune.setStartdate( startdate );
		}
		if( "".equals(enddate) == false && enddate != null ) {
			enddate = enddate + " 23:59:59";
			stune.setEnddate( enddate );
		}
		
		List<Tune> tuneList = null;
		tuneList = tuneService.getTuneList( stune );
		int tuneCount = tuneService.countTune( stune );
		
		return new ResultPageDomain<Tune>( stune.getPage(), stune.getSize(), tuneCount, tuneList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Tune stune, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		int newseq = tuneService.setTune( stune );
		if( newseq == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{seq}", method=RequestMethod.GET ) 
	public Tune getinfo(@PathVariable int seq, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Tune tmp = tuneService.getTune( seq );
		if( tmp == null ) {
			tmp = new Tune();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int seq,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Tune tune,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Tune tmp = tuneService.getTune( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		tuneService.updateTune( tune );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{seq}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int seq, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Tune tmp = tuneService.getTune( seq );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		tuneService.deleteTune( seq );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
