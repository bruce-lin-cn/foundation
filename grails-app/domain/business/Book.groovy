/*************************************************
Copyright by clinking.org, all rights reserved.
**************************************************
Domain class: Book
Author: bruce_lin_chn@126.com
Date: 2011-04-03 19:57:59 (星期日)

Function:

Note:

*************************************************/

package business

class Book {

    static cgDomain=[chinese:"书籍", searchBar:true]
    static cgLayout=[:]

    String string1
    String string2
    String string3

    Date date1
    Date date2
    static constraints = {
	    string1(attributes:[chinese:"字符串1"], size: 4..32)
        string2(attributes: [chinese: "字符串2"])
        string3(attributes: [chinese: "字符串3"], inList:["选择1","选择2","选择3"],blank: false)
        date1(attributes: [chinese: "日期1", format: "Date"])
        date2(attributes: [chinese: "日期2", format: "Date"], blank:false)
    }

    String toString()
    {
	    return "书籍";
    }
}
