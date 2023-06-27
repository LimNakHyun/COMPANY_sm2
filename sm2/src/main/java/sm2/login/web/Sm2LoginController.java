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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import sm2.cmm.cmm.CommandMap;
import sm2.login.service.Sm2LoginService;
import sm2.login.vo.LoginVO;

@Controller
public class Sm2LoginController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "sm2LoginService")
	private Sm2LoginService sm2LoginService;
	
	
	/**
	 * 로그인 직후 표시 페이지
	 * @param loginVO
	 * @param session
	 * @return "/sm2/boardList"
	 * @throws Exception
	 * @comment 여기 들어온 ID와 PW는 검증이 끝난 값들임
	 */
	@ResponseBody
	@RequestMapping(value = "/openSm2MainLogin.do")
	public ModelAndView openSm2MainLogin(
			@ModelAttribute LoginVO loginVO,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/openSm2Main.do");
		try {
			session.setAttribute("year", "2023");
			session.setAttribute("login", "on");
			Map<String, Object> role = sm2LoginService.selectBoardUserRole(loginVO);
			session.setAttribute("role", role.get("authority"));
			session.setAttribute("BizOrdChg", "N");			// 사업 순서 변경을 불가능하게
			session.setAttribute("monthBizOrdChg", "N");	// 월별 사업 순서 변경을 불가능하게
		} catch(Exception e) {
			log.info(e.getMessage());
			ModelAndView mv2 = new ModelAndView("redirect:/openSm2Index.do");
			return mv2;
		}
		
		return mv;
		
	}
	
	/**
	 * 로그인 계정 체크 ajax
	 * @param loginVO
	 * @param session
	 * @return 
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/openSm2LoginAjax.do")
	public ModelAndView openSm2LoginAjax(
			@ModelAttribute LoginVO loginVO,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		String msg = "";
		try {
			Map<String, Object> userID = sm2LoginService.selectBoardUserID(loginVO);
			if(userID != null) {	// 유저 ID가 테이블에 존재할때
				String ID = (String)userID.get("userid");
				Map<String, Object> userPW = sm2LoginService.selectBoardUserPW(loginVO);
				if(userPW != null) {	// 유저 ID에 맞는 유저 PW가 테이블에 존재할때
					String PW = (String)userPW.get("userpw");
					msg = "success";
					mv.addObject("ID", ID);
					mv.addObject("PW", PW);
				} else {	// 유저 ID에 맞는 유저 PW가 테이블에 없을때
					msg = "pwError";
				}
			} else {	// 유저 ID가 테이블에 없을때
				msg = "idError";
			}
			mv.addObject("msg", msg);
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
