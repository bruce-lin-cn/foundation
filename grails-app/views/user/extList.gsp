
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
            var cbsm= new Ext.grid.CheckboxSelectionModel()
            var cm = new Ext.grid.ColumnModel([
            cbsm,
            
                {header:'${cgDomainProperties.id.chinese}',dataIndex:'id'} ,
                {header:'${cgDomainProperties.name.chinese}',dataIndex:'name'} ,
                {header:'${cgDomainProperties.mobile.chinese}',dataIndex:'mobile'} ,
                {header:'${cgDomainProperties.identityCardNum.chinese}',dataIndex:'identityCardNum'} ,
                {header:'${cgDomainProperties.dateCreated.chinese}',dataIndex:'dateCreated'} ,
                {header:'${cgDomainProperties.lastUpdated.chinese}',dataIndex:'lastUpdated'} 
            ]);

            //var data=[
            //        <g:each in="${userInstanceList}" status="i" var="userInstance">
            //            ['${fieldValue(bean: userInstance, field: "id")}','${fieldValue(bean: userInstance, field: "name")}','${fieldValue(bean: userInstance, field: "mobile")}','${fieldValue(bean: userInstance, field: "identityCardNum")}','${fieldValue(bean: userInstance, field: "dateCreated")}','${fieldValue(bean: userInstance, field: "lastUpdated")}']<g:if test="${userInstanceList.size() > i +1}">,</g:if>
            //        </g:each>
            // ];
       
            var store= new Ext.data.Store({
                autoLoad:true,
                proxy: new Ext.data.HttpProxy({url:'/foundation/user/listJSON'}),
                reader: new Ext.data.JsonReader({
                    totalProperty:'total',
                    root:'root'
                },[
                    {name:'id'},
                    {name:'name'},
                    {name:'mobile'},
                    {name:'identityCardNum'},
                    {name:'dateCreated'},
                    {name:'lastUpdated'}
                ])
            });

            var grid= new Ext.grid.GridPanel({
                renderTo: 'grid',
                store: store,
                enableColumnMove:false,
                enableColumnResize:false,
                stripeRows:true,
                loadMask:true,
                cm: cm,
                sm: new Ext.grid.RowSelectionModel({singleSelect:false}),
                autoHeight: true,

                viewConfig: {
                    forceFit:true
                },

                bbar: new Ext.PagingToolbar({
                    pageSize: 10,
                    store: store,
                    displayInfo: true,
                    displayMsg: '显示第{0}条到第{1}条记录, 共{2}条',
                    emptyMsg: "没有记录"
                })
            });

            store.load({params:{start:0,limit:10}});
        });
    </script>
    <body>
        <div id="grid"></div>
    </body>
</html>
