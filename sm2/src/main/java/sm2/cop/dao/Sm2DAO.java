/**
 * @Class Name : Sm2DAO.java
 * @Description : 사업 매출 정보 dao 클래스
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

package sm2.cop.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sm2.cmm.dao.AbstractDAO;

@Repository("sm2DAO")
public class Sm2DAO extends AbstractDAO {

	/**
	 * 사업 매출정보 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("sm2Board.selectBoardList", map);
	}

	/**
	 * 사업 매출정보 상세보기 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2Board.selectBoardDetail", map);
	}

	/**
	 * 사업 매출정보 등록
	 * @param map
	 * @throws Exception
	 */
	public void insertBoard(Map<String, Object> map) throws Exception {
		insert("sm2Board.insertBoard", map);
	}

	/**
	 * 사업 매출정보 삭제
	 * @param map
	 * @throws Exception
	 */
	public void deleteBoard(Map<String, Object> map) throws Exception {
		update("sm2Board.deleteBoard", map);
	}

	/**
	 * 사업 월별 매출정보 삭제
	 * @param map
	 * @throws Exception
	 */
	public void deleteRelatedBoardMonth(Map<String, Object> map) throws Exception {
		update("sm2BoardMonth.deleteRelatedBoardMonth", map);
	}

	/**
	 * 사업 매출정보 수정
	 * @param map
	 * @throws Exception
	 */
	public void updateBoard(Map<String, Object> map) throws Exception {
		update("sm2Board.updateBoard", map);
	}

	/**
	 * 월별 사업 매출정보 상태변경
	 * @param map
	 * @throws Exception
	 */
	public void updateRelatedBoardMonth(Map<String, Object> map) throws Exception {
		update("sm2BoardMonth.updateRelatedBoardMonth", map);
	}

	/**
	 * 사업금액 전체 합계 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardAmount(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2Board.selectBoardAmount", map);
	}

	/**
	 * 사업 월별 수금액 정보 삭제
	 * @param map
	 * @throws Exception
	 */
	public void deleteBoardMonth(Map<String, Object> map) throws Exception {
		update("sm2BoardMonth.deleteBoardMonth", map);
	}

	/**
	 * 사업 월별 수금액 정보 삭제날짜 업데이트
	 * @param map
	 * @throws Exception
	 */
	public void deleteDateBoardMonth(Map<String, Object> map) throws Exception {
		update("sm2BoardMonth.deleteDateBoardMonth", map);
	}

	/**
	 * 사업 수금악 상태 변경
	 * @param map
	 * @throws Exception
	 */
	public void updateBoardBusinessCondition(Map<String, Object> map) throws Exception {
		update("sm2Board.updateBoardBusinessCondition", map);
	}
	
	/**
	 * 특정 연월 사업 목록 불러오기
	 * @param map
	 * @throws Exception
	 */
//	@SuppressWarnings("unchecked")
//	public List<Map<String, Object>> selectSpecificBusiness(Map<String, Object> map) throws Exception {
//		return (List<Map<String, Object>>) selectList("sm2Board.selectSpecificBusiness", map);
//	}

	/**
	 * 사업 orderIndex 업데이트
	 * @param map
	 * @throws Exception
	 */
//	public void updateBoardOrder(Map<String, Object> map) throws Exception {
//		update("sm2Board.updateBoardOrder", map);
//	}

	/**
	 * 사업 상세보기 관련 사업 조회
	 * @param commandMap
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBoardDetailRelatedBusiness(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("sm2Board.getBoardDetailRelatedBusiness", map);
	}

	/**
	 * 사업 상세보기 관련 예상 사업 수금액 조회
	 * @param commandMap
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getBoardDetailRelatedBusinessExpectcollectioncash(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("sm2Board.getBoardDetailRelatedBusinessExpectcollectioncash", map);
	}

	/**
	 * 사업 상세보기 관련 실 사업 수금액 조회
	 * @param commandMap
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getBoardDetailRelatedBusinessRealcollectioncash(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("sm2Board.getBoardDetailRelatedBusinessRealcollectioncash", map);
	}

}
