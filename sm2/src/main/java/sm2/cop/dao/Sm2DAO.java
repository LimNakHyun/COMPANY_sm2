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
		return (List<Map<String, Object>>) selectList("sm2.selectBoardList", map);
	}

	/**
	 * 사업 매출정보 상세보기 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2.selectBoardDetail", map);
	}

	/**
	 * 사업 매출정보 등록
	 * @param map
	 * @throws Exception
	 */
	public void insertBoard(Map<String, Object> map) throws Exception {
		insert("sm2.insertBoard", map);
	}

	/**
	 * 사업 월별 수금액 목록 페이지 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardMonthList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("sm2.selectBoardMonthList", map);
	}

	/**
	 * 사업명에 해당하는 인덱스 조회
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> pickIdx(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2.pickIdx", map);
	}

	/**
	 * 금월 사업 수금액 등록
	 * @param map
	 * @throws Exception
	 */
	public void insertBoardMonth(Map<String, Object> map) throws Exception {
		insert("sm2.insertBoardMonth", map);
	}

	/**
	 * 사업수금액 정보 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> collectionInformation(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2.collectionInformation", map);
	}

	/**
	 * 사업수금액 정산
	 * @param map
	 * @throws Exception
	 */
	public void updateBoardMonth(Map<String, Object> map) throws Exception {
		update("sm2.updateBoardMonth", map);
	}

	/**
	 * 사업수금액 완료 상태 변경
	 * @param map
	 * @throws Exception
	 */
	public void updateBoardMonthCondition(Map<String, Object> map) throws Exception {
		update("sm2.updateBoardMonthCondition", map);
	}

}
