#!/usr/bin/env bash

handle-error() {
    echo "ERROR: $1"
    exit 1
}

check_requirements() {

    if ! git --version >/dev/null 2>&1 ; then
        handle-error "git not installed"
    fi
}

tag_repository() {

    echo "Creating tag"
    git tag -a ${1} -m "Tag for the ${1} release"
    if [ $? -ne 0 ];then
        handle-error "Could not create the tag"
    fi

    echo "Pushing tag to remote"
    git push origin --tags
    if [ $? -ne 0 ];then
        handle-error "Could not push the tag to remote"
    fi

}

usage() {
    echo "Error, usage:"
    echo "$0 -t <tag>"
    exit 1
}

check_requirements

while getopts "t:?" OPTION; do
  case ${OPTION} in
      t)
          TAG="${OPTARG}"
          ;;
      ?)
          usage
          ;;
  esac
done

if [ -z ${TAG} ];then
    usage
fi

tag_repository ${TAG}
