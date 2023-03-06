/**
 * @Class Name : common.js
 * @Description : 공통 js
 * @
 * @   수정일     	수정자            	  수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2023.02.14     임낙현                  최초생성
 *
 * @author 재난안전DT팀 임낙현
 * @since 2023.02.14
 * @version 1.0
 * @see
 */

// submit을 하러 들어온 객체가 null값인지 체크 
function gfn_isNull(str) {
	if (str == null) return true;
	if (str == "NaN") return true;
	if (new String(str).valueOf() == "undefined") return true;    
    var chkStr = new String(str);
    if (chkStr.valueOf() == "undefined") return true;
    if (chkStr == null) return true;    
    if (chkStr.toString().length == 0) return true;   
    return false; 
}

// 객체를 만들어 컨트롤러로 submit
function ComSubmit(opt_formId) {
	this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
	this.url = "";
	
	if(this.formId == "commonForm") {
		$("#commonForm")[0].reset();
	}
	
	this.setUrl = function setUrl(url) {
		this.url = url;
	};
	
	this.addParam = function addParam(key, value) {
		$("#" + this.formId).append($("<input type='hidden' name='" + key + "' id='" + key + "' value='" + value + "' >"));
	};
	
	this.submit = function submit() {
		var frm = $("#" + this.formId)[0];
		frm.action = this.url;
		frm.method = "post";
		frm.submit();
	}
}

// header.jsp 에서 연도 바꾸기
function yearChange(){
	document.yearFrm.submit();
}

// *update.jsp 에서 이전으로 돌아가기
function goForward() {
	if(confirm('이전으로 돌아가시겠습니까?\n이전으로 돌아가면 수정한 모든 정보가 롤백됩니다.')){
		history.go(-1);
	} else {
		return false;
	}
}