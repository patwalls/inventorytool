(function() {
  var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  Teaspoon.Jasmine1.Suite = (function(_super) {
    __extends(Suite, _super);

    function Suite(_at_suite) {
      this.suite = _at_suite;
      this.fullDescription = this.suite.getFullName();
      this.description = this.suite.description;
      this.link = this.filterUrl(this.fullDescription);
      this.parent = this.suite.parentSuite;
      this.viewId = this.suite.viewId;
    }

    return Suite;

  })(Teaspoon.Suite);

}).call(this);
