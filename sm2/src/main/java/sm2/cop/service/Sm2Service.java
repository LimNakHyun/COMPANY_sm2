/**
 * @Class Name : Sm2Service.java
 * @Description : 사업 매출 정보 service 클래스
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

import java.util.List;
import java.util.Map;

public interface Sm2Service {

	/**
	 * 사업 매출정보 조회
	 * @param map
	 * @throws Exception
	 */
	List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception;

	/**
	 * 사업 매출정보 상세보기 조회
	 * @param map
	 * @throws Exception
	 */
	Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception;

	/**
	 * 사업 매출정보 등록
	 * @param map
	 * @throws Exception
	 */
	void insertBoard(Map<String, Object> map) throws Exception;

	/**
	 * 사업 월별 수금액 목록 페이지 조회
	 * @param map
	 * @throws Exception
	 */
	List<Map<String, Object>> selectBoardMonthList(Map<String, Object> map) throws Exception;

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
	void updateBoardMonth(Map<String, Object> map) throws Exception;

	/**
	 * 사업금액 합계 조회
	 * @param map
	 * @throws Exception
	 */
	Map<String, Object> selectBoardAmount(Map<String, Object> map) throws Exception;

}
