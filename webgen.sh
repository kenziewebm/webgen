#!/usr/bin/env bash
# webgen compiler

function usage() {
	echo "$(basename $0) - lightweight website generator"
	echo "usage: $(basename $0) input.wg"
	return $1
}

SECTION=0
SUBSECTION=0
LAST=blank
LANG=blank
QUOTE=false
STYLE=Light
i=1

function parse() {
    # parse() takes in a line of text and spits out a line of html.
    if [[ $LAST == noparse ]]; then
        if [[ $1 == ".end" ]]; then
            export LAST=blank
        else
            echo "$@"
        fi
    elif [[ $LAST == code ]]; then
        if ! [[ "$1" == ".end" ]]; then
            ELINE=$i
            export i=$(expr $i + 1)
            return
        else
            LAST=blank
            echo Generating codeblock in $INFILE from l$SLINE to l$ELINE >&2
            if [[ -z "$(which aha)" ]] || [[ -z "$(which bat)" ]]; then
                echo "warning: package 'aha' or 'bat' not found, codeblocks wont have syntax highlighting" >&2
                sed -n "${SLINE},${ELINE}p" $INFILE
                echo "</pre></code>"
            else
                bat -pfl $LANG -r $SLINE:$ELINE $INFILE --theme OneHalf$STYLE| aha -n
                echo "</pre></code>"
            fi
        fi
    elif [[ $QUOTE != false ]] && [[ $1 == ".endquote" ]]; then
	export LAST=blank
	export QUOTE=false
	echo "</div>"
    else
        case $1 in
            .title) echo "<title>${@:2}</title>"
                    export LAST=title ;;

            .s|.sec) export SECTION=$(expr $SECTION + 1)
                     echo "<h1>$SECTION. ${@:2}</h1>"
                     export LAST=sec ;;

            .ss|.ssec) export SUBSECTION=$(expr $SUBSECTION + 1)
                       echo "<h2>$SECTION.$SUBSECTION. ${@:2}</h2>"
                       export LAST=subsec ;;

            .head|.h) echo "<h3>${@:2}</h3>"
                      export LAST=head ;;

            .p) echo "<p>${@:2}"
                export LAST=p ;;

            .noparse) export LAST=noparse ;;

            .style) case $2 in
                        dark) cp /usr/share/webgen/styles/dark.css .
                              echo "<link rel=\"stylesheet\" href=\"dark.css\">"
			      export STYLE=Dark
                              export LAST=style ;;

                        light) cp /usr/share/webgen/styles/light.css .
                               echo "<link rel=\"stylesheet\" href=\"light.css\">"
			       export STYLE=Light
                               export LAST=style ;;

                        *) echo "<link rel=\"stylesheet\" href=\"$2\">"
			   if [[ -z $3 ]]; then
				   echo "warning: custom style specified, syntax highlighting will assume a light background." >&2
				   echo "to force it to assume a dark background, please use '.style $2 Dark' (uppercase d)" >&2
				   export STYLE=Light
			   else
				   export STYLE=$3
			   fi
                           export LAST=style ;;
                    esac ;;

            .code) echo "<code><pre>"
                   echo "lang: $2"
                   echo "<hr>"
                   export LAST=code
                   export LANG=$2
                   export SLINE=$(expr $i + 1) ;;

            .quote) case $2 in
			green|greentext) export QUOTE=green
					 echo "<div class=\"greentext\">" ;;

			*) export QUOTE=true
			   echo "<div class=\"quote\">" ;;
		    esac ;;

            .link|.href) echo "<a href=\"$2\">${@:3}</a>" ;;

            .img)  export RES=$(ffprobe -v 0 $2 -show_entries stream=width,height -of csv=s=x:p=0 | sed -e 's/^/style=\"width: /' -e 's/x/; height: /' -e 's/$/\"/') # retarded
		   echo "<img src=\"$2\" $RES>" ;;

	    .hr) echo "<hr>" ;;

            *) if [[ $LAST == "p" ]] && [[ -z $1 ]]; then
                   echo "</p>"
                   export LAST=endp
               elif [[ $LAST == "p" ]] && ! [[ -z $1 ]]; then
                   echo "<br>$@"
                   export LAST=p
               elif ! [[ -z $1 ]]; then
                   echo "<p>$@"
                   export LAST=p
               fi ;;
        esac
    fi

    export i=$(expr $i + 1)
}

function parser() {
	if [[ -z $1 ]]; then
		usage 1
		exit 1
	fi
	case $1 in
		-h|--help) usage 0;;
		*) export INFILE=$1
		   while read line; do parse $line; done < $INFILE
		   echo "<hr><small>made with <a href=\"https://github.com/aquakenzie/webgen\">webgen</a> <3</small>" ;;
	esac
}

parser "$@"

