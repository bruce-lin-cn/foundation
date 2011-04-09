
<%@ page import="business.Book" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'book.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="string1" title="${message(code: 'book.string1.label', default: 'String1')}" />
                        
                            <g:sortableColumn property="string2" title="${message(code: 'book.string2.label', default: 'String2')}" />
                        
                            <g:sortableColumn property="date1" title="${message(code: 'book.date1.label', default: 'Date1')}" />
                        
                            <g:sortableColumn property="ingeger1" title="${message(code: 'book.ingeger1.label', default: 'Ingeger1')}" />
                        
                            <g:sortableColumn property="float1" title="${message(code: 'book.float1.label', default: 'Float1')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${bookInstanceList}" status="i" var="bookInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${bookInstance.id}">${fieldValue(bean: bookInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: bookInstance, field: "string1")}</td>
                        
                            <td>${fieldValue(bean: bookInstance, field: "string2")}</td>
                        
                            <td><g:formatDate date="${bookInstance.date1}" /></td>
                        
                            <td>${fieldValue(bean: bookInstance, field: "ingeger1")}</td>
                        
                            <td>${fieldValue(bean: bookInstance, field: "float1")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${bookInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
