<%@ page import="com.ezen.board.dao.JdbcArticleDao" %>
<%@ page import="com.ezen.board.dao.ArticleDao" %>
<%@ page import="com.ezen.board.service.BoardService" %>
<%@ page import="com.ezen.board.service.BoardServiceImpl" %>
<%@ page import="com.ezen.board.dto.Article" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("utf-8");
    String articleNum = request.getParameter("articleNum");
    String boardNum = request.getParameter("boardNum");

    BoardService boardService = new BoardServiceImpl();
    boolean  result = boardService.removeArticle(Integer.parseInt(boardNum), Integer.parseInt(articleNum));
    if(result){
        response.sendRedirect("/board/board.jsp");
    }else{
    }
%>