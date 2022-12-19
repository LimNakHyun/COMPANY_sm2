package sm2.cop.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sm2.cmm.cmm.CommandMap;
import sm2.cmm.dao.AbstractDAO;

@Repository("sm2DAO")
public class Sm2DAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(CommandMap map) throws Exception {
		return (List<Map<String, Object>>) selectList("sm2.selectBoardList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("sm2.selectBoardDetail", map);
	}

	public void insertBoard(Map<String, Object> map) {
		insert("sm2.insertBoard", map);
	}

}
