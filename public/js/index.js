$(function() {
    var nodeCounter = 0;

    var createCommand = function() {
        return "<tr><td><select name=node[]['command'][]['protocol']><option value='ping'>ping</option></select></td><td><input type='text' name=node[]['command'][]['destination']></td><td><input type='button' class='delete-command pure-button' value='delete command'></td></tr>";
    };

    var createNode = function(nodeId) {
        return "<fieldset id='node" + nodeId + "' class='pure-group'><legend>node"+ nodeId + "</legend><label>IPAddress</label><input type='text' name=node[]['ipaddress']><fieldset id='command'><label>Command</label><input type='button' value='add command' class='add-command pure-button'><table class='pure-table'><thead><tr><th>protocol</th><th>destination</th><th> </th></tr></thead><tbody></tbody></table></fieldset></fieldset>";
    };

    var data = 
        {"node" :
         [
             {"ipaddress" : "10.10.10.10",
              "command" :
              [
	          {"protocol" : "ping", "destination" : "10.10.10.11"},
	          {"protocol" : "ping", "destination" : "10.10.10.11"},
                  {"protocol" : "ping", "destination" : "10.10.10.11"},
	          {"protocol" : "ping", "destination" : "10.10.10.11"},
	          {"protocol" : "ping", "destination" : "10.10.10.11"},
	          {"protocol" : "ping", "destination" : "10.10.10.11"},
                  {"protocol" : "ping", "destination" : "10.10.10.11"},
	          {"protocol" : "ping", "destination" : "10.10.10.11"},
	          {"protocol" : "ping", "destination" : "10.10.10.11"},
	          {"protocol" : "ping", "destination" : "10.10.10.11"},
	          {"protocol" : "ping", "destination" : "10.10.10.11"},
                  {"protocol" : "ping", "destination" : "10.10.10.11"},
	          {"protocol" : "ping", "destination" : "10.10.10.11"}
              ]
             },
             {"ipaddress" : "10.10.10.11",
              "command" :
              [
              ]
             }
         ],
         "openflowcontroller" :
         {"source" : "OpenFlowController/lerning-switch.rb"}
        };

    var addNode = function(nodeId) {
        $('#nodes').append(createNode(nodeId));
    };

    var deleteNode = function() {
        $('#node'+nodeCounter).remove();
    }

    $('#add-node').click(function() {
        addNode(nodeCounter);
        nodeCounter++;
    });

    $('#delete-node').click(function() {
        if ( nodeCounter > 0 ) {
            nodeCounter--;
            deleteNode();
        }
    });

    $('#content').on('click', '.add-command', function() {
        $('tbody', $(this).parent()).append(createCommand());
    });

    $('#content').on('click', '.delete-command', function() {
        $($(this).parent()).parent().remove();
    });

    $('#openflowcontroller').change(function() {
    });

});
