#!/bin/sh
echo $NAME $EMAIL $REASON
curl -x POST -u "pirnz":"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" https://api.github.com/repos/pirnz/pir.nz/issues -d '{"title":"Access request for $NAME","body":"Email: $EMAIL <br> $REASON"}'