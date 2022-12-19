package sm2.cop.service;

import java.util.List;
import java.util.Map;

import sm2.cmm.cmm.CommandMap;

public interface Sm2Service {

	List<Map<String, Object>> selectBoardList(CommandMap commandMap) throws Exception;

	Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception;

	void insertBoard(Map<String, Object> map) throws Exception;

}
