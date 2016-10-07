#!/bin/bash
set -e

GITHUB_LATEST_TAG="
import sys, json

def filterVersions(version):
    if not version.startswith('v'):
        return False

    if '-' in version:
        return False

    if not len(version.split('.')) == 3:
        return False

    return True

tags = json.load(sys.stdin)

tagNames = map(lambda obj: obj['name'], tags)

versions = filter(filterVersions, tagNames)

versions.sort(reverse=True)

print versions[0][1:]
"

function githubLatestTag {
    curl -s -X GET "https://api.github.com/repos/$1/tags" | python -c "$GITHUB_LATEST_TAG"
}

mkdir -p ~/bin

if ! [[ `echo "$PATH" | grep -q $HOME/bin && echo '1'` ]]; then
    echo 'PATH="$HOME/bin:$PATH"' >> ~/.bashrc
fi

tag=`githubLatestTag zyedidia/micro`

wget "https://github.com/zyedidia/micro/releases/download/v$tag/micro-$tag-linux64.tar.gz" -O micro.tar.gz

mkdir -p ~/bin

tar -zxvf micro.tar.gz "micro-$tag/micro" --show-transformed --strip-components=1

rm micro.tar.gz -f

mv micro ~/bin/micro -f
