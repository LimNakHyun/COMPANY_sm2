/**
 * @Class Name : Sm2MonthController.java
 * @Description : 월별 사업 매출 정보 controller 클래스
 * @Modification Information
 * @
 * @   수정일                   수정자                                       수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2023.01.19     임낙현                                      최초생성
 *
 * @author 개발3팀 임낙현 사원
 * @since 2023.01.19
 * @version 1.0
 * @see
 */

package sm2.month.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import sm2.cmm.cmm.CommandMap;
import sm2.cop.service.Sm2Service;
import sm2.month.service.Sm2MonthService;

@Controller
public class Sm2MonthController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "sm2Service")
	private Sm2Service sm2Service;
	
	@Resource(name = "sm2MonthService")
	private Sm2MonthService sm2MonthService;
	
	/**
	 * 사업 월별 수금액 목록 조회 페이지 이동
	 * @param commandMap
	 * @param month
	 * @param session
	 * @return "/sm2/boardMonth"
	 * @throws Exception
	 */
	@RequestMapping(value = "/openSm2Month.do")
	public ModelAndView openSm2Month(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardMonth");
		
		try {
			if((commandMap.getMap().get("month") != "" || commandMap.getMap().get("month") != null)
					&& (session.getAttribute("month") == "" || session.getAttribute("month") == null)) {
				session.setAttribute("month", commandMap.getMap().get("month"));
			} else if((commandMap.getMap().get("month") == "" || commandMap.getMap().get("month") == null)
					&& (session.getAttribute("month") != "" || session.getAttribute("month") != null)) {
				commandMap.getMap().put("year", session.getAttribute("year"));
				commandMap.getMap().put("month", session.getAttribute("month"));
			} else if(commandMap.getMap().get("month") != session.getAttribute("month")) {
				session.setAttribute("month", commandMap.getMap().get("month"));
			}
			
			List<Map<String, Object>> list = sm2MonthService.selectBoardMonthList(commandMap.getMap());
			mv.addObject("list", list);
			
			Map<String, Object> collectionCashSum = sm2MonthService.selectBoardMonthAmount(commandMap.getMap());
			mv.addObject("collectioncashsum", collectionCashSum);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 등록 페이지 이동
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardMonthWrite"
	 * @throws Exception
	 */
	@RequestMapping(value = "/openSm2MonthInsert.do")
	public ModelAndView openSm2MonthInsert(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardMonthInsert");
		
		try {
			commandMap.getMap().put("year", session.getAttribute("year"));
			commandMap.getMap().put("month", session.getAttribute("month"));
			
			List<Map<String, Object>> selectboxList = sm2Service.selectBoardList(commandMap.getMap());
			mv.addObject("selectboxList", selectboxList);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 등록
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardMonth"
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertSm2BoardMonth.do")
	public ModelAndView insertSm2BoardMonth(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/openSm2Month.do");
		
		try {
			commandMap.getMap().put("year", session.getAttribute("year"));
			commandMap.getMap().put("month", session.getAttribute("month"));
			
			sm2MonthService.insertBoardMonth(commandMap.getMap());
			
			List<Map<String, Object>> list = sm2MonthService.selectBoardMonthList(commandMap.getMap());
			mv.addObject("list", list);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 수금여부 전환
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardMonth"
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateSm2MonthBusinessCondition.do")
	public ModelAndView updateSm2MonthBusinessCondition(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/openSm2Month.do");
		
		try {
			commandMap.getMap().put("year", session.getAttribute("year"));
			commandMap.getMap().put("month", session.getAttribute("month"));
			
			sm2MonthService.updateBoardMonthCondition(commandMap.getMap());
			
			List<Map<String, Object>> list = sm2MonthService.selectBoardMonthList(commandMap.getMap());
			mv.addObject("list", list);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 정보 상세보기 조회
	 * @param commandMap
	 * @return "/sm2/boardMonthDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/openSm2MonthDetail.do")
	public ModelAndView openSm2MonthDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardMonthDetail");
		
		try {
			Map<String, Object> detail = sm2MonthService.selectBoardMonthDetail(commandMap.getMap());
			mv.addObject("detail", detail);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 정보 삭제
	 * @param commandMap
	 * @param month
	 * @param year
	 * @return "/sm2/boardMonth"
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteBoardMonth.do")
	public ModelAndView deleteBoardMonth(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/openSm2Month.do");
		
		try {
			commandMap.getMap().put("year", session.getAttribute("year"));
			commandMap.getMap().put("month", session.getAttribute("month"));
			
			sm2MonthService.deleteBoardMonth(commandMap.getMap());
	
			List<Map<String, Object>> list = sm2MonthService.selectBoardMonthList(commandMap.getMap());
			mv.addObject("list", list);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 정보 수정 페이지 이동
	 * @param commandMap
	 * @param monthidx
	 * @return "/sm2/boardMonth"
	 * @throws Exception
	 */
	@RequestMapping(value = "/openSm2MonthUpdate.do")
	public ModelAndView openSm2MonthUpdate(CommandMap commandMap,
			@ModelAttribute("monthidx") String monthidx) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardMonthUpdate");
		
		try {
			Map<String ,Object> update = sm2MonthService.selectBoardMonthDetail(commandMap.getMap());
			mv.addObject("update", update);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 수정
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardMonthDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateBoardMonth.do")
	public ModelAndView updateBoardMonth(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardMonthDetail");
		
		try {
			sm2MonthService.updateBoardMonth(commandMap.getMap());
			
			Map<String, Object> detail = sm2MonthService.selectBoardMonthDetail(commandMap.getMap());
			mv.addObject("detail", detail);
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		
		return mv;
	}
	
	/**
	 * 사업 월별 사업 위치 변경
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardMonthDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/switchBoardMonth.do")
	public ModelAndView switchBoardMonth(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/openSm2Month.do");
		
		commandMap.getMap().put("year", session.getAttribute("year"));
		commandMap.getMap().put("month", session.getAttribute("month"));
		
		try {
			sm2MonthService.switchBoardMonth(commandMap.getMap());
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		
		return mv;
	}

}
