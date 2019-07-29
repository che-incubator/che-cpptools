# Copyright (c) 2019 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#   Red Hat, Inc. - initial API and implementation

FROM node:10.15.0

RUN apt-get update && apt-get install -y git \
	; \
	git clone --single-branch https://github.com/eclipse-cdt/cdt-vscode /tmp/cdt-vscode \
	; \
	cd /tmp/cdt-vscode \
	; \
	npm install -g vsce \
	; \
	yarn && yarn build && vsce package \
	; \
	VSCE=$(find *.vsix) && tar -cf $VSCE.tar $VSCE && gzip $VSCE.tar

CMD TAR=$(find /tmp/cdt-vscode/*.tar.gz) && zcat $TAR
