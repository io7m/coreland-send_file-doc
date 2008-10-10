#!/bin/sh

cat <<EOF
(subsection
  (title "standard use cases")
  (para-verbatim example "
EOF

echo "# compile C source using the library"
echo "$ send_file-conf compile cflags incdir"
send_file-conf compile incdir cflags
echo
echo

echo "# link object files against the static library"
echo "$ send_file-conf compile ldflags slibdir"
send_file-conf compile slibdir ldflags
echo
echo

echo "# link object files against the dynamic library"
echo "$ send_file-conf compile ldflags dlibdir"
send_file-conf compile dlibdir ldflags
echo
echo

cat <<EOF
"))

(subsection
  (title "other use cases")
  (para-verbatim example "
EOF

echo "$ send_file-conf version"
send_file-conf version
echo
echo

echo "$ send_file-conf incdir"
send_file-conf incdir
echo
echo

echo "$ send_file-conf dlibdir"
send_file-conf dlibdir
echo
echo

echo "$ send_file-conf slibdir"
send_file-conf slibdir
echo
echo

echo "$ send_file-conf cflags"
send_file-conf cflags
echo
echo

echo "$ send_file-conf ldflags"
send_file-conf ldflags
echo
echo

echo "$ send_file-conf compile incdir"
send_file-conf compile incdir
echo
echo

echo "$ send_file-conf compile dlibdir"
send_file-conf compile dlibdir
echo
echo

echo "$ send_file-conf compile slibdir"
send_file-conf compile slibdir
echo
echo

cat <<EOF
"))
EOF

