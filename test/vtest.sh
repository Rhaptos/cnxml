#!/bin/sh

jing.sh $1 */*.xml */*/*.xml | sed 's;^.*test/;;'
