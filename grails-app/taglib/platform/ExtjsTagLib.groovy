/*************************************************
Copyright by clinking.org, all rights reserved.
**************************************************
Domain class: ExtjsTagLib
Author: bruce_lin_chn@163.com

Date: 2011-03-20 00:44:17 (星期日)

Function:

Note:

*************************************************/

package platform

class ExtjsTagLib {
    def extjs={attrs, body ->
        out << render(template: "/platform/extjs",model:[:])
    }

    def onReadyBegin={attrs, body ->
        out << render(template: "/platform/onReadyBegin",model:[:])
    }

    def onReadyEnd={attrs, body ->
        out << render(template: "/platform/onReadyEnd",model:[:])
    }
}
