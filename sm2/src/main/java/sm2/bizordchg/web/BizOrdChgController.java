package sm2.bizordchg.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import sm2.bizordchg.service.BizOrdChgService;
import sm2.cmm.cmm.CommandMap;

@Controller
public class BizOrdChgController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "bizOrdChgService")
	private BizOrdChgService bizOrdChgService;
	
	/**
	 * 사업 월별 사업 위치 변경
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardMonthDetail"
	 * @throws Exception
	 * @comment 사업위치를 변경
	 */
	@RequestMapping(value = "/switchBoard.do")
	public ModelAndView switchBoard(
			CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else {
			mv = new ModelAndView("redirect:/openSm2Main.do");
			
			commandMap.getMap().put("year", session.getAttribute("year"));
			
			try {
				bizOrdChgService.switchBoard(commandMap.getMap());
			} catch(Exception e) {
				log.info(e.getMessage());
			}
		}
		
		return mv;
	}
	
	/**
	 * 사업 순서 변경 버튼 토글
	 * @param session
	 * @return 
	 * @throws Exception
	 * @comment 사업위치변경기능을 켜고 끔
	 */
	@RequestMapping(value = "/BizOrdChgTgl.do")
	public ModelAndView BizOrdChgTgl(
			HttpSession session) throws Exception {
		ModelAndView mv = null;
		String login = (String)session.getAttribute("login");
		String bizOrdChgcondition = (String)session.getAttribute("BizOrdChg");
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else if(login.equals("on")) {
//			mv = new ModelAndView("/sm2/boardList");
			mv = new ModelAndView("redirect:/openSm2Main.do");
			try {
				if(bizOrdChgcondition.equals("N")) {
					session.setAttribute("BizOrdChg", "Y");
				} else if(bizOrdChgcondition.equals("Y")) {
					session.setAttribute("BizOrdChg", "N");
				}
			} catch(Exception e) {
				log.info(e.getMessage());
				ModelAndView mv2 = new ModelAndView("redirect:/openSm2Index.do");
				return mv2;
			}
		}
		return mv;
	}
	
	/**
	 * 월별 사업 순서 변경 버튼 토글
	 * @param session
	 * @return 
	 * @throws Exception
	 * @comment 월별 사업위치변경기능을 켜고 끔
	 */
	@RequestMapping(value = "/monthBizOrdChgTgl.do")
	public ModelAndView monthBizOrdChgTgl(
			HttpSession session) throws Exception {
		ModelAndView mv = null;
		String login = (String)session.getAttribute("login");
		String monthBizOrdChgcondition = (String)session.getAttribute("monthBizOrdChg");
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else if(login.equals("on")) {
			mv = new ModelAndView("redirect:/openSm2Month.do");
			try {
				if(monthBizOrdChgcondition.equals("N")) {
					session.setAttribute("monthBizOrdChg", "Y");
				} else if(monthBizOrdChgcondition.equals("Y")) {
					session.setAttribute("monthBizOrdChg", "N");
				}
			} catch(Exception e) {
				log.info(e.getMessage());
				ModelAndView mv2 = new ModelAndView("redirect:/openSm2Index.do");
				return mv2;
			}
		}
		return mv;
	}
}
