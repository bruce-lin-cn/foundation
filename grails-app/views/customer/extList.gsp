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
    Ext.QuickTips.init();

    var customerCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/customer/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '${cgDomainProperties.name.chinese}',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '${cgDomainProperties.name.chinese}为必填项', maxLength: 32, maxLengthText: '${cgDomainProperties.name.chinese}至多包含32个字符', minLength: 2, minLengthText: '${cgDomainProperties.name.chinese}至少包含2个字符',msgTarget: 'under'},
            {fieldLabel: '${cgDomainProperties.gender.chinese}',name: 'gender',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['男'],['女']]}), emptyText:'请选择${cgDomainProperties.gender.chinese}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '${cgDomainProperties.mobile.chinese}',name: 'mobile',xtype: 'textfield', allowBlank: false, blankText: '${cgDomainProperties.mobile.chinese}为必填项', maxLength: 11, maxLengthText: '${cgDomainProperties.mobile.chinese}至多包含11个字符', minLength: 11, minLengthText: '${cgDomainProperties.mobile.chinese}至少包含11个字符'},
            {fieldLabel: '${cgDomainProperties.identityCardNum.chinese}',name: 'identityCardNum',xtype: 'textfield', maxLength: 18, maxLengthText: '${cgDomainProperties.identityCardNum.chinese}至多包含18个字符', minLength: 18, minLengthText: '${cgDomainProperties.identityCardNum.chinese}至少包含18个字符'},
            {fieldLabel: '${cgDomainProperties.level.chinese}',name: 'level',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['普通'],['高级'],['VIP']]}), emptyText:'请选择${cgDomainProperties.level.chinese}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '${cgDomainProperties.balance.chinese}',name: 'balance',xtype: 'textfield'},
            {fieldLabel: '${cgDomainProperties.birthday.chinese}',name: 'birthday',xtype:'datefield',format:'c'}
        ],

        autoScroll: true
    });

    var customerCreateWin = new Ext.Window({
        el: 'customerCreateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '创建${entityName}',
        height: 300,
        closeAction: 'hide',
        items: [customerCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    customerCreateForm.getForm().submit({
                        success:function(customerCreateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            customerCreateWin.hide();
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
                    customerCreateWin.hide();
                }
            }
        ]
    });

    var customerUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/customer/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '${cgDomainProperties.name.chinese}',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '${cgDomainProperties.name.chinese}为必填项', maxLength: 32, maxLengthText: '${cgDomainProperties.name.chinese}至多包含32个字符', minLength: 2, minLengthText: '${cgDomainProperties.name.chinese}至少包含2个字符'},
            {fieldLabel: '${cgDomainProperties.gender.chinese}',name: 'gender',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['男'],['女']]}), emptyText:'请选择${cgDomainProperties.gender.chinese}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '${cgDomainProperties.mobile.chinese}',name: 'mobile',xtype: 'textfield', allowBlank: false, blankText: '${cgDomainProperties.mobile.chinese}为必填项', maxLength: 11, maxLengthText: '${cgDomainProperties.mobile.chinese}至多包含11个字符', minLength: 11, minLengthText: '${cgDomainProperties.mobile.chinese}至少包含11个字符'},
            {fieldLabel: '${cgDomainProperties.identityCardNum.chinese}',name: 'identityCardNum',xtype: 'textfield', maxLength: 18, maxLengthText: '${cgDomainProperties.identityCardNum.chinese}至多包含18个字符', minLength: 18, minLengthText: '${cgDomainProperties.identityCardNum.chinese}至少包含18个字符'},
            {fieldLabel: '${cgDomainProperties.level.chinese}',name: 'level',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['普通'],['高级'],['VIP']]}), emptyText:'请选择${cgDomainProperties.level.chinese}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '${cgDomainProperties.balance.chinese}',name: 'balance',xtype: 'textfield'},
            {fieldLabel: '${cgDomainProperties.birthday.chinese}',name: 'birthday',xtype:'datefield',format:'c'}
        ]
    });

    var customerUpdateWin = new Ext.Window({
        el: 'customerUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改${entityName}',
        height: 300,
        closeAction: 'hide',
        items: [customerUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    customerUpdateForm.getForm().submit({
                        success:function(customerUpdateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            customerUpdateWin.hide();
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
                    customerUpdateWin.hide();
                }
            }
        ]
    });

    var customerDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/customer/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},

            {fieldLabel: '${cgDomainProperties.name.chinese}',name: 'name',readOnly: true, xtype: 'textfield'},
            {fieldLabel: '${cgDomainProperties.gender.chinese}',name: 'gender',readOnly: true, xtype: 'textfield'},
            {fieldLabel: '${cgDomainProperties.mobile.chinese}',name: 'mobile',readOnly: true, xtype: 'textfield'},
            {fieldLabel: '${cgDomainProperties.identityCardNum.chinese}',name: 'identityCardNum',readOnly: true, xtype: 'textfield'},
            {fieldLabel: '${cgDomainProperties.level.chinese}',name: 'level',readOnly: true, xtype: 'textfield'},
            {fieldLabel: '${cgDomainProperties.balance.chinese}',name: 'balance',readOnly: true, xtype: 'textfield'},
            {fieldLabel: '${cgDomainProperties.birthday.chinese}',name: 'birthday',readOnly: true, xtype: 'datefield',format:'c',renderer: Ext.util.Format.dateRenderer('Y年m月d H:i:s')},
            {fieldLabel: '${cgDomainProperties.dateCreated.chinese}',name: 'dateCreated',readOnly: true, xtype: 'datefield',format:'c',renderer: Ext.util.Format.dateRenderer('Y年m月d H:i:s')},
            {fieldLabel: '${cgDomainProperties.lastUpdated.chinese}',name: 'lastUpdated',readOnly: true, xtype: 'datefield',format:'c',renderer: Ext.util.Format.dateRenderer('Y年m月d H:i:s')}
        ]
    });

    var customerDetailWin = new Ext.Window({
        el: 'customerDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '${entityName}明细',
        height: 300,
        closeAction: 'hide',
        items: [customerDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    customerDetailWin.hide();
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
            customerCreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/foundation/images/skin/database_edit.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            customerUpdateForm.getForm().load({
                url:'/foundation/customer/detailJSON?id=' + id,
                success:function(form, action) {
                },
                failure:function() {
                    Ext.foundation.msg('错误', "服务器出现错误，稍后再试!");
                }
            });

            customerUpdateWin.show();
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
                Ext.MessageBox.confirm('信息', '您确定删除' + id + '记录?', function(btn) {
                    if (btn == 'yes') {
                        Ext.Ajax.request({
                            url: '/foundation/customer/deleteJSON',
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
            customerDetailForm.getForm().load({
                url:'/foundation/customer/detailJSON?id=' + id,
                success:function(form, action) {
                },
                failure:function() {
                    Ext.foundation.msg('错误', '服务器出现错误，稍后再试!');
                }
            });
            customerDetailWin.show();
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
        {header:'${cgDomainProperties.mobile.chinese}',dataIndex:'mobile'} ,
        {header:'${cgDomainProperties.identityCardNum.chinese}',dataIndex:'identityCardNum'} ,
        {header:'${cgDomainProperties.level.chinese}',dataIndex:'level'} ,
        {header:'${cgDomainProperties.balance.chinese}',dataIndex:'balance'} ,
        {header:'${cgDomainProperties.birthday.chinese}',dataIndex:'birthday', type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d H:i:s')} ,
        {header:'${cgDomainProperties.dateCreated.chinese}',dataIndex:'dateCreated', type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d H:i:s')} ,
        {header:'${cgDomainProperties.lastUpdated.chinese}',dataIndex:'lastUpdated', type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d H:i:s')}
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/foundation/customer/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [

            {name:'id'  } ,
            {name:'name'  } ,
            {name:'gender'  } ,
            {name:'mobile'  } ,
            {name:'identityCardNum'  } ,
            {name:'level'  } ,
            {name:'balance'  } ,
            {name:'birthday' , type:'date', dateFormat:'c' } ,
            {name:'dateCreated' , type:'date', dateFormat:'c' } ,
            {name:'lastUpdated' , type:'date', dateFormat:'c' }
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
});
    </script>
    <body>
        <div id="toolbar"></div>
        <div id="grid"></div>
        <div id="customerCreateWin"></div>
        <div id="customerUpdateWin"></div>
        <div id="customerDetailWin"></div>
    </body>
</html>
