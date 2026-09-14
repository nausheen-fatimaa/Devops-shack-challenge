#!/bin/bash

USERNAME=$1

htpasswd -Bc auth/htpasswd "$USERNAME"