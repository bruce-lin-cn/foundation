/*************************************************
Copyright by clinking.org, all rights reserved.
**************************************************
Domain class: @artifact.name@
Author: bruce_lin_chn@126.com
Date: @date@

Function:

Note:

*************************************************/

@artifact.package@class @artifact.name@ {

    static cgDomain=[chinese:"模型", searchBar:true, navigation:[group:"管理",weight:1]]
    static cgLayout=[:]

    String name

    //定义包含其他Domain的关联变量必须是模型名称的小写格式

    static constraints = {
	    name(attributes:[chinese:"姓名"],blank:false,unique:true, size: 4..32)
    }

    String toString()
    {
	    return "@artifact.name@"
    }
}
