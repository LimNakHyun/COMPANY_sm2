/**
 * @Class Name : Sm2MonthServiceImpl.java
 * @Description : 월별 사업 매출 정보 service implement 클래스
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

package sm2.month.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import sm2.cop.dao.Sm2DAO;
import sm2.month.dao.Sm2MonthDAO;

@Service("sm2MonthService")
public class Sm2MonthServiceImpl implements Sm2MonthService {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sm2DAO")
	private Sm2DAO sm2DAO;
	
	@Resource(name = "sm2MonthDAO")
	private Sm2MonthDAO sm2MonthDAO;

	/**
	 * 사업 월별 수금액 목록 페이지 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectBoardMonthList(Map<String, Object> map) throws Exception {
		return sm2MonthDAO.selectBoardMonthList(map);
	}

	/**
	 * 월별 사업금액 합계 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectBoardMonthAmount(Map<String, Object> map) throws Exception {
		Map<String, Object> monthAmount = sm2MonthDAO.selectBoardMonthAmount(map);
		Map<String, Object> temp = sm2MonthDAO.selectBoardMonthExpectedAmount(map);
		monthAmount.put("expectedcollectioncashsum", temp.get("expectedcollectioncashsum"));
		return monthAmount;
	}

	/**
	 * 사업 월별 수금액 등록
	 * @param map
	 * @throws Exception
	 */
	@Override
	public void insertBoardMonth(Map<String, Object> map) throws Exception {
		int idx = (int)sm2MonthDAO.pickIdx(map).get("idx");
		map.put("idx", idx);
		
		double collectioncash = Double.parseDouble(((String)map.get("dCollectioncash")).replace(",", ""));
		map.put("collectioncash", collectioncash);
		
		sm2MonthDAO.insertBoardMonth(map);
		
	}

	/**
	 * 사업 월별 수금액 수금여부 전환
	 * @param map
	 * @throws Exception
	 */
	@Override
	public void updateBoardMonthCondition(Map<String, Object> map) throws Exception {
		long collectionCash = Long.parseLong((String)map.get("collectioncash"));
		
		Map<String, Object> collectionInformation = sm2MonthDAO.collectionInformation(map);
		
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
		
		sm2MonthDAO.updateBoardMonthCondition(map);
		sm2MonthDAO.updateBoardMonthBusinessCollection(map);
		
	}
	
	/**
	 * 사업 실매출 현황 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectBoardOverall(Map<String, Object> map) throws Exception {
		
		String year = (String) map.get("year");
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		long quarterAmount = 0;
		long allAmount = 0;
		
		for(int i = 0; i < 12; i++) {
			Map<String, Object> tempMap = new HashMap<>();
			tempMap.put("year", year);
			tempMap.put("month", i + 1);
			
			Map<String, Object> temp = sm2MonthDAO.selectBoardMonthAmount(tempMap);
			tempMap.put("monthstr", (i + 1) + "월");
			quarterAmount += Long.parseLong(String.valueOf(temp.get("collectioncashsum")));
			allAmount += Long.parseLong(String.valueOf(temp.get("collectioncashsum")));
			
			tempMap.put("amount", temp.get("collectioncashsum"));
			
			list.add(tempMap);
			
			if((i + 1) % 3 == 0) {
				Map<String, Object> tempQuarterMap = new HashMap<>();
				tempQuarterMap.put("quarteramount", quarterAmount);
				tempQuarterMap.put("quarter", ((i + 1) / 3) + "/4 분기");
				list.add(tempQuarterMap);
				quarterAmount = 0;
			}
		}
		Map<String, Object> tempAllAmount = new HashMap<>();
		tempAllAmount.put("allamount", allAmount);
		tempAllAmount.put("all","실 매출액");
		list.add(tempAllAmount);
		
		return list;
	}

	/**
	 * 사업 예상매출 현황 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectBoardExpectOverall(Map<String, Object> map) throws Exception {
		String year = (String) map.get("year");
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		long quarterAmount = 0;
		long allAmount = 0;
		
		for(int i = 0; i < 12; i++) {
			Map<String, Object> tempMap = new HashMap<>();
			tempMap.put("year", year);
			tempMap.put("month", i + 1);
			
			Map<String, Object> temp = sm2MonthDAO.selectBoardMonthExpectedAmount(tempMap);
			tempMap.put("monthstr", (i + 1) + "월");
			quarterAmount += Long.parseLong(String.valueOf(temp.get("expectedcollectioncashsum")));
			allAmount += Long.parseLong(String.valueOf(temp.get("expectedcollectioncashsum")));
			
			tempMap.put("amount", temp.get("expectedcollectioncashsum"));
			
			list.add(tempMap);
			
			if((i + 1) % 3 == 0) {
				Map<String, Object> tempQuarterMap = new HashMap<>();
				tempQuarterMap.put("quarteramount", quarterAmount);
				tempQuarterMap.put("quarter", ((i + 1) / 3) + "/4 분기");
				list.add(tempQuarterMap);
				quarterAmount = 0;
			}
		}
		Map<String, Object> tempAllAmount = new HashMap<>();
		tempAllAmount.put("allamount", allAmount);
		tempAllAmount.put("all","예상 매출액");
		list.add(tempAllAmount);
		
		return list;
	}

	/**
	 * 사업 월별 수금액 정보 상세보기 조회
	 * @param map
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectBoardMonthDetail(Map<String, Object> map) throws Exception {
		return sm2MonthDAO.selectBoardMonthDetail(map);
	}

	/**
	 * 사업 월별 수금액 정보 삭제
	 * @param map
	 * @throws Exception
	 */
	@Override
	public void deleteBoardMonth(Map<String, Object> map) throws Exception {
		boolean monthBusinessCondition = (boolean)sm2MonthDAO.pickMonthBusinessCondition(map).get("monthbusinesscondition");
		
		if(monthBusinessCondition) {
			long collectionCash = Long.parseLong((String)map.get("collectioncash"));
			Map<String, Object> collectionInformation = sm2MonthDAO.collectionInformation(map);
			
			long totalCollectionRemainingAmount = (long)collectionInformation.get("totalcollectionremainingamount");
			long collectionCompletedAmount = (long)collectionInformation.get("collectioncompletedamount");
			
			totalCollectionRemainingAmount = totalCollectionRemainingAmount + collectionCash;
			collectionCompletedAmount = collectionCompletedAmount - collectionCash;
			monthBusinessCondition = false;
			
			map.put("totalcollectionremainingamount", totalCollectionRemainingAmount);
			map.put("collectioncompletedamount", collectionCompletedAmount);
			map.put("monthbusinesscondition", monthBusinessCondition);
			
			boolean businessCondition = (boolean)sm2MonthDAO.pickBusinessCondition(map).get("businesscondition");
			
			if(businessCondition) {
				businessCondition = false;
				map.put("businesscondition", businessCondition);
			}
			
			sm2MonthDAO.updateBoardMonthCondition(map);
			sm2MonthDAO.updateBoardMonthBusinessCollection(map);
			sm2DAO.updateBoardBusinessCondition(map);
		}
		sm2DAO.deleteBoardMonth(map);
		sm2DAO.deleteDateBoardMonth(map);
	}

	/**
	 * 사업 월별 수금액 정보 수정
	 * @param map
	 * @throws Exception
	 */
	@Override
	public void updateBoardMonth(Map<String, Object> map) throws Exception {
		double collectioncash = Double.parseDouble(((String)map.get("UDCollectioncash")).replace(",", ""));
		map.put("collectioncash", collectioncash);
		
		sm2MonthDAO.updateBoardMonth(map);
	}

	/**
	 * 월별 사업 순서 변경
	 * @param map
	 * @throws Exception
	 */
	@Override
	public void switchBoardMonth(Map<String, Object> map) throws Exception {
		String[] orderTemp = ((String)map.get("list")).split(",");
//		System.out.println("배열: " + Arrays.toString(orderTemp));
		int[] order = new int[orderTemp.length];
		for(int i = 0; i < orderTemp.length; i++) {
			order[i] = Integer.parseInt(orderTemp[i]);
		}
		
		List<Map<String, Object>> selectSpecificMonthBusiness = sm2MonthDAO.selectSpecificMonthBusiness(map);
//		System.out.println("특정 사업목록: " + selectSpecificMonthBusiness);
		
		int[] SBLIndex = new int[selectSpecificMonthBusiness.size()];
		for(int i = 0; i < SBLIndex.length; i++) {
			SBLIndex[i] = (int) selectSpecificMonthBusiness.get(i).get("monthorderidx");
		}
		
		int[] C = new int[SBLIndex.length - 1];
		for(int i = 0; i < C.length; i++) {
			C[i] = SBLIndex[i + 1] - SBLIndex[i];
		}
		
		int l = 0;
		for(int i = 0; i < SBLIndex.length; i++) {
			if(SBLIndex[i] < order[i]) {
				l = i + 1;
				break;
			}
		}
		
		int i = 0;
		int j = 0;
		if(SBLIndex[l] > order[l]) {	// i < j
			i = l - 2;
			for(int k = 0; k < SBLIndex.length; k++) {
				if(SBLIndex[k] == order[l - 1]) {
					j = k;
				}
			}
			
			for(int k = i + 1; k < j; k++) {
				selectSpecificMonthBusiness.get(k).put("monthorderidx", SBLIndex[k] + C[k]);
			}
			selectSpecificMonthBusiness.get(j).put("monthorderidx", SBLIndex[i + 1]);
			
		} else {	// j < i
			j = l - 1;
			for(int k = 0; k < SBLIndex.length; k++) {
				if(order[k] == SBLIndex[l - 1]) {
					i = k;
				}
			}
			
			for(int k = j + 1; k <= i; k++) {
				selectSpecificMonthBusiness.get(k).put("monthorderidx", SBLIndex[k] - C[k - 1]);
			}
			selectSpecificMonthBusiness.get(j).put("monthorderidx", SBLIndex[i]);
			
		}
		
//		System.out.println("업데이트된 특정 사업목록: " + selectSpecificMonthBusiness);
		
		for(int k = 0; k < selectSpecificMonthBusiness.size(); k++) {
			sm2MonthDAO.updateBoardOrderMonth(selectSpecificMonthBusiness.get(k));
		}
	}

	/**
	 * 사업 월별 수금액 상세보기 조회시 관련된 월별 사업목록 조회 
	 * @param map
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectBoardDetailMonthDetail(Map<String, Object> map) throws Exception {
		return sm2MonthDAO.selectBoardDetailMonthDetail(map);
	}
	
}
