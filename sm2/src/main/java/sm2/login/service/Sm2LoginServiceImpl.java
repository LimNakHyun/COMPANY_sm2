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

@Service("sm2LoginService")
public class Sm2LoginServiceImpl implements Sm2LoginService {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sm2LoginDAO")
	private Sm2LoginDAO sm2LoginDAO;

	/**
	 * 사용자 정보 호출
	 * @param map
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectBoardUserInfo(Map<String, Object> map) throws Exception {
		return sm2LoginDAO.selectBoardUserInfo(map);
	}
	
}
