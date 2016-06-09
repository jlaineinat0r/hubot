child_process = require 'child_process'

module.exports = (robot) ->
        robot.respond /clean yourself up$/i, (msg) ->
            if robot.auth.hasRole(msg.envelope.user, "dev")
                child_process.exec "git pull", (error, stdout, stderr) ->
                    if error
                        msg.send "git pull failed: " + stderr
                    else
                        output = stdout+''
                        if not /Already up\-to\-date/.test output
                            msg.send "my source code changed:\n" + output
                            changes = true
                        else
                            msg.send "I am minty fresh!"
            else
                msg.send "You're not the boss of me"
