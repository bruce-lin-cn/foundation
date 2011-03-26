

<%@ page import="business.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:extjs />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}管理" /></title>
    
    </head>

    <script>
        Ext.onReady(function(){

            var customerForm = new Ext.form.FormPanel({
                labelAlign: 'right',
                labelWidth: 50,
                frame: true,
                url: '/foundation/customer/createJSON',
                defaultType: 'textfield',
                items: [
                    
                    {fieldLabel: '${cgDomainProperties.name.chinese}',name: 'name',xtype: 'textfield'},
                    {fieldLabel: '${cgDomainProperties.mobile.chinese}',name: 'mobile',xtype: 'textfield'},
                    {fieldLabel: '${cgDomainProperties.identityCardNum.chinese}',name: 'identityCardNum',xtype: 'textfield'},
                    {fieldLabel: '${cgDomainProperties.level.chinese}',name: 'level',xtype: 'textfield'},
                    {fieldLabel: '${cgDomainProperties.balance.chinese}',name: 'balance',xtype: 'textfield'}
                ]
            });

            var customerWin = new Ext.Window({
                el: 'customerWin',
                closable:false,
                layout: 'fit',
                width: 400,
                title: '创建${entityName}',
                height: 300,
                closeAction: 'hide',
                items: [customerForm],
                buttons: [{
                    text:'创建',
                    handler: function(){
                        customerForm.getForm().submit({
                            success:function(customerForm, action){
                                customerWin.hide(this);
                                Ext.Msg.alert('信息',action.result.msg);
                                store.reload();
                                },
                            failure:function(){
                                Ext.Msg.alert('信息',"创建${entityName}失败!");}
                        });
                    }
                },{
                    text: '取 消',
                    handler: function(){
                        customerWin.hide();
                    }
                }]
            });

            var tb = new Ext.Toolbar();
            tb.render('toolbar');

            tb.add({
                text: '新建',
                icon: '/foundation/images/skin/database_add.png',
                handler:function(){
                    customerWin.show(this);
                }
            },{
                text: '修改',
                icon: '/foundation/images/skin/database_edit.png'
            },{
                text: '删除',
                icon: '/foundation/images/skin/database_delete.png',
                handler: function(){
                    var id = (grid.getSelectionModel().getSelected()).id;
                    if (id){
                        Ext.Ajax.request({
                            url: '/foundation/customer/deleteJSON?id='+id,
                            success: function(result){
                                var json_str = Ext.util.JSON.decode(result.responseText);
                                Ext.Msg.alert('信息',json_str.msg);
                                    store.reload();
                            },
                            failure:function(){
                                //Ext.Msg.alert('信息','服务器出现错误，稍后再试!');
                            }
                        });
                    }
                }
            },{
                text: '详细',
                icon: '/foundation/images/skin/database_save.png'
            },
            '->',
            {
                xtype: 'textfield',
                name: 'searchBar',
                emptyText: '请输入搜索条件'
            },{
                text: '搜索',
                icon: '/foundation/images/skin/database_search.png'
            });

            tb.doLayout();

            var cbsm= new Ext.grid.CheckboxSelectionModel({singleSelect:false})
            var cm = new Ext.grid.ColumnModel([
            cbsm,
                {header:'${cgDomainProperties.id.chinese}',dataIndex:'id'} ,
                {header:'${cgDomainProperties.name.chinese}',dataIndex:'name'} ,
                {header:'${cgDomainProperties.mobile.chinese}',dataIndex:'mobile'} ,
                {header:'${cgDomainProperties.identityCardNum.chinese}',dataIndex:'identityCardNum'} ,
                {header:'${cgDomainProperties.level.chinese}',dataIndex:'level'} ,
                {header:'${cgDomainProperties.balance.chinese}',dataIndex:'balance'} ,
                {header:'${cgDomainProperties.dateCreated.chinese}',dataIndex:'dateCreated'} ,
                {header:'${cgDomainProperties.lastUpdated.chinese}',dataIndex:'lastUpdated'} 
            ]);

            var store= new Ext.data.Store({
                autoLoad:true,
                proxy: new Ext.data.HttpProxy({url:'/foundation/customer/listJSON'}),
                reader: new Ext.data.JsonReader({
                    totalProperty:'total',
                    root:'root'
                },[
                    {name:'id'},
                    {name:'name'},
                    {name:'mobile'},
                    {name:'identityCardNum'},
                    {name:'level'},
                    {name:'balance'},
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
        <div id="toolbar"></div>
        <div id="grid"></div>
        <div id="customerWin">
            <div id="grid"></div>
        </div>
    </body>
</html>
