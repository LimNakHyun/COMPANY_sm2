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
	 * 사업 매출정보 삭제
	 * @param map
	 * @throws Exception
	 */
	void deleteBoard(Map<String, Object> map) throws Exception;

	/**
	 * 사업 매출정보 수정
	 * @param map
	 * @throws Exception
	 */
	void updateBoard(Map<String, Object> map) throws Exception;

	/**
	 * 사업금액 전체 합계 조회
	 * @param map
	 * @throws Exception
	 */
	Map<String, Object> selectBoardAmount(Map<String, Object> map) throws Exception;

	/**
	 * 매출 총괄현황 사업 순서변경
	 * @param commandMap
	 * @throws Exception
	 */
//	void switchBoard(Map<String, Object> map) throws Exception;

	/**
	 * 사업 상세보기 관련 사업 조회
	 * @param commandMap
	 * @throws Exception
	 */
	List<Map<String, Object>> getBoardDetailRelatedBusiness(Map<String, Object> map) throws Exception;

	/**
	 * 사업 상세보기 관련 예상 사업 수금액 조회
	 * @param commandMap
	 * @throws Exception
	 */
	Map<String, Object> getBoardDetailRelatedBusinessExpectcollectioncash(Map<String, Object> map) throws Exception;
	
	/**
	 * 사업 상세보기 관련 실 사업 수금액 조회
	 * @param commandMap
	 * @throws Exception
	 */
	Map<String, Object> getBoardDetailRelatedBusinessRealcollectioncash(Map<String, Object> map) throws Exception;

}
