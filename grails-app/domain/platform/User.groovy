/*************************************************
Copyright by clinking.org, all rights reserved.
**************************************************
Domain class: User
Author: bruce_lin_chn@126.com
Date: 2011-03-20 13:37:28 (星期日)

Function:

Note:

*************************************************/

package platform

class User {

    static cgDomain=[chinese:"用户", searchBar:true]
    static cgLayout=[:]
    
    String name
    String mobile
    String identityCardNum

    Date dateCreated
    Date lastUpdated

    static constraints = {
	    name(attributes:[chinese:"姓名"],nullable:false,unique:false)
        mobile(attributes:[chinese:"手机"],nullable:false,unique:false)
        identityCardNum(attributes:[chinese:"身份证号"],nullable:false,unique:false)
	//createdDate()
	//lastUpdated()
    }

    String toString()
    {
	    return name+"("+mobile+")"
    }
}
