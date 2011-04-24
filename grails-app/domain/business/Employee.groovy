/*************************************************
Copyright by clinking.org, all rights reserved.
**************************************************
Domain class: Employee
Author: bruce_lin_chn@126.com
Date: 2011-04-09 10:19:02 (星期六)

Function:

Note:

*************************************************/

package business

class Employee {

    static cgDomain=[chinese:"员工", searchBar:true, navigation:[group:"业务管理",weight:1]]
    static cgLayout=[:]

    String name
    String gender
    Date birthday
    Company company

    static constraints = {
	    name(attributes:[chinese:"姓名"],blank:false,unique:true, size: 2..32)
        gender(attributes:[chinese:"性别"],inList: ["男","女"],blank:false)
        birthday(attributes:[chinese:"生日"],blank:false)
    }

    String toString()
    {
	    return name
    }
}
