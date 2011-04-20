/*************************************************
Copyright by clinking.org, all rights reserved.
**************************************************
Domain class: Department
Author: bruce_lin_chn@126.com
Date: 2011-04-20 22:33:43 (星期三)

Function:

Note:

*************************************************/

package business

class Department {

    static cgDomain=[chinese:"部门", searchBar:true, navigation:[group:"人事管理",weight:1]]
    static cgLayout=[:]

    String name

    //定义包含其他Domain的关联变量必须是模型名称的小写格式

    static constraints = {
	    name(attributes:[chinese:"部门名称"],blank:false,unique:true, size: 2..32)
    }

    String toString()
    {
	    return name
    }
}
