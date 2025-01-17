#!/bin/bash
set -e

if [ -f venv/bin/activate ]; then
  source venv/bin/activate
fi

black_extra_args=""
isort_extra_args=""
if [[ "$1" = "--ci" ]]; then
    check_arg="--check"
    isort_extra_args="--check-only"
fi

isort --settings-path .isort.cfg $isort_extra_args --skip granulate-utils .
black --line-length 120 $black_extra_args --exclude "granulate-utils|\.venv" .
flake8 --config .flake8 .
mypy .
