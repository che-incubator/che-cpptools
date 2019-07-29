#!/bin/bash
#
# Copyright (c) 2019 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# See: https://sipb.mit.edu/doc/safe-shell/

set -e
set -u

rm -rf out
mkdir out

docker build -t che-incubator/cdt-vscode -f docker/cdt-vscode.dockerfile .
docker run --rm che-incubator/cdt-vscode | tar -xf - -C out

docker build -t che-incubator/cdt-gdb-vscode -f docker/cdt-gdb-vscode.dockerfile .
docker run --rm che-incubator/cdt-gdb-vscode | tar -xf - -C out

echo "Successufully build: "$(find out/*)
