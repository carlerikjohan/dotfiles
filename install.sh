#!/bin/sh
set -e

install_task_if_doesnt_exist() {
    if test ! -f ./bin/task; then
        source ./install-task.sh
    fi
}

install() {
    install_task_if_doesnt_exist
    ./bin/task install
}

install