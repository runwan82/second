<%@page import="board.model.vo.BoardForList"%>
<%@page import="board.model.vo.RoomBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/brokerHeader.jsp" %>
<%
	List<RoomBoard> list = (List<RoomBoard>)request.getAttribute("list");
	String pageBar = (String)request.getAttribute("pageBar");
	int cnt = (int)request.getAttribute("totalContents");
%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/css/board.css" />
<script>

//방올리기
$(document).ready(function(){
    
    $(".roomUpdateBtn").click(function(){
    	location.href='<%= request.getContextPath() %>/brokerBoard/insertBoard'
    });
});
</script>

     <div class="lookinRoomView">
     	<section id="option-tab">
	            <select name="roomType" multiple="multiple" class="selectOption" >
	                <option value="oneRoom">원룸</option> 
	                <option value="twoRoom">투룸</option>
	                <option value="threeRoom" >쓰리룸</option>
	            </select>
	
	            <select name="rentType" multiple="multiple" class="selectOption" >
	                <option value="Rent_monthly" >월세</option>
	                <option value="Rent" >전세</option>
	                <option value="Buy" >매매</option>
	            </select>
	
	            <select name="paidType" multiple="multiple" class="selectOption" >
	                <option value="fee" >월 ~ 45</option>
	                <option value="fee" >45 ~ 100</option>
	            </select>
	
	            <select name="managementFee" multiple="multiple" class="selectOption" >
	                <option value="manage_minimal" >관리비 ~5만</option>
	                <option value="manage_middle" >5~10만 </option>
	                <option value="manage_high" >10~20만</option>
	            </select>
	            <select name="option" multiple="multiple" class="selectOption" >
	                <option value="oneRoom" >추가옵션</option>
	                <option value="twoRoom" >세탁기</option>
	                <option value="threeRoom" >냉장고</option>
	            </select>
     			<input type="submit" class="room-searchBtn" value="검색">
     	</section>
     		<form id="map-searchFrm" onsubmit="searchPlaces(); return false;">
	            <input type="text" name="localSearch" id="localSearch" placeholder="지역별 검색" >
	            <button type="submit" class="room-searchBtn">검색</button>
     		</form>
     	<section>
     		<button class="roomUpdateBtn" >방 올리기</button>
     	</section>
     </div>  
	
		<div id="roomViewCon1">
            <h2>전체 게시글 : <%= cnt %>개</h2>
	 <% 
	 if(list == null || list.isEmpty()){ %>           
         	<%--조회된 행이 없는 경우 --%>
				<div>조회된 행이 없습니다.</div>
		<% 
			} 
		   	else {
				for(RoomBoard b : list){
		%>  
		<%--조회된 행이 있는 경우 --%> 
	
		<div>
            <a href="<%= request.getContextPath() %>/brokerBoard/boardView?board_num=<%= b.getBoard_num() %>&br=<%= b.getBr_cp_id() %>" >
                <% if(b.getOk().equals("T")){ %>
                	<img src="<%=request.getContextPath()%>/upload/board/<%=b.getRenameName() %>">
            	<% } else{ %>
                	<img src="<%=request.getContextPath()%>/upload/board/<%=b.getRenameName() %>" style="filter: brightness(50%);">
            	<% } %> 
            </a>
            <br>
            <input type="text" value="등록날짜  <%= b.getEnrolldate() %>"> <br />
             	<%= b.getBoard_title() %>
        </div>
         <% 		}
		
			} 
		%>  
		<div id='pageBar'>
			<%= pageBar %>
		</div>
                    
                  
		
	</div>
	<div id="roomViewCon2">
		<div id="map" style="width:100%;height:800px;" ></div>
	</div>
    
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f812560fa3200866e643713203eb962f&libraries=services"></script>
<script>
// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
//var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(); 

/* // 키워드로 장소를 검색합니다
searchPlaces(); */

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

function searchPlaces() {
	

    var keyword = document.getElementById('localSearch').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('지역을 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
geocoder.addressSearch(keyword, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        /*  var infowindow = new kakao.maps.InfoWindow({
            //content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
        });
        infowindow.open(map, marker);  */

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});
}


 // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}  

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            //displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}         

 //지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
 
 // 마커를 생성하고 지도에 표시합니다
 var marker = new kakao.maps.Marker({
     map: map,
     position: new kakao.maps.LatLng(place.y, place.x) 
 });

 // 마커에 클릭이벤트를 등록합니다
 kakao.maps.event.addListener(marker, 'click', function() {
     // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
     infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
     infowindow.open(map, marker);
 });
} 

</script>



