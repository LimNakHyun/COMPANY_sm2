package sm2.login.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import sm2.cmm.dao.AbstractDAO;

@Repository("sm2LoginDAO")
public class Sm2LoginDAO extends AbstractDAO {

	/**
	 * 사용자 정보 호출
	 * @param map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardUserInfo(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("sm2BoardLogin.selectBoardUserInfo", map);
	}

}
