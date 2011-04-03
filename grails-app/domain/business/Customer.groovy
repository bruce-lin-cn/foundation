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
    String gender
    String mobile
    String identityCardNum
    String level
    String balance
    String birthday

    Date dateCreated
    Date lastUpdated

    static constraints = {
	    name(attributes:[chinese:"姓名"],blank:false, size: 2..32)
        gender(attributes: [chinese: "性别"], inList: ["男", "女"], blank: false)
        mobile(attributes:[chinese:"手机"],blank:false, size: 11..11)
        identityCardNum(attributes:[chinese:"身份证号"], size:18..18)
        level(attributes:[chinese:"等级"],inList:["普通","高级","VIP"],blank:false)
        balance(attributes:[chinese:"余额",type:"Integer"])
        birthday(attributes: [chinese: "生日", type:"Date", format: "yyyy-MM-dd"])
    }

    String toString()
    {
	    return name+"("+mobile+")"
    }
}
