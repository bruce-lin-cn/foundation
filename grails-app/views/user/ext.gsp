
<%@ page import="platform.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:extjs />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}管理" /></title>
    
    </head>

    <script>
        Ext.onReady(function(){
            var cm = new Ext.grid.ColumnModel([
                        
                                {header:'${cgDomainProperties.id.chinese}',dataIndex:'id'} ,
                        
                                {header:'${cgDomainProperties.name.chinese}',dataIndex:'name'} ,
                        
                                {header:'${cgDomainProperties.mobile.chinese}',dataIndex:'mobile'} ,
                        
                                {header:'${cgDomainProperties.identityCardNum.chinese}',dataIndex:'identityCardNum'} ,
                        
                                {header:'${cgDomainProperties.dateCreated.chinese}',dataIndex:'dateCreated'} ,
                        
                                {header:'${cgDomainProperties.lastUpdated.chinese}',dataIndex:'lastUpdated'} 
                        
            ]);

            var data=[
                    <g:each in="${userInstanceList}" status="i" var="userInstance">
                        [
                        
                        '${fieldValue(bean: userInstance, field: "id")}' ,
                        
                        '${fieldValue(bean: userInstance, field: "name")}' ,
                        
                        '${fieldValue(bean: userInstance, field: "mobile")}' ,
                        
                        '${fieldValue(bean: userInstance, field: "identityCardNum")}' ,
                        
                        '${fieldValue(bean: userInstance, field: "dateCreated")}' ,
                        
                        '${fieldValue(bean: userInstance, field: "lastUpdated")}' 
                        
                        ] <g:if test="${userInstanceList.size() > i +1}">, </g:if>

                    </g:each>
             ];

            var store= new Ext.data.Store({
                proxy: new Ext.data.MemoryProxy(data),
                reader: new Ext.data.ArrayReader({},[
                        
                                {name:'id'} ,
                        
                                {name:'name'} ,
                        
                                {name:'mobile'} ,
                        
                                {name:'identityCardNum'} ,
                        
                                {name:'dateCreated'} ,
                        
                                {name:'lastUpdated'} 
                        
                ])
            });

            store.load();

            var grid= new Ext.grid.GridPanel({
                renderTo: 'grid',
                store: store,
                enableColumnMove:false,
                enableColumnResize:false,
                stripeRows:true,
                loadMask:true,
                cm: cm,
                height: 200,

                viewConfig: {
                    forceFit:true
                }
            });
        });
    </script>
    <body>
        <div class="body">
            <h1>${entityName}列表</h1>
            <div id="grid"></div>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
        </div>
    </body>
</html>
