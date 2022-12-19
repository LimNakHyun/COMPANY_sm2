package sm2.cop.web;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import sm2.cmm.cmm.CommandMap;
import sm2.cop.service.Sm2Service;

@Controller
public class Sm2Controller {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sm2Service")
	private Sm2Service sm2Service;
	
	@RequestMapping(value="/sm2/openSm2List.do")
	public ModelAndView openSm2List(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardList");
		
		List<Map<String, Object>> list = sm2Service.selectBoardList(commandMap);
		mv.addObject("list", list);
		
		return mv;
	}
	
	@RequestMapping(value="/sm2/testMapArgumentResolver.do")
	public ModelAndView testMapArguemntResolver(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("");
		
		if(commandMap.isEmpty() == false) {
			Iterator<Entry<String, Object>> iterator = commandMap.getMap().entrySet().iterator();
			Entry<String, Object> entry = null;
			while(iterator.hasNext()) {
				entry = iterator.next();
				log.debug("key : " + entry.getKey() + ", value : " + entry.getValue());
			}
		}
		return mv;
	}
	
	@RequestMapping(value="/sm2/openSm2Detail.do")
	public ModelAndView openSm2Detail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardDetail");
		
		Map<String, Object> detail = sm2Service.selectBoardDetail(commandMap.getMap());
		mv.addObject("detail", detail);
		
		return mv;
	}
	
	@RequestMapping(value="/sm2/openSm2Write.do")
	public ModelAndView openSm2Write(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/sm2/boardWrite");
		
		return mv;
	}
	
	@RequestMapping(value="/sm2/insertSm2.do")
	public ModelAndView insertSm2(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/sm2/openSm2List.do");
		
		sm2Service.insertBoard(commandMap.getMap());
		
		return mv;
	}

}
