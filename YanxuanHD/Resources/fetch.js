
window.appHost.fetch = function(action) {
    var ret = []
    if (action == 'oversea') {
        ret = JSON_DATA['tagList']
    } else if (action == 'newarrival') {
        ret = JSON_DATA['newItemList']
    } else if (action == 'banners') {
        ret = JSON_DATA['focusList']
    } else if (action == 'topsale'){
        ret = JSON_DATA['indexPopularItemVO']['popularItemList']
    } else if (action == 'flashsale'){
        ret = JSON_DATA['indexFlashSaleVO']
    } else if (action == 'fulishe'){
        var modules = JSON_DATA['saleIndexVO']['indexModuleVO']
        for(var i = 0; i < modules.length; i++){
            var module = modules[i]
            if (module.type == 2) {
                ret = module.itemList
                break;
            }
        }
    }
    
    window.appHost.invoke(action, ret);
}
