#!/bin/bash
pps_task_pending_system () {
    echo "All PPS Task not complete in the system"
    echo "<br>"
    if [ "$1" -eq "1" ]; then
      echo '<pre>'
       sudo /opt/butler_server/erts-9.3.3.6/bin/escript /home/gor/rpc_call.escript ppstaskrec search_by "[[{'status', 'notequal', 'complete'}], 'key']."
       echo '</pre>'
    elif [ "$1" -eq "2" ]; then
      echo '<pre>'
       sudo /opt/butler_server/erts-9.3.3.6/bin/escript /home/gor/rpc_call.escript ppstaskrec search_by "[[{'status', 'notequal', 'complete'}], 'record']."
       echo '</pre>'
    else 
        echo "Wrong Key pressed"
    fi
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title> All pending pick task in the system</title>'
echo '<link rel="stylesheet" href="/rack.css" type="text/css">'
echo '</head>'
echo '<body>'
echo '<div class=container>'
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"

  echo "<form method=GET action=\"${SCRIPT}\">"\
       '<table nowrap>'\
		  '<tr><td>Type 1 for key and 2 for record</TD><TD><input type="number" name="Type 1 for key and 2 for record" size=12></td></tr>'\
		  '</tr></table>'

  echo '<br><input type="submit" value="SUBMIT">'\
       '<input type="reset" value="Reset"></form>'

  # Make sure we have been invoked properly.

  if [ "$REQUEST_METHOD" != "GET" ]; then
        echo "<hr>Script Error:"\
             "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
             "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
        exit 1
  fi

  # If no search arguments, exit gracefully now.
  echo "$QUERY_STRING<br>"
  echo "<br>"
  if [ -z "$QUERY_STRING" ]; then
        exit 0
  else
   # No looping this time, just extract the data you are looking for with sed:
     XX=`echo "$QUERY_STRING" | sed -n 's/^.*record=\([^ ]*\).*$/\1/p'`
	
	   echo "Type 1 for key and 2 for record: " $XX
     echo '<br>'
    pps_task_pending_system $XX
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0