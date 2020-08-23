<%@page import="board.model.vo.RoomImage"%>
<%@page import="board.model.vo.RoomBoard"%>
<%@page import="board.model.vo.Room"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/brokerHeader.jsp" %>
<%
Room room = (Room)request.getAttribute("room");
RoomBoard roomBoard = (RoomBoard)request.getAttribute("roomBoard");
Broker br = (Broker)request.getAttribute("broker");
List<RoomImage> imgList = (List<RoomImage>)request.getAttribute("imgList");
%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/board.css" />


	<div>
		<section class="roomDetail-info">
			<div id="roomDetailView1">
				<%= room.getRoom_val().contains("T")?"투룸":"원룸" %><br />
				<span id="roomDetailTxt1"><%= room.getTax_val().equals("M")?"월세":"전세" %> <%= room.getPrice() %></span>만원
			</div>
			<div id="roomDetailView2">
				전용면적<br />
				<span id="roomDetailTxt2"><%= room.getSize() %></span>평
			</div>
			<div id="roomDetailView3">
				관리비<br />
				<span id="roomDetailTxt1"><%= room.getTax_val().equals("M")?"월세":"전세" %> <%= room.getPrice() %></span>만원
			</div>
			<div id="roomDetailView4">
				<p><%= br.getBr_cp_name() %></p>
				<p><%= br.getBr_name() %></p>
			</div>
			<div id="roomDetailView5">
				<button class="brokerPhoneBtn" onclick="brokerPhone();" >연락처 보기</button>
			</div>
			
		<!-- 중개인 연결 팝업  -->
		 <div id="connectBack"></div> 
		 <div id="connectWrap">
	            <div class="form-wrap">
	                <div class="button-wrap">
	                    <h1>연락처 보기</h1>
	                </div>
	                <input type="button" id="closeBtn" value="x" onclick="brokerCloseBtn();">
	                
	                <div>
		                <p><%= br.getBr_cp_name() %></p>
		                <p>주소</p>
		                <br />
		                <p><%= br.getBr_name() %></p>
		                <p><%= br.getPhone() %></p>
	                </div>
	                <div>
	                <div class="profileImg">사진
		                <p>담당 : <%= br.getBr_name() %>(중개 보조원)</p>
		                <p>보증보험 : <%= br.getInsurance().equals("T")?"유":"무" %></p>
	                </div>
	                </div>
	                
	            </div>
	        </div> 
		
		</section>
	</div>

	<div id="roomDetail-info2">
		<img src="<%=request.getContextPath()%>/images/heart.png" alt="" />좋아요
		<img src="<%=request.getContextPath()%>/images/alert.png" onclick="roomReportBtn();" alt="" />허위매물 신고
	</div>
	
	  <!-- 본인 인증 팝업 -->   
	    <div id="certificationWrap"></div> 
	        <div id="certification">
	            <div class="certification-frmWrap">
	                    
	                <input type="button" id="closeBtn" value="x" onclick="roomReportcloseBtn();">
	                
	                <form action="<%= request.getContextPath() %>/member/login" id="cerFrm" method="post" class="input-group">
		                <h3>허위매물 신고</h3>

		                <div class="social-icons">
		                    <img src="<%= request.getContextPath() %>/images/google.png" alt="google">
		                </div>   
		                <p>허위매물을 신고해주세요!</p>
		                <p>허위매물 신고를 접수해주시면, 허위매물 여부를 판정하여 목록에서 삭제등의 조치가 진행됩니다.</p>
		                
		                <p>본인인증을 진행해주세요.</p>
		                <p>허위매물 신고는 본인인증 후 작성하실 수 있습니다.</p>
		                <p id="cerTitle">휴대폰 인증</p>
		                <select name="agency" id="cerSelect" class="cer-field">
		                	<option value="kt">KT</option>
		                	<option value="skt">SKT</option>
		                	<option value="lg">LG u+</option>
		                	<option value="alttl">알뜰통신사</option>
		                </select>
		                
		                <input type="tel" id="cerPhone" name="cerPhone" class="cer-field" placeholder="(-없이)01012345678" maxlength="11" required>
	                    
	                    <br />
	                    <input type="text" id="cerNumber" name="cerNumber" class="cer-field" placeholder="인증번호를 입력해주세요" required>
	                    <input type="submit" class="submit" value="인증" />
	                </form>
	                
	              
	            </div>
	        </div> 
	
   	<div class="roomDetail-info3">	
   		<section id="detail-infoTitle">
   			<p class="detail-info1"><%= roomBoard.getOk().equals("F")?"비 확인 매물":"확인 매물" %> <%= roomBoard.getEnrolldate() %></p>
   			<p><%= roomBoard.getOk().equals("F")?"관리자의 매매등록 승인처리가 필요합니다":"확인된 매물입니다" %></p>
   		</section>
   		<ul id="detail-list">
   			<li>
   				<p>해당층/건물층</p>
   				<div><%=room.getFloor() %></div>
   			</li>
   			<li>
   				<p>전용/공급면적</p>
   				<div><%= room.getSize() %>평</div>
   			</li>
   			<li>
   				<p>난방종류</p>
   				<div>개별난방</div>
   			</li>
   			<li>
   				<p>빌트인</p>
   				<div>빌트인/주방</div>
   			</li>
   			<li>
   				<p>엘리베이터</p>
   				<div>없음</div>
   			</li>
   			<li>
   				<p>반려동물</p>
   				<div>가능</div>
   			</li>
   			<li>
   				<p>베란다/발코니</p>
   				<div>있음</div>
   			</li>
   			<li>
   				<p>전세자금대출</p>
   				<div>불가능</div>
   			</li>
   			<li>
   				<p>냉장고</p>
   				<div>있음</div>
   			</li>
   			<li>
   				<p>세탁기</p>
   				<div>있음</div>
   			</li>
   			<li>
   				<p>에어컨</p>
   				<div>있음</div>
   			</li>
   			<li>
   				<p>기타</p>
   				<div></div>
   			</li>
   		</ul>
   	</div>
   
	<div class="roomDetail-info4">
		<div id="roomImg-number"><p>매물번호 : <%= room.getRoom_num() %></p></div>
		 <%
   	if(imgList != null ){ 
   		for(RoomImage ri : imgList){   %>
		<div >
   			<img class="roomDetailImg01" src="<%=request.getContextPath()%>/upload/board/<%=ri.getRenameName()%>"  alt="" />
		</div>
   			
   <%		}
   	}
   
   %>
    </div>
		
<section class="space" style="width: 100%;clear:both;height: 80px;"></section>
	<div class="roomDetail-info5">
		<p><%= roomBoard.getBoard_title() %> </p>
		<div id="roomDetail-info5-content">
			<%= roomBoard.getContent() %>
		</div>
	</div>
	<hr />
	<div class="roomDetail-info6">
		<p class="map-title">위치 및 주변시설</p>
		<input type="text" id="roomLocation" value="<%=room.getLocation() %>" readonly/>
		<div id="roomMap" style="width:800px;height:500px;"></div>
	</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f812560fa3200866e643713203eb962f"></script>	
<script>

var mapContainer = document.getElementById('roomMap'), // 지도를 표시할 div 
mapOption = {
    center: new kakao.maps.LatLng(37.56682, 126.97865), // 지도의 중심좌표
    level: 3, // 지도의 확대 레벨
    mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
}; 

// 지도를 생성한다 
var map = new kakao.maps.Map(mapContainer, mapOption); 

function brokerPhone() {
	connectWrap.style.display = "block";
	connectBack.style.display = "block";
}
function brokerCloseBtn() {
	connectWrap.style.display = "none";
	connectBack.style.display = "none";
}
function roomReportBtn() {
	certification.style.display = "block";
	certificationWrap.style.display = "block";
}
function roomReportcloseBtn() {
	certification.style.display = "none";
	certificationWrap.style.display = "none";
}

</script>




