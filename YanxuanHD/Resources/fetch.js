
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
        var saleIndexVO = JSON_DATA['saleIndexVO']
        var fulishe = {};
        
        var banners = saleIndexVO['bannerList']
        if (banners && banners.length > 0) {
            fulishe.banner = banners[0]
        }
        
        var modules = saleIndexVO['indexModuleVO']
        for(var i = 0; i < modules.length; i++){
            var module = modules[i]
            if (module.type == 2) {
                fulishe.itemList = module.itemList
                break;
            }
        }
        
        ret = fulishe
    }
    
    window.appHost.invoke(action, ret);
}
