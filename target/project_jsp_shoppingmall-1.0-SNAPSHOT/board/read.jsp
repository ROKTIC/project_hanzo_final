<%@ page import="com.ezen.board.dto.Article" %>
<%@ page import="com.ezen.board.service.BoardServiceImpl" %>
<%@ page import="com.ezen.board.service.BoardService" %>
<%@ page import="com.ezen.board.dto.ArticleComment" %>
<%@ page import="com.ezen.board.dao.JdbcArticleDao" %>
<%@ page import="java.util.List" %>
<%--게시글 읽기 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty loginMember}">
    <c:set scope="request" var="message" value="게시판 글읽기는 회원만 가능합니다!"/>
    <c:set var="referer" value="/board/board.jsp" scope="request"/>
    <jsp:forward page="/member/login.jsp"/>
</c:if>
<%
    request.setCharacterEncoding("utf-8");
//    Member user = (Member) session.getAttribute("loginMember");
//    String userid = user.getId();

    String articleNum = request.getParameter("articleNum");
    String boardNum = request.getParameter("boardNum");

    BoardService boardService = new BoardServiceImpl();
    Article article = boardService.getReadArticle(Integer.parseInt(articleNum), Integer.parseInt(boardNum));

    request.setAttribute("article", article);

    JdbcArticleDao jdao = new JdbcArticleDao();

    int an = jdao.findByReplyCount(Integer.parseInt(articleNum));
    List<ArticleComment> acList = jdao.commentListAll(articleNum);
    pageContext.setAttribute("acList", acList);

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
                <div class="title" readonly>
                    <h4>${article.articleTitle}</h4>
                </div>
                <div class="blog-profile">
                    <div class="blog-profile_text" readonly>
                        <h4>${article.userId}</h4>
                    </div>
                </div>
                <div class="blog-text">
                    <div class="blog-content" readonly>
                        <p>${article.articleContent}</p>
                    </div>
                    <div class="blog-share-reply">
                        <p>댓글(<%=an%>)</p>
<%--                        <button type="submit" class="delete-btn">게시글 삭제</button>--%>
                    </div>
                    <div class="reply-table">
                        <c:if test="${not empty acList}">
                            <c:forEach var="ac" items="${acList}" varStatus="loop">
                                <c:set var="no">
                                    <scope>request</scope>
                                </c:set>
                                <div>
                                    <span class="reply-id">${ac.userId}</span>
                                    |
                                    <span class="reply-text">${ac.commentContent}</span>
                                </div>
                            </c:forEach>
                        </c:if>
                        <div class="reply-add">
                            <form class="add" action="read-action.jsp" method="post">
                                <input name="articleNum" value="${article.articleNum}" style="opacity: 0;width: 0px;">
                                <input class="reply-input" name="reply-input">
                                <input name="boardNum" value="${article.boardNum}" style="opacity: 0;width: 0px;">
                                <button type="submit" class="reply-btn">작성</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<%-- footer start --%>
<jsp:include page="/module/footer.jsp"/>
<%-- footer end --%>
</body>
</html>