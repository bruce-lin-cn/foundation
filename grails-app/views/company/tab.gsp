<%@ page import="business.Company" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><g:message code="公司管理" /></title>
    </head>
    <script>
Ext.onReady(function(){
    Ext.QuickTips.init();

    var companyCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/company/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '名称',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '名称为必填项', maxLength: 32, maxLengthText: '名称至多包含32个字符', minLength: 4, minLengthText: '名称至少包含4个字符'}        ]
    });

    var companyCreateWin = new Ext.Window({
        el: 'companyCreateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '创建公司',
        height: 300,
        closeAction: 'hide',
        items: [companyCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    companyCreateForm.getForm().submit({
                        success:function(companyCreateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            companyCreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "创建公司失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    companyCreateWin.hide();
                }
            }
        ]
    });

    var companyUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/company/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '名称',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '名称为必填项', maxLength: 32, maxLengthText: '名称至多包含32个字符', minLength: 4, minLengthText: '名称至少包含4个字符'}
        ]
    });

    var companyUpdateWin = new Ext.Window({
        el: 'companyUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改公司',
        height: 300,
        closeAction: 'hide',
        items: [companyUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    companyUpdateForm.getForm().submit({
                        success:function(companyUpdateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            companyUpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "更新公司失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    companyUpdateWin.hide();
                }
            }
        ]
    });

    var companyDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/company/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '名称',name: 'name',xtype: 'textfield', readOnly:true}
        ]
    });

    var companyDetailWin = new Ext.Window({
        el: 'companyDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '公司明细',
        height: 300,
        closeAction: 'hide',
        items: [companyDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    companyDetailWin.hide();
                }
            }
        ]
    });


    var sm = new Ext.grid.CheckboxSelectionModel()
    var cm = new Ext.grid.ColumnModel([
        sm,
        {header:'编号',dataIndex:'id'} ,
        {header:'名称',dataIndex:'name'}
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/foundation/company/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [
            {name:'id'  } ,
            {name:'name'  }
        ])
    });

    var grid = new Ext.grid.GridPanel({
        renderTo: 'grid',
        store: store,
        enableColumnMove:false,
        enableColumnResize:true,
        stripeRows:true,
        enableHdMenu: false,
        trackMouseOver: true,
        loadMask:true,
        cm: cm,
        sm: sm,
        viewConfig: {
            forceFit:true
        },
        height: 280,
        bbar: new Ext.PagingToolbar({
            pageSize: 10,
            store: store,
            displayInfo: true,
            displayMsg: '显示第{0}条到第{1}条记录, 共{2}条',
            emptyMsg: '没有记录'
        })
    });

    store.load({params:{start:0,limit:10}});
    grid.on('dblclick', function(e) {
        updateCompany();
    });

    function updateCompany()
    {
        var id = (grid.getSelectionModel().getSelected()).id;
        if (id == null) {
            Ext.foundation.msg('注意', "请选择要修改的记录");
        } else {
            companyUpdateForm.getForm().load({
                url:'/foundation/company/detailJSON?id=' + id,
                success:function(form, action) {
                    companyUpdateWin.show();
                },
                failure:function() {
                    Ext.foundation.msg('错误', "服务器出现错误，稍后再试!");
                }
            });
        }
    }

});
    </script>
    <body>
        <div id="grid"></div>
        <div id="companyCreateWin"></div>
        <div id="companyUpdateWin"></div>
        <div id="companyDetailWin"></div>
    </body>
</html>
