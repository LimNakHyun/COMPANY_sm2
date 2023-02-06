/**
 * @Class Name : Sm2MonthService.java
 * @Description : 월별 사업 매출 정보 service 클래스
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

import java.util.List;
import java.util.Map;

public interface Sm2MonthService {

	/**
	 * 사업 월별 수금액 목록 페이지 조회
	 * @param map
	 * @throws Exception
	 */
	List<Map<String, Object>> selectBoardMonthList(Map<String, Object> map) throws Exception;

	/**
	 * 월별 사업금액 합계 조회
	 * @param map
	 * @throws Exception
	 */
	Map<String, Object> selectBoardMonthAmount(Map<String, Object> map) throws Exception;

	/**
	 * 사업 월별 수금액 등록
	 * @param map
	 * @throws Exception
	 */
	void insertBoardMonth(Map<String, Object> map) throws Exception;

	/**
	 * 사업 월별 수금액 수금여부 전환
	 * @param map
	 * @throws Exception
	 */
	void updateBoardMonthCondition(Map<String, Object> map) throws Exception;

	/**
	 * 사업 실매출 현황 조회
	 * @param map
	 * @throws Exception
	 */
	List<Map<String, Object>> selectBoardOverall(Map<String, Object> map) throws Exception;

	/**
	 * 사업 예상매출 현황 조회
	 * @param map
	 * @throws Exception
	 */
	List<Map<String, Object>> selectBoardExpectOverall(Map<String, Object> map) throws Exception;

	/**
	 * 사업 월별 수금액 정보 상세보기 조회
	 * @param map
	 * @throws Exception
	 */
	Map<String, Object> selectBoardMonthDetail(Map<String, Object> map) throws Exception;

	/**
	 * 사업 월별 수금액 정보 삭제
	 * @param map
	 * @throws Exception
	 */
	void deleteBoardMonth(Map<String, Object> map) throws Exception;

	/**
	 * 사업 월별 수금액 정보 수정
	 * @param map
	 * @throws Exception
	 */
	void updateBoardMonth(Map<String, Object> map) throws Exception;

	
	/**
	 * 매출 총괄현황 사업 순서변경
	 * @param commandMap
	 * @throws Exception
	 */
	void changeSm2Board(Map<String, Object> map) throws Exception;

}
