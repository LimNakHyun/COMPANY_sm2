/**
 * @Class Name : Sm2LoginController.java
 * @Description : 사업 매출 정보 로그인 controller 클래스
 * @Modification Information
 * @
 * @   수정일                   수정자                                       수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2023.03.13     임낙현                                      최초생성
 *
 * @author 개발5팀 임낙현 사원
 * @since 2023.03.13
 * @version 1.0
 * @see
 */

package sm2.login.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import sm2.cmm.cmm.CommandMap;
import sm2.login.service.Sm2LoginService;

@Controller
public class Sm2LoginController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "sm2LoginService")
	private Sm2LoginService sm2LoginService;
	
	
	/**
	 * 로그인 직후 표시 페이지
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardList"
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/openSm2MainLogin.do")
	public ModelAndView openSm2MainLogin(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardList");
		try {
			session.setAttribute("year", "2023");
//			System.out.println("세션값 출력: " + session.getAttribute("login"));
			session.setAttribute("login", "on");
//			System.out.println("세션값 출력: " + session.getAttribute("login"));
		} catch(Exception e) {
			log.info(e.getMessage());
			ModelAndView mv2 = new ModelAndView("redirect:/openSm2Index.do");
			return mv2;
		}
		
		return mv;
	}
	
	/**
	 * 로그인 계정 체크 ajax
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardList"
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/openSm2LoginAjax.do")
	public ModelAndView openSm2LoginAjax(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		
		try {
			
			Map<String, Object> userInfo = sm2LoginService.selectBoardUserInfo(commandMap.getMap());
			mv.addObject("userInfo", userInfo);
			
		} catch(Exception e) {
			log.info(e.getMessage());
			ModelAndView mv2 = new ModelAndView("redirect:/openSm2Index.do");
			return mv2;
		}
		
		return mv;
	}
	
	/**
	 * 로그아웃
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardList"
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/openSm2Logout.do")
	public ModelAndView openSm2Logout(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardLogin");
		
		try {
			session.invalidate();
		} catch(Exception e) {
			log.info(e.getMessage());
			ModelAndView mv2 = new ModelAndView("redirect:/openSm2Index.do");
			return mv2;
		}
		
		return mv;
	}

}
