#!/bin/bash
set -euo pipefail
# Set some defaults
set +u
[[ -z $DOCKER_ARG ]] && DOCKER_ARG=""
[[ -z $TRAVIS ]] && TRAVIS="false"
[[ -z $BIOCONDA_UTILS_LINT_ARGS ]] && BIOCONDA_UTILS_LINT_ARGS=""
[[ -z $RANGE_ARG ]] && RANGE_ARG="--git-range master HEAD"
[[ -z $DISABLE_BIOCONDA_UTILS_BUILD_GIT_RANGE_CHECK  ]] && DISABLE_BIOCONDA_UTILS_BUILD_GIT_RANGE_CHECK="false"
set -u

if [[ $TRAVIS_BRANCH != "master" && $TRAVIS_PULL_REQUEST == "false" && $TRAVIS_REPO_SLUG == "bioconda/bioconda-recipes" ]]
then
    echo ""
    echo "Tests are skipped for pushes to the main bioconda-recipes repo."
    echo "If you have opened a pull request, please see the full tests for that PR."
    echo "See https://bioconda.github.io/build-system.html for details"
    echo ""
    exit 0
fi

SKIP_LINTING=false

# determine recipes to build. If building locally, build anything that changed
# since master. If on travis, only build the commit range included in the push
# or the pull request.
if [[ $TRAVIS == "true" ]]
then
    RANGE="$TRAVIS_BRANCH HEAD"
    if [ $TRAVIS_PULL_REQUEST == "false" ]
    then
        if [ -z "$TRAVIS_COMMIT_RANGE" ]
        then
            RANGE="HEAD~1 HEAD"
        else
            RANGE="${TRAVIS_COMMIT_RANGE/.../ }"
        fi
    fi

    # If the environment vars changed (e.g., boost, R, perl) then there's no
    # good way of knowing which recipes need rebuilding so we check them all.
    set +e
    git diff --exit-code --name-only $RANGE scripts/env_matrix.yml
    ENV_CHANGE=$?
    set -e

    if [[ $TRAVIS_EVENT_TYPE == "cron" ]]
    then
        RANGE_ARG=""
        SKIP_LINTING=true
        echo "considering all recipes because build is triggered via cron"
    else
        if [[ $ENV_CHANGE -eq 1 ]]
        then
            if [[ $TRAVIS_BRANCH == "bulk" ]]
            then
                if [[ $TRAVIS_PULL_REQUEST != "false" ]]
                then
                    # pull request against bulk: only build additionally changed recipes
                    RANGE_ARG="--git-range $RANGE"
                else
                    # push on bulk: consider all recipes affected by modified env matrix (the bulk update)!
                    RANGE_ARG=""
                    SKIP_LINTING=true
                    echo "running bulk update"
                fi
            else
                # not on bulk branch: ignore env matrix changes
                RANGE_ARG="--git-range $RANGE"
            fi
        else
            # consider only recipes that (a) changed since the last build
            # on master, or (b) changed in this pull request compared to the target
            # branch.
            RANGE_ARG="--git-range $RANGE"            
        fi
    fi
fi

export PATH=/anaconda/bin:$PATH

# On travis we always run on docker for linux. This may not always be the case
# for local testing.
if [[ $TRAVIS_OS_NAME == "linux" && $TRAVIS == "true" ]]
then
    DOCKER_ARG="--docker --mulled-test"
fi

# When building master or bulk, upload packages to anaconda and quay.io.
if [[ ( $TRAVIS_BRANCH == "master" || $TRAVIS_BRANCH == "bulk" ) && "$TRAVIS_PULL_REQUEST" == "false" ]]
then
    if [[ $TRAVIS_OS_NAME == "linux" ]]
    then
        UPLOAD_ARG="--anaconda-upload --mulled-upload-target biocontainers"
    else
        UPLOAD_ARG="--anaconda-upload"
    fi
else
    UPLOAD_ARG=""
    if [[ $SKIP_LINTING == "false"  ]]
    then
        set -x; bioconda-utils lint recipes config.yml $RANGE_ARG $BIOCONDA_UTILS_LINT_ARGS; set +x
    fi

fi


if [[ $DISABLE_BIOCONDA_UTILS_BUILD_GIT_RANGE_CHECK == "true" ]]
then
    echo
    echo "DISABLE_BIOCONDA_UTILS_BUILD_GIT_RANGE_CHECK is true."
    echo "A comprehensive check will be performed to see what needs to be built."
    RANGE_ARG=""
fi
set -x; bioconda-utils build recipes config.yml $UPLOAD_ARG $DOCKER_ARG $BIOCONDA_UTILS_BUILD_ARGS $RANGE_ARG; set +x;

