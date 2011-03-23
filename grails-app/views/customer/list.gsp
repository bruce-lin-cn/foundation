
<%@ page import="business.Customer" %>
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
                        
                            <g:sortableColumn property="level" title="${cgDomainProperties.level.chinese}" />
                        
                            <g:sortableColumn property="balance" title="${cgDomainProperties.balance.chinese}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${customerInstanceList}" status="i" var="customerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "mobile")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "identityCardNum")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "level")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "balance")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${customerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
