var command = '/spawnitem {0} 1 \'{"itemScript":{"script":"{1}"}}\'';

function generate() {
  var item = $("#item").val();
  if (item == "") {
    item = "fossilbrushbeginner";
    $("#name").val("fossilbrushbeginner");
  }

  var script = $("#script").val();
  if (script == "") {
    alert("Please enter the path to your script.");
    return;
  } else if (!script.match(/^\/([a-zA-Z0-9_-]+[\/])*[a-zA-Z0-9_-]+.lua$/)) {
    alert("Please enter a valid script path.");
    return;
  }

  var output = command.replace("{0}", item).replace("{1}", script);
  $("#output").val(output);
}