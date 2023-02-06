/**
 * @Class Name : Sm2ServiceImpl.java
 * @Description : 사업 매출 정보 service implement 클래스
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

package sm2.cop.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import sm2.cop.dao.Sm2DAO;

@Service("sm2Service")
public class Sm2ServiceImpl implements Sm2Service {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sm2DAO")
	
	private Sm2DAO sm2DAO;

	/**
	 * 사업 매출정보 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
		return sm2DAO.selectBoardList(map);
	}

	/**
	 * 사업 매출정보 상세보기 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = sm2DAO.selectBoardDetail(map);
		return resultMap;
	}

	/**
	 * 사업 매출정보 등록
	 * @param map
	 * @throws Exception
	 */
	@Override
	public void insertBoard(Map<String, Object> map) throws Exception {
		
		String strstartterm = (String)map.get("strstartterm");
		String strendterm = (String)map.get("strendterm");
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date startterm = formatter.parse(strstartterm);
		Date endterm = formatter.parse(strendterm);
		
		map.put("startterm", startterm);
		map.put("endterm", endterm);
		
		double plustotalbusinessamount = Double.parseDouble(((String)map.get("plustotalbusinessamount")).replace(",", ""));
		double minusTotalBusinessAmount = plustotalbusinessamount / 1.1;
		double salesAmount = minusTotalBusinessAmount * Double.parseDouble((String)map.get("ratio")) / 100;
		
		map.put("plustotalbusinessamount", plustotalbusinessamount);
		map.put("minustotalbusinessamount", minusTotalBusinessAmount);
		map.put("salesamount", salesAmount);
		
		map.put("collectioncompletedamount", 0);
		map.put("totalcollectionremainingamount", salesAmount);
		
		sm2DAO.insertBoard(map);
	}

	/**
	 * 사업 매출정보 삭제
	 * @param map
	 * @throws Exception
	 */
	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		sm2DAO.deleteRelatedBoardMonth(map);
		sm2DAO.deleteBoard(map);
	}

	/**
	 * 사업 매출정보 수정
	 * @param map
	 * @throws Exception
	 */
	@Override
	public void updateBoard(Map<String, Object> map) throws Exception {
		
		String strstartterm = (String)map.get("strstartterm");
		String strendterm = (String)map.get("strendterm");
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date startterm = formatter.parse(strstartterm);
		Date endterm = formatter.parse(strendterm);
		
		map.put("startterm", startterm);
		map.put("endterm", endterm);
		
		double plustotalbusinessamount = Double.parseDouble(((String)map.get("plustotalbusinessamount")).replace(",", ""));
		double minusTotalBusinessAmount = plustotalbusinessamount / 1.1;
		double salesAmount = minusTotalBusinessAmount * Double.parseDouble((String)map.get("ratio")) / 100;
		
		map.put("plustotalbusinessamount", plustotalbusinessamount);
		map.put("minustotalbusinessamount", minusTotalBusinessAmount);
		map.put("salesamount", salesAmount);
		
		map.put("collectioncompletedamount", 0);
		map.put("totalcollectionremainingamount", salesAmount);
		
		sm2DAO.updateRelatedBoardMonth(map);
		sm2DAO.updateBoard(map);
	}

	/**
	 * 사업금액 전체 합계 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectBoardAmount(Map<String, Object> map) throws Exception {
		return sm2DAO.selectBoardAmount(map);
	}
	
	/**
	 * 매출 총괄현황 사업 순서변경
	 * @param commandMap
	 * @throws Exception
	 */
	@Override
	public void changeSm2Board(Map<String, Object> map) throws Exception {
		sm2DAO.changeSm2Board01(map);
		sm2DAO.changeSm2Board02(map);
		sm2DAO.changeSm2Board03(map);
	}

}
