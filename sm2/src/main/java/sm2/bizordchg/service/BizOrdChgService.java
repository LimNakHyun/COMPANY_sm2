package sm2.bizordchg.service;

import java.util.Map;

public interface BizOrdChgService {
	/**
	 * 매출 총괄현황 사업 순서변경
	 * @param commandMap
	 * @throws Exception
	 */
	void switchBoard(Map<String, Object> map) throws Exception;
}
