#!/bin/bash
# Copyright (c) 2017 Red Hat, Inc.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
#

set -e
set -u

git_clone_and_build() {
  REPOSITORY=${1}
  BRANCH=${2}
  
  cd "${HOME}"
  CURRENT_FOLDER=$(pwd)

  echo "cloning with git clone -b ${BRANCH} ${REPOSITORY} tmp-folder"

  git clone -b "${BRANCH}" "${REPOSITORY}" tmp-folder
  cd tmp-folder && scl enable rh-maven33 'export MAVEN_OPTS=-Xmx1024m && mvn clean install'
  cd "${CURRENT_FOLDER}" && rm -rf tmp-folder
}


git_clone_and_build https://github.com/skabashnyuk/petclinic fixed
