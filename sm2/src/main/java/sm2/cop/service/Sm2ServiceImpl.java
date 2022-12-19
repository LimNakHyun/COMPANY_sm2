package sm2.cop.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import sm2.cmm.cmm.CommandMap;
import sm2.cop.dao.Sm2DAO;

@Service("sm2Service")
public class Sm2ServiceImpl implements Sm2Service {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sm2DAO")
	private Sm2DAO sm2DAO;

	@Override
	public List<Map<String, Object>> selectBoardList(CommandMap map) throws Exception {
		return sm2DAO.selectBoardList(map);
	}

	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = sm2DAO.selectBoardDetail(map);
		return resultMap;
	}

	@Override
	public void insertBoard(Map<String, Object> map) throws Exception {
		
		String strstartterm = (String)map.get("strstartterm");
		String strendterm = (String)map.get("strendterm");
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date startterm = formatter.parse(strstartterm);
		Date endterm = formatter.parse(strendterm);
		
		map.put("startterm", startterm);
		map.put("endterm", endterm);
		
		double minusTotalBusinessAmount = Double.parseDouble((String)map.get("plustotalbusinessamount")) / 1.1;
		double salesAmount = minusTotalBusinessAmount * Double.parseDouble((String)map.get("ratio")) / 100;
		
		map.put("minustotalbusinessamount", minusTotalBusinessAmount);
		map.put("salesamount", salesAmount);
		
		map.put("collectioncompletedamount", 0);
		map.put("totalcollectionremainingamount", salesAmount);
		
		System.out.println("추가될 해시맵: " + map);
		
		sm2DAO.insertBoard(map);
	}

}
