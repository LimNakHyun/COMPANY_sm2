/**
 * @Class Name : Sm2LoginService.java
 * @Description : 사업 매출 정보 로그인 service 클래스
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

import sm2.login.vo.LoginVO;

public interface Sm2LoginService {

	/**
	 * 로그인시 ID 조회
	 * @param loginVO
	 * @throws Exception
	 */
	public Map<String, Object> selectBoardUserID(LoginVO loginVO) throws Exception;

	/**
	 * 로그인시 PW 조회
	 * @param loginVO
	 * @throws Exception
	 */
	public Map<String, Object> selectBoardUserPW(LoginVO loginVO) throws Exception;

	/**
	 * 사용자 권한 조회
	 * @param loginVO
	 * @throws Exception
	 */
	public Map<String, Object> selectBoardUserRole(LoginVO loginVO) throws Exception;

}
