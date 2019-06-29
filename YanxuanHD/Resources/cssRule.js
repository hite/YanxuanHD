var styleEl = document.createElement('style');

// Append <style> element to <head>
document.head.appendChild(styleEl);

// Grab style element's sheet
var styleSheet = styleEl.sheet;
// Insert CSS Rule
styleSheet.insertRule('#j-YXComponentTop{display:none!important}', styleSheet.cssRules.length);
styleSheet.insertRule('#j-yx-fixedtoolDownloadlink{display:none!important}', styleSheet.cssRules.length);
styleSheet.insertRule('.m-appDownloadGuide{display:none!important}', styleSheet.cssRules.length);

