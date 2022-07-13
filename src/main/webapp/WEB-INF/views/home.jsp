<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>

<%@include file="/WEB-INF/views/includes/header.jsp"%>


   <div class="container" style="margin-top: 30px; height:auto; min-height:800px;">
   
      <div class="row">
      
         <div class="col-sm-12">
            
         <div class="text-center" id="p" style="margin: 20px">
         <a href="/worldcup/main"><img src="../../resources/img/worldcup2.png" width="600" height="250"></a><!-- 월드컵 -->
         </div>
         
         
         <div class="form-group" style="margin-bottom: 0px"></div>
         
         <div id="address-list"></div>
         
         <div id="place-list"></div>
         
         <input type="hidden" id="searchX"> <input type="hidden" id="searchY">

         <%--    <h2>키워드 검색 결과</h2>
      region = ${result.region}<br>
      keyword = ${result.keyword}<br>
      selectedRegion = ${result.selectedRegion}<br>
      pageableCount = ${result.pageableCount}<br>
      totalCount = ${result.totalCount}<br>
      isEnd = ${result.isEnd}<br> --%>


         </div><!-- col-sm-10 -->
         <div class="col-sm-6">
            
         <div class="text-right" id="p" style="margin: 10px 5px">
         <a href="/board/list"><img src="../../resources/img/mm.png" width="280" height="250"></a><!-- 게시판 -->
         </div>
                  
         <div class="form-group" style="margin-bottom: 0px"></div>
         
         <div id="address-list"></div>
         
         <div id="place-list"></div>
         
         <input type="hidden" id="searchX"> <input type="hidden" id="searchY">

         <%--    <h2>키워드 검색 결과</h2>
      region = ${result.region}<br>
      keyword = ${result.keyword}<br>
      selectedRegion = ${result.selectedRegion}<br>
      pageableCount = ${result.pageableCount}<br>
      totalCount = ${result.totalCount}<br>
      isEnd = ${result.isEnd}<br> --%>


         </div><!-- col-sm-10 -->
         <div class="col-sm-6">
            
         <div class="text-left" id="p" style="margin: 10px 5px">
         <table width="280" height="250">
						<tr>
							<th colspan="3">최근 게시글</th>
							<th><a href="/board/register">+</a></th>
						</tr>
					
					<c:forEach items="${list}" var="board">
						<tr>
							<td><c:out value="${board.bno}" /></td>
							<!-- href: 꼭 필요한 정보만 저장 (bno), url은 알고 있으므로 생략 -->
							<td><a class="move" href='<c:out value="/board/get?bno=${board.bno}" />'>
							<c:out value="${board.title}" /><b>[<c:out value="${board.replyCnt}"/>]</b>
								</a>
							</td>
								<td><fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd" />
							</td>
						</tr>
					</c:forEach>
				</table>
         </div>
         
       
         <div class="form-group" style="margin-bottom: 0px"></div>
         
         <div id="address-list"></div>
         
         <div id="place-list"></div>
         
         <input type="hidden" id="searchX"> <input type="hidden" id="searchY">

         <%--    <h2>키워드 검색 결과</h2>
      region = ${result.region}<br>
      keyword = ${result.keyword}<br>
      selectedRegion = ${result.selectedRegion}<br>
      pageableCount = ${result.pageableCount}<br>
      totalCount = ${result.totalCount}<br>
      isEnd = ${result.isEnd}<br> --%>

         </div><!-- col-sm-10 -->
      </div><!-- row -->
   </div><!-- container -->
</body>

<%@include file="/WEB-INF/views/includes/footer.jsp"%>

</html>