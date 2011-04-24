<%@ page import="business.DepartmentEmployee" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><g:message code="模型管理" /></title>
    </head>
    <script>
Ext.onReady(function(){
    Ext.QuickTips.init();

    var departmentEmployeeCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/departmentEmployee/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '部门',hiddenName: 'department',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'department',emptyText:'请选择部门', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/department/associationListJSON', fields:['id', 'department'],  root: 'root', totalProperty: 'total'})},
            {fieldLabel: '员工',hiddenName: 'employee',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'employee',emptyText:'请选择员工', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/employee/associationListJSON', fields:['id', 'employee'],  root: 'root', totalProperty: 'total'})}        ]
    });

    var departmentEmployeeCreateWin = new Ext.Window({
        el: 'departmentEmployeeCreateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '创建模型',
        height: 300,
        closeAction: 'hide',
        items: [departmentEmployeeCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    departmentEmployeeCreateForm.getForm().submit({
                        success:function(departmentEmployeeCreateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            departmentEmployeeCreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "创建模型失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    departmentEmployeeCreateWin.hide();
                }
            }
        ]
    });

    var departmentEmployeeUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/departmentEmployee/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '部门',hiddenName: 'department',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'department',emptyText:'请选择部门', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/department/associationListJSON', fields:['id', 'department'],  root: 'root', totalProperty: 'total'})},
            {fieldLabel: '员工',hiddenName: 'employee',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'employee',emptyText:'请选择员工', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/employee/associationListJSON', fields:['id', 'employee'],  root: 'root', totalProperty: 'total'})}
        ]
    });

    var departmentEmployeeUpdateWin = new Ext.Window({
        el: 'departmentEmployeeUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改模型',
        height: 300,
        closeAction: 'hide',
        items: [departmentEmployeeUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    departmentEmployeeUpdateForm.getForm().submit({
                        success:function(departmentEmployeeUpdateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            departmentEmployeeUpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "更新模型失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    departmentEmployeeUpdateWin.hide();
                }
            }
        ]
    });

    var departmentEmployeeDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/departmentEmployee/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '部门',hiddenName: 'department',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'department',emptyText:'请选择部门', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/department/associationListJSON', fields:['id', 'department'],  root: 'root', totalProperty: 'total'}), readOnly:true},
            {fieldLabel: '员工',hiddenName: 'employee',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'employee',emptyText:'请选择员工', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/employee/associationListJSON', fields:['id', 'employee'],  root: 'root', totalProperty: 'total'}), readOnly:true}
        ]
    });

    var departmentEmployeeDetailWin = new Ext.Window({
        el: 'departmentEmployeeDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '模型明细',
        height: 300,
        closeAction: 'hide',
        items: [departmentEmployeeDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    departmentEmployeeDetailWin.hide();
                }
            }
        ]
    });

    var tb = new Ext.Toolbar();
    tb.render('toolbar');

    tb.add({
        text: '新建',
        icon: '/foundation/images/skin/database_add.png',
        handler:function() {
            departmentEmployeeCreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/foundation/images/skin/database_edit.png',
        handler: function() {
           updateDepartmentEmployee();
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
                            url: '/foundation/departmentEmployee/deleteJSON',
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
                departmentEmployeeDetailForm.getForm().load({
                    url:'/foundation/departmentEmployee/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.foundation.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
                departmentEmployeeDetailWin.show();
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
        {header:'部门',dataIndex:'department'},
        {header:'员工',dataIndex:'employee'}
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/foundation/departmentEmployee/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [
            {name:'id'  } ,
            {name:'department'},
            {name:'employee'}
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
        updateDepartmentEmployee();
    });

    function updateDepartmentEmployee()
    {
        var id = (grid.getSelectionModel().getSelected()).id;
        if (id == null) {
            Ext.foundation.msg('注意', "请选择要修改的记录");
        } else {
            departmentEmployeeUpdateForm.getForm().load({
                url:'/foundation/departmentEmployee/detailJSON?id=' + id,
                success:function(form, action) {
                    departmentEmployeeUpdateWin.show();
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
        <div id="toolbar"></div>
        <div id="grid"></div>
        <div id="departmentEmployeeCreateWin"></div>
        <div id="departmentEmployeeUpdateWin"></div>
        <div id="departmentEmployeeDetailWin"></div>
    </body>
</html>
