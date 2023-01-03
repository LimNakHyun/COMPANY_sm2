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
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
		
		double minusTotalBusinessAmount = Double.parseDouble((String)map.get("plustotalbusinessamount")) / 1.1;
		double salesAmount = minusTotalBusinessAmount * Double.parseDouble((String)map.get("ratio")) / 100;
		
		map.put("minustotalbusinessamount", minusTotalBusinessAmount);
		map.put("salesamount", salesAmount);
		
		map.put("collectioncompletedamount", 0);
		map.put("totalcollectionremainingamount", salesAmount);
		
		sm2DAO.insertBoard(map);
	}
	
	/**
	 * 사업 월별 수금액 목록 페이지 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectBoardMonthList(Map<String, Object> map) throws Exception {
		return sm2DAO.selectBoardMonthList(map);
	}

	/**
	 * 사업 월별 수금액 등록
	 * @param map
	 * @throws Exception
	 */
	@Override
	public void insertBoardMonth(Map<String, Object> map) throws Exception {
		int idx = (int)sm2DAO.pickIdx(map).get("idx");
		
		map.put("idx", idx);
		
		sm2DAO.insertBoardMonth(map);
		
	}

	/**
	 * 사업 월별 수금액 수금여부 전환
	 * @param map
	 * @throws Exception
	 */
	@Override
	public void updateBoardMonth(Map<String, Object> map) throws Exception {
		long collectionCash = Long.parseLong((String)map.get("collectioncash"));
		
		Map<String, Object> collectionInformation = sm2DAO.collectionInformation(map);
		
		long totalCollectionRemainingAmount = (long)collectionInformation.get("totalcollectionremainingamount");
		long collectionCompletedAmount = (long)collectionInformation.get("collectioncompletedamount");
		
		boolean monthBusinessCondition = Boolean.parseBoolean((String)map.get("monthbusinesscondition"));
		
		if(!monthBusinessCondition) {
			totalCollectionRemainingAmount = totalCollectionRemainingAmount - collectionCash;
			collectionCompletedAmount = collectionCompletedAmount + collectionCash;
			monthBusinessCondition = true;
		} else {
			totalCollectionRemainingAmount = totalCollectionRemainingAmount + collectionCash;
			collectionCompletedAmount = collectionCompletedAmount - collectionCash;
			monthBusinessCondition = false;
		}
		
		map.put("totalcollectionremainingamount", totalCollectionRemainingAmount);
		map.put("collectioncompletedamount", collectionCompletedAmount);
		map.put("monthbusinesscondition", monthBusinessCondition);
		
		if(totalCollectionRemainingAmount == 0) {
			map.put("businesscondition", true);
		} else {
			map.put("businesscondition", false);
		}
		
		sm2DAO.updateBoardMonthCondition(map);
		sm2DAO.updateBoardMonth(map);
		
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
	 * 월별 사업금액 합계 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectBoardMonthAmount(Map<String, Object> map) throws Exception {
		return sm2DAO.selectBoardMonthAmount(map);
	}

	
	/**
	 * 사업 매출 현황 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectBoardOverall(Map<String, Object> map) throws Exception {
		
		String year = (String) map.get("year");
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		long quarterAmount = 0;
		
		for(int i = 0; i < 12; i++) {
			Map<String, Object> tempMap = new HashMap<>();
			tempMap.put("year", year);
			tempMap.put("month", i + 1);
			
			Map<String, Object> temp = sm2DAO.selectBoardMonthAmount(tempMap);
			tempMap.put("monthstr", (i + 1) + "월");
			quarterAmount += Long.parseLong(String.valueOf(temp.get("collectioncashsum")));
			
			tempMap.put("amount", temp.get("collectioncashsum"));
			
			list.add(tempMap);
			
			if((i + 1) % 3 == 0) {
				Map<String, Object> tempQuarterMap = new HashMap<>();
				tempQuarterMap.put("quarteramount", quarterAmount);
				tempQuarterMap.put("quarter", ((i + 1) / 3) + "/4 분기");
				list.add(tempQuarterMap);
			}
			
		}
		
		return list;
	}

}
