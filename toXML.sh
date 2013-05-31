#!/bin/sh
sed '4s/charset="/name="Content-Type" content="charset: /
     s/<section\([^>]*class="\)/<div\1section /g
     s/<\(section\|figure\|figcaption\)/<div class="\1"/g
     s/<\/\(section\|figure\|figcaption\)>/<\/div>/' "$@" | ntidy -utf8 -asxml | \
sed '1s@.*@<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">@'

