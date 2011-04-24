/*************************************************
Copyright by clinking.org, all rights reserved.
**************************************************
Domain class: DepartmentEmployee
Author: bruce_lin_chn@126.com
Date: 2011-04-24 11:57:53 (星期日)

Function:

Note:

*************************************************/

package business

class DepartmentEmployee {

    static cgDomain=[chinese:"模型", searchBar:true, navigation:[group:"管理",weight:1]]
    static cgLayout=[:]

    Department department
    Employee employee

    //定义包含其他Domain的关联变量必须是模型名称的小写格式

    static constraints = {

    }

    String toString()
    {
	    return "DepartmentEmployee"
    }
}
