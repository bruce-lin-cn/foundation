/*************************************************
Copyright by clinking.org, all rights reserved.
**************************************************
Domain class: Customer
Author: bruce_lin_chn@126.com
Date: 2011-03-23 09:11:03 (星期三)

Function:

Note:

*************************************************/

package business

class Customer {

    static cgDomain=[chinese:"客户", searchBar:true]
    static cgLayout=[:]

    String name
    String mobile
    String identityCardNum
    String level
    String balance

    Date dateCreated
    Date lastUpdated

    static constraints = {
	    name(attributes:[chinese:"姓名"])
        mobile(attributes:[chinese:"手机"])
        identityCardNum(attributes:[chinese:"身份证号"])
        level(attributes:[chinese:"等级"],inList:["普通","高级","VIP"]) //inList:["高级","中级","低级"]]
        balance(attributes:[chinese:"余额"])
    }

    String toString()
    {
	    return name+"("+mobile+")"
    }
}
