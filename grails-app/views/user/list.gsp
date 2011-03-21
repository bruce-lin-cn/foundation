
<%@ page import="platform.User" %>
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
                        
                            <g:sortableColumn property="name" title="${cgDomainProperties.name.chinese}" />
                        
                            <g:sortableColumn property="mobile" title="${cgDomainProperties.mobile.chinese}" />
                        
                            <g:sortableColumn property="identityCardNum" title="${cgDomainProperties.identityCardNum.chinese}" />
                        
                            <g:sortableColumn property="dateCreated" title="${cgDomainProperties.dateCreated.chinese}" />
                        
                            <g:sortableColumn property="lastUpdated" title="${cgDomainProperties.lastUpdated.chinese}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userInstanceList}" status="i" var="userInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: userInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: userInstance, field: "mobile")}</td>
                        
                            <td>${fieldValue(bean: userInstance, field: "identityCardNum")}</td>
                        
                            <td><g:formatDate date="${userInstance.dateCreated}" /></td>
                        
                            <td><g:formatDate date="${userInstance.lastUpdated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${userInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
