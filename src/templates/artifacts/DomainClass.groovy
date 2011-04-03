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
    String birthday
    int age
    float income
    String introduction     // HTML
    String family           // Multiline

    String cgDateCreated
    String cgLastUpdated

    static constraints = {
	    name(attributes:[chinese:"姓名"],blank:false,unique:true, size: 4..32)
        birthday(attributes: [chinese: "生日", type: "Date", format: "yyyy-MM-dd"], nullable: true, unique:false)
        age(attributes: [chinese: "年龄"], nullable: false, min: 0, max: 150)
        income(attributes: [chinese: "收入"],  min: 1, max: 150)
        introduction(attributes: [chinese: "收入",type: "HtmlEditor"] size: 0.. 1000)
        family(attributes: [chinese: "家庭", type: "TextArea"], min: 0, max: 150)

        cgDateCreated(attributes: [chinese: "创建时间", type: "DateTime", format: "yyyy-MM-dd H:i:s"], nullable: true)
        cgLastUpdated(attributes: [chinese: "最后更新", type: "DateTime", format: "yyyy-MM-dd H:i:s"], nullable: true)
    }

    String toString()
    {
	return "@artifact.name@";
    }
}
