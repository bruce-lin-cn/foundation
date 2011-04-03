

<%@ page import="business.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}更新" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">首页</a></span>
            <span class="menuButton"><g:link class="list" action="list">${entityName}列表</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">${entityName}新建</g:link></span>
        </div>
        <div class="body">
            <h1>${entityName}编辑</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${customerInstance}">
            <div class="errors">
                <g:renderErrors bean="${customerInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${customerInstance?.id}" />
                <g:hiddenField name="version" value="${customerInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name">${cgDomainProperties.name.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="32" value="${customerInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="gender">${cgDomainProperties.gender.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'gender', 'errors')}">
                                    <g:select name="gender" from="${customerInstance.constraints.gender.inList}" value="${customerInstance?.gender}" valueMessagePrefix="customer.gender"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="mobile">${cgDomainProperties.mobile.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'mobile', 'errors')}">
                                    <g:textField name="mobile" maxlength="11" value="${customerInstance?.mobile}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="identityCardNum">${cgDomainProperties.identityCardNum.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'identityCardNum', 'errors')}">
                                    <g:textField name="identityCardNum" maxlength="18" value="${customerInstance?.identityCardNum}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="level">${cgDomainProperties.level.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'level', 'errors')}">
                                    <g:select name="level" from="${customerInstance.constraints.level.inList}" value="${customerInstance?.level}" valueMessagePrefix="customer.level"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="balance">${cgDomainProperties.balance.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'balance', 'errors')}">
                                    <g:textField name="balance" value="${customerInstance?.balance}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="birthday">${cgDomainProperties.birthday.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'birthday', 'errors')}">
                                    <g:datePicker name="birthday" chinese="生日" precision="day" value="${customerInstance?.birthday}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="更新" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="删除" onclick="return confirm('您确定吗?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
