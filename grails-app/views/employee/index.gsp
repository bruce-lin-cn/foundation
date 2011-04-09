<%@ page import="business.Employee" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:extjs />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}管理" /></title>
    </head>
    <script>
Ext.onReady(function(){
    Ext.QuickTips.init();

    var employeeCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/employee/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '${cgDomainProperties.name.chinese}',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '${cgDomainProperties.name.chinese}为必填项', maxLength: 32, maxLengthText: '${cgDomainProperties.name.chinese}至多包含32个字符', minLength: 2, minLengthText: '${cgDomainProperties.name.chinese}至少包含2个字符'},
            {fieldLabel: '${cgDomainProperties.gender.chinese}',name: 'gender',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['男'],['女']]}), emptyText:'请选择${cgDomainProperties.gender.chinese}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '${cgDomainProperties.birthday.chinese}',name: 'birthday',xtype:'datefield',format:'Y-m-d'},
            {fieldLabel: '${cgDomainProperties.cgCompany}',hiddenName: 'company',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'company',emptyText:'请选择${cgDomainProperties.cgCompany}', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/company/associationListJSON', fields:['id', 'company'],  root: 'root', totalProperty: 'total'})}        ]
    });

    var employeeCreateWin = new Ext.Window({
        el: 'employeeCreateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '创建${entityName}',
        height: 300,
        closeAction: 'hide',
        items: [employeeCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    employeeCreateForm.getForm().submit({
                        success:function(employeeCreateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            employeeCreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "创建${entityName}失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    employeeCreateWin.hide();
                }
            }
        ]
    });

    var employeeUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/employee/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '${cgDomainProperties.name.chinese}',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '${cgDomainProperties.name.chinese}为必填项', maxLength: 32, maxLengthText: '${cgDomainProperties.name.chinese}至多包含32个字符', minLength: 2, minLengthText: '${cgDomainProperties.name.chinese}至少包含2个字符'},
            {fieldLabel: '${cgDomainProperties.gender.chinese}',name: 'gender',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['男'],['女']]}), emptyText:'请选择${cgDomainProperties.gender.chinese}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '${cgDomainProperties.birthday.chinese}',name: 'birthday',xtype:'datefield',format:'Y-m-d'},
            {fieldLabel: '${cgDomainProperties.cgCompany}',hiddenName: 'company',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'company',emptyText:'请选择${cgDomainProperties.cgCompany}', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/company/associationListJSON', fields:['id', 'company'],  root: 'root', totalProperty: 'total'})}
        ]
    });

    var employeeUpdateWin = new Ext.Window({
        el: 'employeeUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改${entityName}',
        height: 300,
        closeAction: 'hide',
        items: [employeeUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    employeeUpdateForm.getForm().submit({
                        success:function(employeeUpdateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            employeeUpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "更新${entityName}失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    employeeUpdateWin.hide();
                }
            }
        ]
    });

    var employeeDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/employee/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '${cgDomainProperties.name.chinese}',name: 'name',xtype: 'textfield', readOnly:true},
            {fieldLabel: '${cgDomainProperties.gender.chinese}',name: 'gender',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['男'],['女']]}), readOnly:true, emptyText:'请选择${cgDomainProperties.gender.chinese}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '${cgDomainProperties.birthday.chinese}',name: 'birthday',xtype:'datefield',format:'Y-m-d', readOnly:true},
            {fieldLabel: '${cgDomainProperties.cgCompany}',hiddenName: 'company',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'company',emptyText:'请选择${cgDomainProperties.cgCompany}', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/company/associationListJSON', fields:['id', 'company'],  root: 'root', totalProperty: 'total'}), readOnly:true}
        ]
    });

    var employeeDetailWin = new Ext.Window({
        el: 'employeeDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '${entityName}明细',
        height: 300,
        closeAction: 'hide',
        items: [employeeDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    employeeDetailWin.hide();
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
            employeeCreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/foundation/images/skin/database_edit.png',
        handler: function() {
           updateEmployee();
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
                            url: '/foundation/employee/deleteJSON',
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
                employeeDetailForm.getForm().load({
                    url:'/foundation/employee/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.foundation.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
                employeeDetailWin.show();
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
    }
            );

    tb.doLayout();

    var sm = new Ext.grid.CheckboxSelectionModel()
    var cm = new Ext.grid.ColumnModel([
        sm,
        {header:'${cgDomainProperties.id.chinese}',dataIndex:'id'} ,
        {header:'${cgDomainProperties.name.chinese}',dataIndex:'name'} ,
        {header:'${cgDomainProperties.gender.chinese}',dataIndex:'gender'} ,
        {header:'${cgDomainProperties.birthday.chinese}',dataIndex:'birthday', type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d')} ,
        {header:'${cgDomainProperties.cgCompany}',dataIndex:'company'}
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/foundation/employee/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [
            {name:'id'  } ,
            {name:'name'  } ,
            {name:'gender'  } ,
            {name:'birthday' , type:'date', dateFormat:'c' } ,
            {name:'company'}
            
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
        updateEmployee();
    });

    function updateEmployee()
    {
        var id = (grid.getSelectionModel().getSelected()).id;
        if (id == null) {
            Ext.foundation.msg('注意', "请选择要修改的记录");
        } else {
            employeeUpdateForm.getForm().load({
                url:'/foundation/employee/detailJSON?id=' + id,
                success:function(form, action) {
                },
                failure:function() {
                    Ext.foundation.msg('错误', "服务器出现错误，稍后再试!");
                }
            });

            employeeUpdateWin.show();
        }
    }

});
    </script>
    <body>
        <div id="toolbar"></div>
        <div id="grid"></div>
        <div id="employeeCreateWin"></div>
        <div id="employeeUpdateWin"></div>
        <div id="employeeDetailWin"></div>
    </body>
</html>
