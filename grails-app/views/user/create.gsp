

<%@ page import="platform.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}创建" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">首页</a></span>
            <span class="menuButton"><g:link class="list" action="list">${entityName}列表</g:link></span>
        </div>
        <div class="body">
            <h1>创建${entityName}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">${cgDomainProperties.name.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${userInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mobile">${cgDomainProperties.mobile.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'mobile', 'errors')}">
                                    <g:textField name="mobile" value="${userInstance?.mobile}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="identityCardNum">${cgDomainProperties.identityCardNum.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'identityCardNum', 'errors')}">
                                    <g:textField name="identityCardNum" value="${userInstance?.identityCardNum}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="创建" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
