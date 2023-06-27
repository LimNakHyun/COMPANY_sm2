package sm2.bizordchg.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sm2.cmm.dao.AbstractDAO;

@Repository("bizOrdChgDAO")
public class BizOrdChgDAO extends AbstractDAO {
	/**
	 * 특정 연월 사업 목록 불러오기
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSpecificBusiness(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("bizOrdChg.selectSpecificBusiness", map);
	}

	/**
	 * 사업 orderIndex 업데이트
	 * @param map
	 * @throws Exception
	 */
	public void updateBoardOrder(Map<String, Object> map) throws Exception {
		update("bizOrdChg.updateBoardOrder", map);
	}
}
