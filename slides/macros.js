remark.macros.scale = function(w, alt="") {
  var url = this;
  return '<img src="' + url + '" style="width: ' + w + ';" alt="' + alt + '" />';
};
remark.macros.scaleh = function(h, alt="") {
  var url = this;
  return '<img src="' + url + '" style="height: ' + h + ';" alt="' + alt + '" />';
};
