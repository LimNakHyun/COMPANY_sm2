package sm2.bizordchg.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import sm2.bizordchg.dao.BizOrdChgDAO;

@Service("bizOrdChgService")
public class BizOrdChgServiceImpl implements BizOrdChgService {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "bizOrdChgDAO")
	private BizOrdChgDAO bizOrdChgDAO;

	/**
	 * 매출 총괄현황 사업 순서변경
	 * @param commandMap
	 * @throws Exception
	 */
	@Override
	public void switchBoard(Map<String, Object> map) throws Exception {
		
		String[] orderTemp = ((String)map.get("list")).split(",");

		int[] order = new int[orderTemp.length];
		for(int i = 0; i < orderTemp.length; i++) {
			order[i] = Integer.parseInt(orderTemp[i]);
		}
		
		List<Map<String, Object>> specificBusinessList = bizOrdChgDAO.selectSpecificBusiness(map);
		
		int[] SBLIndex = new int[specificBusinessList.size()];
		for(int i = 0; i < SBLIndex.length; i++) {
			SBLIndex[i] = (int) specificBusinessList.get(i).get("orderidx");
		}
		
		int[] C = new int[SBLIndex.length - 1];
		for(int i = 0; i < C.length; i++) {
			C[i] = SBLIndex[i + 1] - SBLIndex[i];
		}
		
		int l = 0;
		for(int i = 0; i < SBLIndex.length; i++) {
			if(SBLIndex[i] < order[i]) {
				l = i + 1;
				break;
			}
		}
		
		int i = 0;
		int j = 0;
		if(SBLIndex[l] > order[l]) {	// i < j
			i = l - 2;
			for(int k = 0; k < SBLIndex.length; k++) {
				if(SBLIndex[k] == order[l - 1]) {
					j = k;
				}
			}
			
			for(int k = i + 1; k < j; k++) {
				specificBusinessList.get(k).put("orderidx", SBLIndex[k] + C[k]);
			}
			specificBusinessList.get(j).put("orderidx", SBLIndex[i + 1]);
			
		} else {	// j < i
			j = l - 1;
			for(int k = 0; k < SBLIndex.length; k++) {
				if(order[k] == SBLIndex[l - 1]) {
					i = k;
				}
			}
			
			for(int k = j + 1; k <= i; k++) {
				specificBusinessList.get(k).put("orderidx", SBLIndex[k] - C[k - 1]);
			}
			specificBusinessList.get(j).put("orderidx", SBLIndex[i]);
			
		}
		
		for(int k = 0; k < specificBusinessList.size(); k++) {
			bizOrdChgDAO.updateBoardOrder(specificBusinessList.get(k));
		}
		
	}
}
