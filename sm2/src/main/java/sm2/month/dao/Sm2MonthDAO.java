/**
 * @Class Name : Sm2MonthDAO.java
 * @Description : 월별 사업 매출 정보 dao 클래스
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

package sm2.month.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sm2.cmm.dao.AbstractDAO;

@Repository("sm2MonthDAO")
public class Sm2MonthDAO extends AbstractDAO {

	/**
	 * 사업 월별 수금액 목록 페이지 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardMonthList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("sm2BoardMonth.selectBoardMonthList", map);
	}

	/**
	 * 월별 계약매출 합계 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardMonthAmount(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2BoardMonth.selectBoardMonthAmount", map);
	}

	/**
	 * 월별 계약매출 예상 합계 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardMonthExpectedAmount(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("sm2BoardMonth.selectBoardMonthExpectedAmount", map);
	}

	/**
	 * 사업명에 해당하는 인덱스 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> pickIdx(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2Board.pickIdx", map);
	}

	/**
	 * 금월 사업 수금액 등록
	 * @param map
	 * @throws Exception
	 */
	public void insertBoardMonth(Map<String, Object> map) throws Exception {
		insert("sm2BoardMonth.insertBoardMonth", map);
	}

	/**
	 * 사업수금액 정보 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> collectionInformation(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2Board.collectionInformation", map);
	}

	/**
	 * 사업수금액 완료 상태 변경
	 * @param map
	 * @throws Exception
	 */
	public void updateBoardMonthCondition(Map<String, Object> map) throws Exception {
		update("sm2BoardMonth.updateBoardMonthCondition", map);
	}

	/**
	 * 사업수금액 정산
	 * @param map
	 * @throws Exception
	 */
	public void updateBoardMonthBusinessCollection(Map<String, Object> map) throws Exception {
		update("sm2BoardMonth.updateBoardMonthBusinessCollection", map);
	}

	/**
	 * 사업 월별 수금액 정보 상세보기 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardMonthDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2BoardMonth.selectBoardMonthDetail", map);
	}

	/**
	 * 사업 월별 수금완료 여부 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> pickMonthBusinessCondition(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2BoardMonth.pickMonthBusinessCondition", map);
	}

	/**
	 * 사업 수금완료 여부 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> pickBusinessCondition(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2Board.pickBusinessCondition", map);
	}

	/**
	 * 사업 월별 수금액 정보 수정
	 * @param map
	 * @throws Exception
	 */
	public void updateBoardMonth(Map<String, Object> map) throws Exception {
		update("sm2BoardMonth.updateBoardMonth", map);
	}

	/**
	 * 특정 연월 월별 사업 목록 불러오기
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSpecificMonthBusiness(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("sm2BoardMonth.selectSpecificMonthBusiness", map);
	}

	/**
	 * 월별 사업 orderIndex 업데이트
	 * @param map
	 * @throws Exception
	 */
	public void updateBoardOrderMonth(Map<String, Object> map) throws Exception {
		update("sm2BoardMonth.updateBoardOrderMonth", map);
	}

	/**
	 * 사업 월별 수금액 상세보기 조회시 관련된 월별 사업목록 조회 
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardDetailMonthDetail(Map<String, Object> map) {
		return (List<Map<String, Object>>) selectList("sm2BoardMonth.selectBoardDetailMonthDetail", map);
	}

}
