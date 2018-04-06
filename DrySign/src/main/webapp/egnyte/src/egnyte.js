var slim = require("src/slim");
var filepicker = require("src/lib/filepicker_elements/index")
var prompt = require("src/lib/prompt/index")
var authPrompt = require("src/lib/api_elements/authPrompt")

slim.plugin("filePicker", function (root, resources) {
    root.filePicker = filepicker(resources.API);
});
slim.plugin("authPrompt", authPrompt);
slim.plugin("prompt", function (root, resources) {
    root.prompt = prompt;
});

module.exports = slim;