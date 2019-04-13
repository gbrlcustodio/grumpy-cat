#!/bin/bash
MIX_ENV=prod mix ecto.setup

_build/prod/rel/grumpy_cat/bin/grumpy_cat foreground