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
@RequestMapping("/api/campaign")
public class CampaignApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(CampaignApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private CampaignService campaignService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Campaign scampaign ){
		return "test";
	}
	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Campaign> list(
			@RequestBody Campaign scampaign,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + scampaign.getPage() );
		//logger.info( "campaignid:" + scampaign.getSeq() );
		//logger.info( "searchkeyword:" + scampaign.getSearchkeyword() );
		
		scampaign.setStart( ( scampaign.getPage() ) * scampaign.getSize() );
		scampaign.setCount( scampaign.getSize() );
		
		List<Campaign> campaignList = null;
		campaignList = campaignService.getCampaignList( scampaign );
		int campaignCount = campaignService.countCampaign( scampaign );
		
		return new ResultPageDomain<Campaign>( scampaign.getPage(), scampaign.getSize(), campaignCount, campaignList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Campaign scampaign, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		Campaign tmp = campaignService.getCampaignByCode( scampaign.getCode() );
		if( tmp != null ) {
			res.setResult("error");
			res.setNote( "Code값이 이미 존재합니다.");
			
			return res;
		}
		
		int newcampaignid = campaignService.setCampaign( scampaign );
		if( newcampaignid == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{campaignid}", method=RequestMethod.GET ) 
	public Campaign getinfo(@PathVariable int campaignid, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Campaign tmp = campaignService.getCampaign( campaignid );
		if( tmp == null ) {
			tmp = new Campaign();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{campaignid}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int campaignid,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Campaign campaign,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Campaign tmp = campaignService.getCampaign( campaignid );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		Campaign tmp2 = campaignService.getCampaignByCode( campaign.getCode() );
		if( tmp2 != null ) {
			if( tmp2.getCampaignid() != tmp.getCampaignid() ) {
				res.setResult("error");
				res.setNote( "Code값이 이미 존재합니다.");
				return res;
			}
		}
		
		campaignService.updateCampaign( campaign );
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{campaignid}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int campaignid, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Campaign tmp = campaignService.getCampaign( campaignid );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		campaignService.deleteCampaign( campaignid );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
