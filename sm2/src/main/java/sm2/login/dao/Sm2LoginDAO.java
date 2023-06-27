package sm2.login.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import sm2.cmm.dao.AbstractDAO;
import sm2.login.vo.LoginVO;

@Repository("sm2LoginDAO")
public class Sm2LoginDAO extends AbstractDAO {

	/**
	 * 로그인시 ID 조회
	 * @param loginVO
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardUserID(LoginVO loginVO) {
		return (Map<String, Object>) selectOne("sm2BoardLogin.selectBoardUserID", loginVO);
	}
	
	/**
	 * 로그인시 PW 조회
	 * @param loginVO
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardUserPW(LoginVO loginVO) {
		return (Map<String, Object>) selectOne("sm2BoardLogin.selectBoardUserPW", loginVO);
	}

	/**
	 * 사용자 권한 조회
	 * @param loginVO
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardUserRole(LoginVO loginVO) {
		return (Map<String, Object>) selectOne("sm2BoardLogin.selectBoardUserRole", loginVO);
	}

}
