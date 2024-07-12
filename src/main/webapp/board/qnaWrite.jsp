<%@ page import="com.ezen.board.dto.Article" %>
<%@ page import="com.ezen.board.service.BoardServiceImpl" %>
<%@ page import="com.ezen.board.service.BoardService" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ezen.mall.web.common.page.Pagination" %>
<%@ page import="com.ezen.mall.web.common.page.PageParams" %>
<%@ page import="com.ezen.member.dto.Member" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty loginMember}">
    <c:set var="message" value="게시판 글쓰기는 회원만 가능합니다!" scope="request"/>
    <c:set var="referer" value="/" scope="request"/>
    <jsp:forward page="/member/login.jsp"/>
</c:if>
<%
    request.setCharacterEncoding("utf-8");
    int boardNum = 20;
//    System.out.println(request.getParameter("boardNum"));
    if (request.getParameter("boardNum") != null) {
        boardNum = Integer.parseInt(request.getParameter("boardNum"));
    }
    int requestPage = 1;
    if (request.getParameter("page") != null) {
        requestPage = Integer.parseInt(request.getParameter("page"));
    }
    int rowCount = 10;
    if (request.getParameter("count") != null) {
        rowCount = Integer.parseInt(request.getParameter("count"));
    }

    int pageSize = 10;

    Member user = (Member) session.getAttribute("loginMember");
    String userid = user.getId();
//    String userid = (String) session.getAttribute("loginMember");
//    if (userId != null) {
//        response.sendRedirect("write.jsp");
//        return;
//    }

    String searchType = request.getParameter("searchType");
    String searchValue = request.getParameter("searchText");

    BoardService boardService = new BoardServiceImpl();
    List<Article> list = boardService.articleList(rowCount, boardNum, requestPage, searchType, searchValue);
    request.setAttribute("list", list);

    int tableRowCount = boardService.getArticleCount(boardNum, searchType, searchValue);
    PageParams params = new PageParams(rowCount, pageSize, requestPage, tableRowCount);
    Pagination pagination = new Pagination(params);
    request.setAttribute("pagination", pagination);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HAN ZO</title>
    <link rel="stylesheet" href="../css/article.css">
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://kit.fontawesome.com/89ab2ce88f.js" crossorigin="anonymous"></script>
</head>
<body>
<div id="wrapper">
    <!-- header start -->
    <jsp:include page="/module/header.jsp"/>
    <!-- header end -->

    <!-- nav start -->
    <jsp:include page="/module/nav.jsp"/>
    <!-- nav start -->
    <section class="notice">
        <div class="page-title">
            <div class="container">
                <div class="title-write">
                    <h3>상품 Q&A 게시글 작성</h3>
                </div>
                <form action="write-action.jsp" class="write-add" method="post">
                    <div>
                        <input class="write-title" placeholder="제목을 입력해주세요." name="write-title">
                    </div>
                    <div class="blog-profile">
                        <div class="blog-profile_text" readonly>${loginMember.id}</div>
                    </div>
                    <div class="blog-left">
                        <div class="blog-content">
                            <textarea class="write-content" name="article_content" placeholder="내용을 입력해주세요." name="write-content"></textarea>
                        </div>
                    </div>
                    <div class="writing">
                        <input type="text" class="user-Id" value="${loginMember.id}" style="opacity: 0;width: 0px;" name="user-Id">
                        <input type="text" class="hitCount" value="0" style="opacity: 0;width: 0px;" name="hitCount">
                        <input type="text" class="boardNum" value="<%=boardNum%>" style="opacity: 0;width: 0px;" name="boardNum">
                        <button type="submit" class="btn btn-dark write-btn" onclick=""><i class="fa-solid fa-pencil"></i> 작성</button>
                        <button type="button" class="write-cancel"><a href="board.jsp">취소</a></button>
                    </div>
                </form>
            </div>
        </div>
    </section>
</div>
<%-- footer start --%>
<jsp:include page="/module/footer.jsp"/>
<%-- footer end --%>
</body>
</html>
