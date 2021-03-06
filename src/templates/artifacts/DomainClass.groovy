/*************************************************
Copyright by clinking.org, all rights reserved.
**************************************************
Domain class: @artifact.name@
Author: bruce_lin_chn@126.com
Date: @date@

Function:

Note:
    1) Domain名称必须大于1个字符
    2) 定义包含其他Domain的关联变量必须是模型名称的首字母小写格式，如: Department department

*************************************************/

@artifact.package@class @artifact.name@ {

    static cgDomain=[chinese:"模型", searchBar:true, navigation:[group:"管理",weight:1]]
    static cgLayout=[:]

    String name

    static constraints = {
	    name(attributes:[chinese:"姓名"],blank:false,unique:true, size: 4..32)
    }

    String toString()
    {
	    return name
    }
}
