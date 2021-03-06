
<%@ page import="platform.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}明细" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">首页</a></span>
            <span class="menuButton"><g:link class="list" action="list">${entityName}列表</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">${entityName}新建</g:link></span>
        </div>
        <div class="body">
            <h1>${entityName}明细</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${cgDomainProperties.id.chinese}</td>
                            
                            <td valign="center" class="value">${fieldValue(bean: userInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${cgDomainProperties.name.chinese}</td>
                            
                            <td valign="center" class="value">${fieldValue(bean: userInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${cgDomainProperties.mobile.chinese}</td>
                            
                            <td valign="center" class="value">${fieldValue(bean: userInstance, field: "mobile")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${cgDomainProperties.identityCardNum.chinese}</td>
                            
                            <td valign="center" class="value">${fieldValue(bean: userInstance, field: "identityCardNum")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${cgDomainProperties.dateCreated.chinese}</td>
                            
                            <td valign="center" class="value"><g:formatDate date="${userInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${cgDomainProperties.lastUpdated.chinese}</td>
                            
                            <td valign="center" class="value"><g:formatDate date="${userInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${userInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="编辑" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="删除" onclick="return confirm('您确定吗')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
