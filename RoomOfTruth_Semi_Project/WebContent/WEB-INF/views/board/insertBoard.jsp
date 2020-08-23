<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/board.css" />

	<div class="roomUpdatePage">
        <h1 >매매 올리기</h1>
        <form action="<%= request.getContextPath() %>/board/enroll" method="post" enctype="multipart/form-data">
			<input type="hidden" name="br_cp_id" value="<%=memberLoggedIn.getMemberId() %>" />
		    <section>
		        <input type="text" name="board_title" id="boardTitle" placeholder="제목을 적어주세요"  >
			</section>
			<section id="roomUpSection">
	            <select name="room_val" multiple="multiple" class="selectOption" >
	                <option value="OO">오픈형 원룸</option> 
	                <option value="SO">분리형 원룸</option>
	                <option value="OT">오픈형 투룸</option>
	                <option value="ST">분리형 투룸</option>
	            </select>
	
	            <select name="tax_val" multiple="multiple" class="selectOption" >
	                <option value="M" >월세</option>
	                <option value="Y" >전세</option>
	            </select>
	
	            <select name="price" multiple="multiple" class="selectOption" >
	                <option value="45" >월 ~ 45</option>
	                <option value="100" >45 ~ 100</option>
	            </select>
	
	            <select name="fee" multiple="multiple" class="selectOption" >
	                <option value="5" >관리비 ~5만</option>
	                <option value="10" >5~10만 </option>
	                <option value="20" >10~20만</option>
	            </select>
	            <select name="size" multiple="multiple" class="selectOption" >
	                <option value="14" >14평</option>
	                <option value="24" >24평</option>
	                <option value="34" >34평</option>
	            </select>
	            <span>
	            	입주가능일 : <input type="date" name="movedate" id="movedate" >
	            </span>
	            <span>
	            	층 : <input type="text" name="floor" id="floor" >
	            </span>
			</section>
			
			<section>
		        <div id="roomUploadFile">
		            <textarea rows="5" cols="40" name="boardContent" id="roomUpdateTxt"></textarea>
		            <!-- method="post" enctype="multipart/form-data" 사진 여러개를 같이 올릴수 있게 해줌. -->
		            <br />
		            <!-- 위치 검색 -->
		            <div style="width:75%;height:450px; margin-top:40px; border-bottom: 1px solid #999;" >
			            <div id="roomUpSearch">
			            	<p id="roomUpSearchTxt">방 위치 선택</p>
				            <input type="text" name="location" id="localSearch" placeholder="방 위치를 입력해주세요" required>
				            <button onclick="searchPlaces(); return false;" class="room-searchBtn">확인</button>
			            	<br /><br />
			            	<p>주의사항</p><br />
			            	<p>상세한 주소를 검색해주세요!</p>
			            	<p>예시) 서울시 강남구 (X)</p>
			            	<p>예시) 서울특별시 강남구 테헤란로10길 9 (O)</p>
			            	<p>예시) 테헤란로10길 9 (O)</p>
			            </div>
			     		<div id="roomUpMap">
							<div id="map" style="width:400px;height:400px;" ></div>
						</div>
		            </div>
					<div  id="roomUpFile">
						<p>이미지 등록</p>
						<div id="roomUpFileInput">
			            <input type="file" name="f0"/>  &nbsp;&nbsp;
        				<input type="button" value="추가" onclick="addFile()" />&nbsp;
        				<input type="button" value="삭제" onclick="delFile()" />
						</div>
					</div>
			    </div>
		    </section>
		        	<input type="submit" value="글등록" id="boardBtn1">
        </form>
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
var idx = 0;
function addFile(){
    $("#roomUpFileInput").last().after("<input type='file' name='f"+ ++idx +"'/><br>");
}
function delFile(){
    //input:file의 최소개수는 1개로 제한.
    if($("input:file").length>1)
        $("#roomUpFile>input").last().remove();
}
</script>


<br />
<br />
<br />
<br />
<br />
<br />



