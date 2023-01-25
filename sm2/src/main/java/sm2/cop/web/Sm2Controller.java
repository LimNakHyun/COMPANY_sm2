/**
 * @Class Name : Sm2Controller.java
 * @Description : 사업 매출 정보 controller 클래스
 * @Modification Information
 * @
 * @   수정일                   수정자                                       수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2022.12.20     임낙현                                      최초생성
 *
 * @author 개발5팀 임낙현 사원
 * @since 2022.12.20
 * @version 1.0
 * @see
 */

package sm2.cop.web;

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
public class Sm2Controller {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "sm2Service")
	private Sm2Service sm2Service;
	
	@Resource(name = "sm2MonthService")
	private Sm2MonthService sm2MonthService;
	
	/**
	 * 사업 연도 선택 페이지 이동
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardYearSelect"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2Index.do")
	public ModelAndView openSm2Index(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardYearSelect");
		
		session.removeAttribute("year");
		session.removeAttribute("month");
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 조회
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2Main.do")
	public ModelAndView openSm2Main(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardList");
		
		if(session.getAttribute("month") != "" || session.getAttribute("month") != null) {
			session.removeAttribute("month");
		}
		
		if((session.getAttribute("year") == "" || session.getAttribute("year") == null)
				&& ((commandMap.getMap().get("year") != "") || (commandMap.getMap().get("year") != null))) {
			session.setAttribute("year", commandMap.getMap().get("year"));
		} else if(((session.getAttribute("year") != "") || (session.getAttribute("year") != null))
				&& ((commandMap.getMap().get("year") == "") || (commandMap.getMap().get("year") == null))) {
			commandMap.getMap().put("year", session.getAttribute("year"));
		} else if(((session.getAttribute("year") != "") || (session.getAttribute("year") != null))
				&& ((commandMap.getMap().get("year") != "") || (commandMap.getMap().get("year") != null))) {
			session.removeAttribute("year");
			session.setAttribute("year", commandMap.getMap().get("year"));
		}
		
		List<Map<String, Object>> list = sm2Service.selectBoardList(commandMap.getMap());
		mv.addObject("list", list);
		
		Map<String, Object> amount = sm2Service.selectBoardAmount(commandMap.getMap());
		mv.addObject("amount", amount);
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 상세보기 조회
	 * @param commandMap
	 * @return "/sm2/boardDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2Detail.do")
	public ModelAndView openSm2Detail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardDetail");
		
		Map<String, Object> detail = sm2Service.selectBoardDetail(commandMap.getMap());
		mv.addObject("detail", detail);
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 등록 페이지 이동
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardWrite"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2Insert.do")
	public ModelAndView openSm2Insert(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardInsert");
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 등록
	 * @param commandMap
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/insertSm2Board.do")
	public ModelAndView insertSm2Board(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sm2/openSm2Main.do");
		
		commandMap.getMap().put("year", session.getAttribute("year"));
		sm2Service.insertBoard(commandMap.getMap());
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 삭제
	 * @param commandMap
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/deleteSm2Board.do")
	public ModelAndView deleteSm2Board(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sm2/openSm2Main.do");
		
		sm2Service.deleteBoard(commandMap.getMap());
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 수정 페이지 이동
	 * @param commandMap
	 * @param idx
	 * @return "/sm2/boardUpdate"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2UpdateBoard.do")
	public ModelAndView openSm2UpdateBoard(CommandMap commandMap,
			@ModelAttribute("idx") String idx) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardUpdate");
		
		Map<String, Object> update = sm2Service.selectBoardDetail(commandMap.getMap());
		mv.addObject("update", update);
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 수정
	 * @param commandMap
	 * @return "/sm2/boardDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/updateSm2Board.do")
	public ModelAndView updateSm2Board(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardDetail");
		
		sm2Service.updateBoard(commandMap.getMap());
		
		Map<String, Object> detail = sm2Service.selectBoardDetail(commandMap.getMap());
		mv.addObject("detail", detail);
		
		return mv;
	}
	
	/**
	 * 연간 분기별 사업 매출 현황 조회 페이지 이동
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardSalesOverall"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2SalesOverall.do")
	public ModelAndView openSm2SalesOverall(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardSalesOverall");
		
		commandMap.getMap().put("year", session.getAttribute("year"));
		List<Map<String, Object>> list = sm2MonthService.selectBoardOverall(commandMap.getMap());
		mv.addObject("list", list);
		
		return mv;
	}

}
