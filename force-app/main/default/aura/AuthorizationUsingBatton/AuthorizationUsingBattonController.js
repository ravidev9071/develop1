({
    Authorize : function(cmp, event, helper) {
          var sURL = window.location.href;
        var code = sURL.split('code=')[1];
        var reDirUrl = 'https://login.salesforce.com/services/oauth2/authorize?client_id=3MVG9fe4g9fhX0E5qAgFxrkBE3nLUfBONavOxlof3ZQU9HWfK1e8.vCWjKmPtBtkTJDWFBqn.P0JzZJJhg3cB&redirect_uri=https://ravidev2023-dev-ed.develop.lightning.force.com/c/AuthorizationUsingBattonApp.app?filterName=Recent&response_type=code';  // on any Visualforce page URL
        var urlEvent = $A.get("e.force:navigateToURL");
        if (urlEvent) {console.log('if');
                       urlEvent.setParams({
                           
                           "url": reDirUrl
                       });
                       urlEvent.fire();
                      } else {
                          window.location = reDirUrl;
                          console.log('else');
                      }
        cmp.set('v.ShowAuth',code);
        
    },
    Token : function(cmp, event, helper) {
        var sURL = window.location.href;
        var code = sURL.split('code=')[1];
        var action = cmp.get("c.getCode");
        action.setParams({ Code : code });
        action.setCallback(this, function(response) {
            var responseValue = response.getReturnValue();
            cmp.set('v.showToken', responseValue);
            //cmp.set("v.accs",responseValue);
            cmp.set('v.isdisabled',true);
            cmp.set('v.isdisable',true);
                        cmp.set('v.check',true);

        });
        $A.enqueueAction(action);
    }
})