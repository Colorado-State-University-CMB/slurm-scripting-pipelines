#!/usr/bin/env bash
set -e
set -o pipefail

writetest() {
    # stat is not portable, so just write a test file
    pth=$@
    testfile="$pth/.slurmlord.test.file"
    if touch $testfile 2> /dev/null && rm $testfile 
    then
        return 0
    else
        return 1
    fi
}

checkinstall() {
# return the first path that can be written to
    for pth in $@
    do
        if writetest $pth
        then
            echo "$pth"
            return 0
        fi
    done
    return 1
    
}
is_dir_in_PATH() {
    [[ ":$PATH:" =~ :$1: ]] && return 0 || return 1
}

WS_PATH=${PATH//:/ }

if [ $# -gt 0 ]
then
    INSTALL_PATH=$1
    if is_dir_in_PATH $INSTALL_PATH
    then
        if writetest $INSTALL_PATH
        then
            echo "Using $INSTALL_PATH"
        else
            echo "$INSTALL_PATH is in your \$PATH but you cannot write to it. Quitting."
            exit 1
        fi
    else
        echo "$INSTALL_PATH is not in your \$PATH variable. Quitting."
        exit 1
    fi
else

    # scan the locations in the user's PATH for writeability, prompt selection
    PATHS=""
    # reverse the order of paths on the command line
    for pth in $WS_PATH
    do
        PATHS="$pth $PATHS"
    done

    first_writeable=$(checkinstall $PATHS)
    if [ $? -eq 0 ]
    then
        echo "Can write to $first_writeable"
        read -p "Installing in $first_writeable. OK [y]/n: " response
        echo "response: ${response:=y}"
        if [ $response = 'y' ]
        then
            INSTALL_PATH=$first_writeable
            echo "installing to $INSTALL_PATH"
        else
            echo "Installation aborted by user. Rerun with $0 install_path to specify the location manually."
            exit 0
        fi
    else
        echo "Cannot write to any of the paths in your \$PATH. Rerun with \`$0 install_path\` to specify the location manually."
        exit 1
    fi
fi


# Actual installation
for exe in ./src/*
do
    [[ $exe =~ "README.md" ]] && continue
    if [ "$exe" -nt $INSTALL_PATH/$(basename $exe) ]
    then
        cp -v $exe $INSTALL_PATH
        chmod a+x $exe
    else
        echo "$INSTALL_PATH/$(basename $exe) is newer than $exe, skipping."
    fi
done

echo "Installation finished without errors."
