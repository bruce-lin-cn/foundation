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

    static cgDomain=[chinese:"模型", searchBar:true]
    static cgLayout=[:]
    
    String name

    Date dateCreated
    Date lastUpdated

    static constraints = {
	name(attributes:[chinese:"属性"],nullable:false,unique:true)
	createdDate()
	lastUpdated()
    }

    String toString()
    {
	return "@artifact.name@";
    }
}
