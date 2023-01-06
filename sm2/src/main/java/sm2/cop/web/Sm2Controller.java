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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import sm2.cmm.cmm.CommandMap;
import sm2.cop.service.Sm2Service;

@Controller
public class Sm2Controller {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "sm2Service")
	private Sm2Service sm2Service;
	
	/**
	 * 사업 연도 선택 페이지 이동
	 * @param commandMap
	 * @return "/sm2/boardYearSelect"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2Index.do")
	public ModelAndView openSm2Index(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardYearSelect");
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 조회
	 * @param commandMap
	 * @param year
	 * @return "/sm2/boardList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2List.do")
	public ModelAndView openSm2List(CommandMap commandMap,
			@ModelAttribute("year") String year) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardList");
		
		List<Map<String, Object>> list = sm2Service.selectBoardList(commandMap.getMap());
		mv.addObject("list", list);
		
		Map<String, Object> amount = sm2Service.selectBoardAmount(commandMap.getMap());
		mv.addObject("amount", amount);
		
		Map<String, String> date = new HashMap<>();
		date.put("year", year);
		mv.addObject("date", date);
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 상세보기 조회
	 * @param commandMap
	 * @param year
	 * @return "/sm2/boardDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2Detail.do")
	public ModelAndView openSm2Detail(CommandMap commandMap,
			@ModelAttribute("year") String year) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardDetail");
		
		Map<String, Object> detail = sm2Service.selectBoardDetail(commandMap.getMap());
		mv.addObject("detail", detail);
		
		Map<String, String> date = new HashMap<>();
		date.put("year", year);
		mv.addObject("date", date);
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 등록 페이지 이동
	 * @param commandMap
	 * @param year
	 * @return "/sm2/boardWrite"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2Write.do")
	public ModelAndView openSm2Write(CommandMap commandMap,
			@ModelAttribute("year") String year) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardWrite");
		
		Map<String, String> date = new HashMap<>();
		date.put("year", year);
		mv.addObject("date", date);
		
		return mv;
	}
	
	/**
	 * 사업 매출정보 등록
	 * @param commandMap
	 * @param year
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/insertSm2.do")
	public ModelAndView insertSm2(CommandMap commandMap,
			@ModelAttribute("year") String year) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sm2/openSm2List.do");
		
		sm2Service.insertBoard(commandMap.getMap());
		
		Map<String, String> date = new HashMap<>();
		date.put("year", year);
		mv.addObject("date", date);
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 목록 조회 페이지 이동
	 * @param commandMap
	 * @param month
	 * @param update
	 * @return "/sm2/boardMonth"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2Month.do")
	public ModelAndView openSm2Month(CommandMap commandMap,
			@ModelAttribute("month") String month,
			@ModelAttribute("year") String year) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardMonth");
		
		List<Map<String, Object>> list = sm2Service.selectBoardMonthList(commandMap.getMap());
		mv.addObject("list", list);
		
		Map<String, Object> collectionCashSum = sm2Service.selectBoardMonthAmount(commandMap.getMap());
		mv.addObject("collectioncashsum", collectionCashSum);
		
		Map<String, String> date = new HashMap<>();
		date.put("month", month);
		date.put("year", year);
		mv.addObject("date", date);
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 등록 페이지 이동
	 * @param commandMap
	 * @param month
	 * @param year
	 * @return "/sm2/boardMonthWrite"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2MonthWrite.do")
	public ModelAndView openSm2MonthWrite(CommandMap commandMap,
			@ModelAttribute("month") String month,
			@ModelAttribute("year") String year) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardMonthWrite");
		
		List<Map<String, Object>> selectboxList = sm2Service.selectBoardList(commandMap.getMap());
		mv.addObject("selectboxList", selectboxList);
		
		Map<String, String> date = new HashMap<>();
		date.put("month", month);
		date.put("year", year);
		mv.addObject("date", date);
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 등록
	 * @param commandMap
	 * @param month
	 * @param year
	 * @return "/sm2/boardMonth"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/insertSm2Month.do")
	public ModelAndView insertSm2Month(CommandMap commandMap,
			@ModelAttribute("month") String month,
			@ModelAttribute("year") String year) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sm2/openSm2Month.do");
		
		sm2Service.insertBoardMonth(commandMap.getMap());
		
		List<Map<String, Object>> list = sm2Service.selectBoardMonthList(commandMap.getMap());
		mv.addObject("list", list);
		
		Map<String, String> date = new HashMap<>();
		date.put("month", month);
		date.put("year", year);
		mv.addObject("date", date);
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 수금여부 전환
	 * @param commandMap
	 * @param month
	 * @param year
	 * @return "/sm2/boardMonth"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/updateSm2Month.do")
	public ModelAndView updateSm2Month(CommandMap commandMap,
			@ModelAttribute("month") String month,
			@ModelAttribute("year") String year) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sm2/openSm2Month.do");
		
		sm2Service.updateBoardMonth(commandMap.getMap());
		
		List<Map<String, Object>> list = sm2Service.selectBoardMonthList(commandMap.getMap());
		mv.addObject("list", list);
		
		Map<String, String> date = new HashMap<>();
		date.put("month", month);
		date.put("year", year);
		mv.addObject("date", date);
		
		return mv;
	}
	
	/**
	 * 연간 분기별 사업 매출 현황 조회 페이지 이동
	 * @param commandMap
	 * @param year
	 * @return "/sm2/boardSalesOverall"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2SalesOverall.do")
	public ModelAndView openSm2SalesOverall(CommandMap commandMap,
			@ModelAttribute("year") String year) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardSalesOverall");
		
		List<Map<String, Object>> list = sm2Service.selectBoardOverall(commandMap.getMap());
		mv.addObject("list", list);
		
		Map<String, String> date = new HashMap<>();
		date.put("year", year);
		mv.addObject("date", date);
		
		return mv;
	}
	
	/**
	 * 사업 월별 수금액 정보 상세보기 조회
	 * @param commandMap
	 * @param month
	 * @param year
	 * @return "/sm2/boardMonthDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sm2/openSm2MonthDetail.do")
	public ModelAndView openSm2MonthDetail(CommandMap commandMap,
			@ModelAttribute("month") String month,
			@ModelAttribute("year") String year) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardMonthDetail");
		
		Map<String, Object> detail = sm2Service.selectBoardMonthDetail(commandMap.getMap());
		mv.addObject("detail", detail);
		
		Map<String, String> date = new HashMap<>();
		date.put("month", month);
		date.put("year", year);
		mv.addObject("date", date);
		
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
	@RequestMapping(value = "/sm2/deleteMonthBoard.do")
	public ModelAndView deleteMonthBoard(CommandMap commandMap,
			@ModelAttribute("month") String month,
			@ModelAttribute("year") String year) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sm2/openSm2Month.do");
		
		sm2Service.deleteMonthBoard(commandMap.getMap());
		
		Map<String, Object> date = new HashMap<>();
		date.put("month", month);
		date.put("year", year);
		mv.addObject("date", date);

		List<Map<String, Object>> list = sm2Service.selectBoardMonthList(commandMap.getMap());
		mv.addObject("list", list);
		
		return mv;
	}

}
