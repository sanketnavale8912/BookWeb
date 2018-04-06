var helpers = require("src/lib/reusables/helpers");
var plugins = require("src/lib/plugins");
var defaults = require("src/defaults.js");

module.exports = {
    init: function init(egnyteDomainURL, opts) {
        var options = helpers.extend({}, defaults, opts);
        options.egnyteDomainURL = egnyteDomainURL ? helpers.normalizeURL(egnyteDomainURL) : null;

        var exporting = {
            domain: options.egnyteDomainURL,
            setDomain: function (d) {
                this.domain = options.egnyteDomainURL = helpers.normalizeURL(d);
            },
            API: require("src/lib/api")(options)
        }
        plugins.install(exporting);

        return exporting;

    },
    plugin: plugins.define

}
