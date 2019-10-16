package zoopeter.admin.config;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//import io.nmn.mobirum_sns_admin.services.AdminuserService;

public class MyInterceptor extends HandlerInterceptorAdapter {

	protected Logger logger = LoggerFactory.getLogger(this.getClass());

	//@Autowired private AdminuserService userauthService;
   
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handle) throws Exception {
		
		//logger.info( "PREHANDLER START ================================================================");
		if (request.getSession().getAttribute("SESSION_USERAUTH") == null) {
			response.sendRedirect("/login");
			return false;
		}
		/*
		logger.info( "PREHANDLER START ================================================================");
		// HEXA 로그인은 되어 있고. autoqa 사이트는 로그인 되어 있지 않을떄.. 자동 로그인 처리.
		if (request.getSession().getAttribute("SESSION_USERAUTH") == null) {
			
			String IAM = "";
			Cookie[] cookies = request.getCookies();
			// IAM 쿠키 체크
			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					Cookie c = cookies[i];
					String cName = c.getName();
					String cValue = c.getValue();
					// logger.debug( "Cookie = " + cName + ":::" + cValue );
					if ("IAM".equals(cName)) {
						IAM = cValue;
					}
				}
			}
	
			if ("".equals(IAM))// )
			{
				// IAM 쿠키가 없으면 로그인 페이지로 이동
				response.sendRedirect("/login");
				return false;
			}

			logger.info( "SESSION_USERAUTH Not Exists" );
			HexaSession hexaSession = new HexaSession();
			Boolean initres = hexaSession.checkHexaUser(request, response);
			if (initres == true) { // Hexa 로그인 되어 있을 경우
				Adminuser adminUser = hexaSession.getAdminuser();
				if (adminUser.isRead() == false) {
					response.sendRedirect("errorpage/noPermission");
					return false;
				}
				HttpSession session = request.getSession();
				session.setAttribute("SESSION_USERAUTH", hexaSession.getAdminuser());
			} else {
				// logger.debug( "PREHANDLER /login redirect");
				response.sendRedirect("/login");
				return false;
			}
		}
		*/
		//logger.info( "PREHANDLER END ================================================================");
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);

		/*
		 * String user_id = ""; String user_nm = ""; String auth_lvl = "";
		 * Cookie[] cookies = request.getCookies(); if( cookies != null ) {
		 * for(int i=0; i < cookies.length; i++){ Cookie c = cookies[i] ; String
		 * cName = c.getName(); String cValue = c.getValue() ;
		 * 
		 * logger.debug( "Cookie = " + cName + ":::" + cValue ); if(
		 * "user_id".equals( cName ) ) { user_id = cValue; } if(
		 * "user_nm".equals( cName ) ) { user_nm = cValue; } if(
		 * "auth_lvl".equals( cName ) ) { auth_lvl = cValue; } } }
		 * 
		 * if( "".equals(user_id) == false && "".equals( user_nm) == false ) {
		 * modelAndView.addObject( "islogin", "1" ); modelAndView.addObject(
		 * "user_id", user_id ); modelAndView.addObject( "user_nm", user_nm);
		 * modelAndView.addObject( "auth_lvl", auth_lvl); }
		 */

		// logger.debug( "POSTHANDLER
		// ================================================================ ");

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		super.afterConcurrentHandlingStarted(request, response, handler);
	}

}
