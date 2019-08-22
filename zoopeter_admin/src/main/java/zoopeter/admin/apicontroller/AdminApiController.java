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
@RequestMapping("/api/admin")
public class AdminApiController { 
	
	private static final Logger logger = LoggerFactory.getLogger(AdminApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private AdminService adminService;
	

	@RequestMapping(value="/test", method=RequestMethod.POST)
	public @ResponseBody String test( @RequestBody Admin sadmin ){
		return "test";
	}
	
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Admin> list(
			@RequestBody Admin sadmin,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		logger.info( "page:" + sadmin.getPage() );
		//logger.info( "adminid:" + sadmin.getSeq() );
		//logger.info( "searchkeyword:" + sadmin.getSearchkeyword() );
		
		sadmin.setStart( ( sadmin.getPage() ) * sadmin.getSize() );
		sadmin.setCount( sadmin.getSize() );
		
		List<Admin> adminList = null;
		adminList = adminService.getAdminList( sadmin );
		int adminCount = adminService.countAdmin( sadmin );
		
		return new ResultPageDomain<Admin>( sadmin.getPage(), sadmin.getSize(), adminCount, adminList);
	}
	
	@RequestMapping(value = "/create", method=RequestMethod.POST) 
	public ResultBaseDomain create(Model model, HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Admin sadmin, Errors errors  ) {
		
		ResultBaseDomain res = new ResultBaseDomain();
		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}
		
		Admin tmp = adminService.getAdminById( sadmin.getId() );
		if( tmp != null ) {
			res.setResult("error");
			res.setNote( "Id값이 이미 존재합니다.");
			
			return res;
		}
		
		sadmin.setPasswd( sadmin.getPasswdsha256() );
				
		int newadminid = adminService.setAdmin( sadmin );
		if( newadminid == 0 ) {
			res.setResult("error");
			res.setNote( "등록중 오류가 발생하였습니다.");
			return res;
		}
		
		res.setResult("ok");
		
		return res;
	}
	
	@RequestMapping(value = "/{adminid}", method=RequestMethod.GET ) 
	public Admin getinfo(@PathVariable int adminid, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Admin tmp = adminService.getAdmin( adminid );
		if( tmp == null ) {
			tmp = new Admin();
			return tmp;
		}
		return tmp;
	}
	
	@RequestMapping(value = "/update/{adminid}", method=RequestMethod.POST) 
	public ResultBaseDomain update(@PathVariable int adminid,
			HttpServletResponse response, HttpServletRequest request, 
			@Valid @RequestBody Admin admin,
			Errors errors, Model model  ) {

		ResultBaseDomain res = new ResultBaseDomain();

		if( errors.hasErrors() ) {
			res.setResult("error");
			res.setNote("Invalid Parameter:"+errors.toString());
			return res;
		}

		Admin tmp = adminService.getAdmin( adminid );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		adminService.updateAdmin( admin );
		
		if( "".equals( admin.getPasswdsha256() ) == false ) {
			admin.setPasswd( admin.getPasswdsha256() );
			adminService.updatePasswd( admin );
		}
		
		
		res.setResult("ok");
		return res;
	}	
	
	@RequestMapping(value = "/delete/{adminid}", method=RequestMethod.POST) 
	public ResultBaseDomain deleteAct(@PathVariable int adminid, Model model,
			HttpServletResponse response, HttpServletRequest request ) {
		
		ResultBaseDomain res = new ResultBaseDomain();

		Admin tmp = adminService.getAdmin( adminid );
		if( tmp == null ) {
			res.setResult("error");
			res.setNote("정보가 없습니다.");
			return res;
		}
		
		adminService.deleteAdmin( adminid );
		
		res.setResult( "ok" );
		
		return res;
	}
		
}
