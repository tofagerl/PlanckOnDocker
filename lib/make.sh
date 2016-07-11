#!/bin/sh
for FILE in /work/keymaps/*.c; do
  QMK_DIR=${QMK_DIR}
  FILENAME=${FILE#/work/keymaps/}
  NAME="${FILENAME%.c}"
  NEWFILENAME="/work/firmware/${NAME}.hex"
  KEYMAPFILENAME="${QMK_DIR}/keymaps/${NAME}/keymap.c"
  mkdir -p "${QMK_DIR}/keymaps/${NAME}"
  cp "${FILE}" "${KEYMAPFILENAME}"
  cd "${QMK_DIR}" && make "KEYMAP=${NAME}" | ts >> "/work/logs/${NAME}-debug.log" 2>> "/work/logs/${NAME}-error.log"
  if test -f "${NEWFILENAME}"; then
    mv "${NEWFILENAME}" "${NEWFILENAME%.hex}-$(date +%Y.%m.%d-%H:%M:%S -r ${NEWFILENAME}).hex"
  fi
  ls -A -R .
  cp "${QMK_DIR}/.build/planck_rev4_${NAME}.hex" "$NEWFILENAME"
  cd "${QMK_DIR}" && make clean | ts >> "/work/logs/${NAME}-debug.log" 2>> "/work/logs/${NAME}-error.log"
done