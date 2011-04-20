<%@ page import="business.Department" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:extjs />
        <title><g:message code="部门管理" /></title>
    </head>
    <script>
Ext.onReady(function(){
    Ext.QuickTips.init();

    var departmentCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/department/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '部门名称',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '部门名称为必填项', maxLength: 32, maxLengthText: '部门名称至多包含32个字符', minLength: 2, minLengthText: '部门名称至少包含2个字符'}        ]
    });

    var departmentCreateWin = new Ext.Window({
        el: 'departmentCreateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '创建部门',
        height: 300,
        closeAction: 'hide',
        items: [departmentCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    departmentCreateForm.getForm().submit({
                        success:function(departmentCreateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            departmentCreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "创建部门失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    departmentCreateWin.hide();
                }
            }
        ]
    });

    var departmentUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/department/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '部门名称',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '部门名称为必填项', maxLength: 32, maxLengthText: '部门名称至多包含32个字符', minLength: 2, minLengthText: '部门名称至少包含2个字符'}
        ]
    });

    var departmentUpdateWin = new Ext.Window({
        el: 'departmentUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改部门',
        height: 300,
        closeAction: 'hide',
        items: [departmentUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    departmentUpdateForm.getForm().submit({
                        success:function(departmentUpdateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            departmentUpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "更新部门失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    departmentUpdateWin.hide();
                }
            }
        ]
    });

    var departmentDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/department/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '部门名称',name: 'name',xtype: 'textfield', readOnly:true}
        ]
    });

    var departmentDetailWin = new Ext.Window({
        el: 'departmentDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '部门明细',
        height: 300,
        closeAction: 'hide',
        items: [departmentDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    departmentDetailWin.hide();
                }
            }
        ]
    });

    var tb = new Ext.Toolbar();
    tb.render('departmentToolbar');

    tb.add({
        text: '新建',
        icon: '/foundation/images/skin/database_add.png',
        handler:function() {
            departmentCreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/foundation/images/skin/database_edit.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.foundation.msg('注意', "请选择要修改的记录");
            }else{
                departmentUpdateForm.getForm().load({
                    url:'/foundation/department/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.foundation.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
                departmentUpdateWin.show();
            }
        }
    }, {
        text: '删除',
        icon: '/foundation/images/skin/database_delete.png',
        handler: function() {
            var count = sm.getCount();
            if (count == 0) {
                Ext.foundation.msg('注意', "请选择要删除的记录");
            } else {
                var records = sm.getSelections();
                var id = [];
                for (var i = 0; i < count; i++) {
                    id.push(records[i].id);
                }
                Ext.MessageBox.confirm('信息', '您确定删除编号为' + id + '的记录吗?', function(btn) {
                    if (btn == 'yes') {
                        Ext.Ajax.request({
                            url: '/foundation/department/deleteJSON',
                            params: {id:id},
                            success: function(result) {
                                var json_str = Ext.util.JSON.decode(result.responseText);
                                Ext.foundation.msg('信息', json_str.msg);
                                store.reload();
                            },
                            failure:function() {
                                Ext.foundation.msg('错误', '服务器出现错误，稍后再试!');
                            }
                        });
                    }
                });

            }
        }
    }, {
        text: '详细',
        icon: '/foundation/images/skin/database_save.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.foundation.msg('注意', "请选择要显示的记录");
            }else{
                departmentDetailForm.getForm().load({
                    url:'/foundation/department/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.foundation.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
                departmentDetailWin.show();
            }
        }
    },{
        text: '导入',
        icon: '/foundation/images/skin/database_add.png',
        handler:function() {

        }
    },{
        text: '更多',
        icon: '/foundation/images/skin/database_add.png',
        handler:function() {

        }
    }, '->',
    {
        xtype: 'textfield',
        name: 'searchBar',
        emptyText: '请输入搜索条件'
    }, {
        text: '搜索',
        icon: '/foundation/images/skin/database_search.png',
        handler: function() {
        }
    });

    tb.doLayout();

    var sm = new Ext.grid.CheckboxSelectionModel()
    var cm = new Ext.grid.ColumnModel([
        sm,
        {header:'编号',dataIndex:'id'} ,
        {header:'部门名称',dataIndex:'name'} 
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/foundation/department/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [
            {name:'id'  } ,
            {name:'name'  } 
        ])
    });

    var grid = new Ext.grid.GridPanel({
        renderTo: 'departmentGrid',
        store: store,
        enableColumnMove:false,
        enableColumnResize:true,
        stripeRows:true,
        enableHdMenu: false,
        trackMouseOver: true,
        loadMask:true,
        cm: cm,
        sm: sm,
        height: 270,
        viewConfig: {
            forceFit:true
        },

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
        var id = (grid.getSelectionModel().getSelected()).id;
        if (id == null) {
            Ext.foundation.msg('注意', "请选择要修改的记录");
        } else {
            departmentUpdateForm.getForm().load({
                url:'/foundation/department/detailJSON?id=' + id,
                success:function(form, action) {
                },
                failure:function() {
                    Ext.foundation.msg('错误', "服务器出现错误，稍后再试!");
                }
            });

            departmentUpdateWin.show();
        }
    });
});
    </script>
    <body>
        <div id="departmentToolbar"></div>
        <div id="departmentGrid"></div>
        <div id="departmentCreateWin"></div>
        <div id="departmentUpdateWin"></div>
        <div id="departmentDetailWin"></div>
    </body>
</html>
