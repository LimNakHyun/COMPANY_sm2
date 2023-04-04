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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
	@RequestMapping(value = "/openSm2Index.do")
	public ModelAndView openSm2Index(CommandMap commandMap,
//			@SessionAttribute(name = "login", required = false) String login,
			HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
//		if((session.getAttribute("login") == null) && ((String)session.getAttribute("login")).equals("")) {
//		System.out.println("세션값 출력: " + commandMap.getMap().get("login"));
//		System.out.println("세션값 출력: " + login);
//		if(commandMap.getMap().get("login") == null) {
		if(login == null || login.equals("")) {
			mv = new ModelAndView("/sm2/boardLogin");
		} else {
			mv = new ModelAndView("/sm2/boardYearSelect");
		}
		
		try {
			session.removeAttribute("year");
			session.removeAttribute("month");
		} catch(Exception e) {
			log.info(e.getMessage());
		}
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 조회
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardList"
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/openSm2Main.do")
	public ModelAndView openSm2Main(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else {
			mv = new ModelAndView("/sm2/boardList");
			
			try {
				if(session.getAttribute("month") != "" || session.getAttribute("month") != null) {
					session.removeAttribute("month");
				}
				
				if((session.getAttribute("year") == "" || session.getAttribute("year") == null)
						&& ((commandMap.getMap().get("year") != "") || (commandMap.getMap().get("year") != null))) {
					session.setAttribute("year", commandMap.getMap().get("year"));
				}
				else if(((session.getAttribute("year") != "") || (session.getAttribute("year") != null))
						&& ((commandMap.getMap().get("year") == "") || (commandMap.getMap().get("year") == null))) {
					commandMap.getMap().put("year", session.getAttribute("year"));
				}
				else if(((session.getAttribute("year") != "") || (session.getAttribute("year") != null))
						&& ((commandMap.getMap().get("year") != "") || (commandMap.getMap().get("year") != null))) {
					session.removeAttribute("year");
					session.setAttribute("year", commandMap.getMap().get("year"));
				}
				
//				List<Map<String, Object>> list = sm2Service.selectBoardList(commandMap.getMap());
//				mv.addObject("list", list);
//				
//				Map<String, Object> amount = sm2Service.selectBoardAmount(commandMap.getMap());
//				mv.addObject("amount", amount);
			} catch(Exception e) {
				log.info(e.getMessage());
				ModelAndView mv2 = new ModelAndView("redirect:/openSm2Main.do");
				return mv2;
			}
			
		}
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 조회 ajax
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardList"
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/openSm2MainAjax.do")
	public ModelAndView openSm2MainAjax(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		
		try {
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
		} catch(Exception e) {
			log.info(e.getMessage());
			ModelAndView mv2 = new ModelAndView("redirect:/openSm2Main.do");
			return mv2;
		}
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 상세보기 조회
	 * @param commandMap
	 * @return "/sm2/boardDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/openSm2Detail.do")
	public ModelAndView openSm2Detail(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
		if(!(commandMap.getMap().get("idx") instanceof String)) {
			String[] idxArr = (String[]) commandMap.get("idx");
		    String idx = idxArr[0];
		    commandMap.getMap().put("idx", idx);
		}
		
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else {
			mv = new ModelAndView("/sm2/boardDetail");
			
			try {
				Map<String, Object> detail = sm2Service.selectBoardDetail(commandMap.getMap());
//				List<Map<String, Object>> monthDetails = sm2MonthService.selectBoardDetailMonthDetail(commandMap.getMap());
				mv.addObject("detail", detail);
//				mv.addObject("monthDetails", monthDetails);
			} catch(Exception e) {
				log.info(e.getMessage());
			}
			
		}
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 등록 페이지 이동
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardWrite"
	 * @throws Exception
	 */
	@RequestMapping(value = "/openSm2Insert.do")
	public ModelAndView openSm2Insert(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else {
			mv = new ModelAndView("/sm2/boardInsert");
		}
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 등록
	 * @param commandMap
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertSm2Board.do")
	public ModelAndView insertSm2Board(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else {
			mv = new ModelAndView("redirect:/openSm2Main.do");
			
			try {
				commandMap.getMap().put("year", session.getAttribute("year"));
				sm2Service.insertBoard(commandMap.getMap());
			} catch(Exception e) {
				log.info(e.getMessage());
			}
		}
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 삭제
	 * @param commandMap
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteSm2Board.do")
	public ModelAndView deleteSm2Board(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else {
			mv = new ModelAndView("redirect:/openSm2Main.do");
			
			try {
				sm2Service.deleteBoard(commandMap.getMap());
			} catch(Exception e) {
				log.info(e.getMessage());
			}
		}
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 수정 페이지 이동
	 * @param commandMap
	 * @param idx
	 * @return "/sm2/boardUpdate"
	 * @throws Exception
	 */
	@RequestMapping(value = "/openSm2UpdateBoard.do")
	public ModelAndView openSm2UpdateBoard(CommandMap commandMap,
			@ModelAttribute("idx") String idx, HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else {
			mv = new ModelAndView("/sm2/boardUpdate");
			
			try {
				Map<String, Object> update = sm2Service.selectBoardDetail(commandMap.getMap());
				mv.addObject("update", update);
			} catch(Exception e) {
				log.info(e.getMessage());
			}
		}
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 수정
	 * @param commandMap
	 * @return "/sm2/boardDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateSm2Board.do")
	public ModelAndView updateSm2Board(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else {
			mv = new ModelAndView("/sm2/boardDetail");
			
			try {
				sm2Service.updateBoard(commandMap.getMap());
				
				Map<String, Object> detail = sm2Service.selectBoardDetail(commandMap.getMap());
				List<Map<String, Object>> monthDetails = sm2MonthService.selectBoardDetailMonthDetail(commandMap.getMap());
				mv.addObject("detail", detail);
				mv.addObject("monthDetails", monthDetails);
			} catch(Exception e) {
				log.info(e.getMessage());
			}
		}
		
		return mv;
	}
	
	/**
	 * 연간 분기별 사업 매출 현황 조회 페이지 이동
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardSalesOverall"
	 * @throws Exception
	 */
	@RequestMapping(value = "/openSm2SalesOverall.do")
	public ModelAndView openSm2SalesOverall(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else {
			mv = new ModelAndView("/sm2/boardSalesOverall");
			
			try {
				commandMap.getMap().put("year", session.getAttribute("year"));
				
				List<Map<String, Object>> list = sm2MonthService.selectBoardOverall(commandMap.getMap());
				mv.addObject("list", list);
				
				List<Map<String, Object>> expectList = sm2MonthService.selectBoardExpectOverall(commandMap.getMap());
				mv.addObject("expectList", expectList);
			} catch(Exception e) {
				log.info(e.getMessage());
			}
		}
		
		return mv;
	}
	
	/**
	 * 매출 총괄현황 동적 사업 검색
	 * @param commandMap
	 * @return /sm2/boardList
	 * @throws Exception
	 */
	@RequestMapping(value = "/searchbusinessSm2Board.do")
	public ModelAndView searchbusinessSm2Board(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else {
			mv = new ModelAndView("redirect:/openSm2Main.do");
			
			try {
				mv.addObject("searchword", commandMap.getMap().get("searchword"));
			} catch(Exception e) {
				log.info(e.getMessage());
			}
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
	@RequestMapping(value = "/switchBoard.do")
	public ModelAndView switchBoard(CommandMap commandMap,
			HttpSession session) throws Exception {
		ModelAndView mv;
		
		String login = (String) session.getAttribute("login");
		
		if(login == null || login.equals("")) {
			mv = new ModelAndView("redirect:/openSm2Index.do");
		} else {
			mv = new ModelAndView("redirect:/openSm2Main.do");
			
			commandMap.getMap().put("year", session.getAttribute("year"));
			
			try {
				sm2Service.switchBoard(commandMap.getMap());
			} catch(Exception e) {
				log.info(e.getMessage());
			}
		}
		
		return mv;
	}
	
	/**
	 * 사업 상세보기에서 사업 월별 수금액 수금여부 전환
	 * @param commandMap
	 * @param session
	 * @return "/sm2/boardMonthDetail"
	 * @throws Exception
	 */
//	@RequestMapping(value = "/updateSm2DetailMonthBusinessCondition.do")
//	public ModelAndView updateSm2DetailMonthBusinessCondition(CommandMap commandMap,
//			HttpSession session) throws Exception {
//		ModelAndView mv;
//		
//		String login = (String) session.getAttribute("login");
		
//		String[] chkValues = {"monthidx", "idx", "collectioncash", "monthbusinesscondition"};
//		
//		for(String chkValue : chkValues) {
//			if(!(commandMap.getMap().get(chkValue) instanceof String)) {
//				String[] tempArr = (String[]) commandMap.get(chkValue);
//			    String tempVal = tempArr[0];
//			    commandMap.getMap().put(chkValue, tempVal);
//			}
//		}
		
//		if(login == null || login.equals("")) {
//			mv = new ModelAndView("redirect:/openSm2Index.do");
//		} else {
//			mv = new ModelAndView("redirect:/openSm2Detail.do");
//			System.out.println(commandMap.getMap());
//			
//			try {
//				commandMap.getMap().put("year", session.getAttribute("year"));
//				commandMap.getMap().put("month", session.getAttribute("month"));
//				
//				sm2MonthService.updateBoardMonthCondition(commandMap.getMap());
//				
//				List<Map<String, Object>> list = sm2MonthService.selectBoardMonthList(commandMap.getMap());
//				mv.addObject("list", list);
//				mv.addObject("idx", commandMap.getMap().get("idx"));
//			} catch(Exception e) {
//				log.info(e.getMessage());
//			}
//		}
//		
//		return mv;
//	}
	
	/**
	 * 사업 상세보기 관련 사업 조회
	 * @param commandMap
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getBoardDetailRelatedBusiness.do")
	public String getBoardDetailRelatedBusiness(ModelMap model,
			CommandMap commandMap,
			HttpSession session) throws Exception {
		
		String login = (String) session.getAttribute("login");
		String returnPage;
		
		if(login == null || login.equals("")) {
			returnPage = "/sm2/boardYearSelect";
		} else {
			returnPage = "/import/boardDetailRelatedBusiness";
			
			try {
				List<Map<String, Object>> monthDetails = sm2Service.getBoardDetailRelatedBusiness(commandMap.getMap());
				Map<String, Object> expectcollectioncash = sm2Service.getBoardDetailRelatedBusinessExpectcollectioncash(commandMap.getMap());
				Map<String, Object> realcollectioncash = sm2Service.getBoardDetailRelatedBusinessRealcollectioncash(commandMap.getMap());
				
				model.addAttribute("monthDetails", monthDetails);
				model.addAttribute("expectcollectioncash", expectcollectioncash);
				model.addAttribute("realcollectioncash", realcollectioncash);
				model.addAttribute("result", "success");
			} catch(Exception e) {
				log.info(e.getMessage());
				
				model.addAttribute("result", "fail");
			}
		}
		
		return returnPage;
	}

}
