
<%@ page import="business.Book" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}管理" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">首页</a></span>
            <span class="menuButton"><g:link class="create" action="create">新建${entityName}</g:link></span>
        </div>
        <div class="body">
            <h1>${entityName}列表</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${cgDomainProperties.id.chinese}" />
                        
                            <g:sortableColumn property="string1" title="${cgDomainProperties.string1.chinese}" />
                        
                            <g:sortableColumn property="string2" title="${cgDomainProperties.string2.chinese}" />
                        
                            <g:sortableColumn property="date1" title="${cgDomainProperties.date1.chinese}" />
                        
                            <g:sortableColumn property="ingeger1" title="${cgDomainProperties.ingeger1.chinese}" />
                        
                            <g:sortableColumn property="float1" title="${cgDomainProperties.float1.chinese}" />
                        
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
