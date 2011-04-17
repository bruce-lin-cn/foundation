/*************************************************
Copyright by clinking.org, all rights reserved.
**************************************************
Domain class: Company
Author: bruce_lin_chn@126.com
Date: 2011-04-09 10:19:24 (星期六)

Function:

Note:

*************************************************/

package business

class Company {

    static cgDomain=[chinese:"公司", searchBar:true, navigation:[group:"战略管理",weight:2]]
    static cgLayout=[:]

    String name

    //定义包含其他Domain的关联变量必须是模型名称的小写格式

    static constraints = {
	    name(attributes:[chinese:"名称"],blank:false,unique:true, size: 4..32)
    }

    String toString()
    {
	    return name
    }
}
