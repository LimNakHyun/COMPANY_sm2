/**
 * @Class Name : Sm2LoginServiceImpl.java
 * @Description : 사업 매출 정보 로그인 service implement 클래스
 * @Modification Information
 * @
 * @   수정일                   수정자                                       수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2023.03.13     임낙현                                      최초생성
 *
 * @author 개발5팀 임낙현 사원
 * @since 2023.03.13
 * @version 1.0
 * @see
 */

package sm2.login.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import sm2.login.dao.Sm2LoginDAO;
import sm2.login.vo.LoginVO;

@Service("sm2LoginService")
public class Sm2LoginServiceImpl implements Sm2LoginService {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sm2LoginDAO")
	private Sm2LoginDAO sm2LoginDAO;

	/**
	 * 로그인시 ID 조회
	 * @param loginVO
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectBoardUserID(LoginVO loginVO) throws Exception {
		return sm2LoginDAO.selectBoardUserID(loginVO);
	}

	/**
	 * 로그인시 PW 조회
	 * @param loginVO
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectBoardUserPW(LoginVO loginVO) throws Exception {
		return sm2LoginDAO.selectBoardUserPW(loginVO);
	}

	/**
	 * 사용자 권한 조회
	 * @param loginVO
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectBoardUserRole(LoginVO loginVO) throws Exception {
		return sm2LoginDAO.selectBoardUserRole(loginVO);
	}
	
}
