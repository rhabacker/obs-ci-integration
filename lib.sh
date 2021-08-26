#
# @author Ralf Habacker <ralf.habacker@freenet.de>
#

. /etc/sysconfig/obs-ci-integration.conf

# osc command
osc=osc
# osc="osc -c /srv/www/obs-ci-integration/.oscrc"

web=0
if test $# -gt 0; then
    if test -n "$1"; then
        job=$1
    fi
    if test -n "$2"; then
        project=$2
    fi
    if test -n "$3"; then
        revision=$3
    fi
    if test -n "$4"; then
        arch=$4
    fi
else
    eval `echo "${QUERY_STRING}"|tr '&' ';'`
    web=1
fi

template=mingw64-$project-template
subpkg=mingw64-$project

if test "$web" -eq 1; then
    echo "Content-type: text/plain"
    echo ""
    pkgtoken=$($osc token | grep $obsroot | grep $template | sed 's,^.*string=",,g;s,".*$,,g')
    if ! test "$apitoken" == "$pkgtoken"; then
        exit 0
    fi
fi

if test -n "$job"; then
    pkgname=$(echo $template | sed "s,template,$job,g")
else
    pkgname=$(echo $template | sed "s,template,$revision,g")
fi



