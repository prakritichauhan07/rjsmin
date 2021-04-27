#!/bin/bash
set -ex

pkg="${1}"
shift

versions="${@}"

images="manylinux2010_x86_64 manylinux1_i686 manylinux2014_aarch64"

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

for image in ${images};do
    for version in $versions;do
        if [ "${version}" == "27" ] && [ "${image}" == "manylinux2014_aarch64" ]; then
           continue
        else
           docker run --rm -v "$(pwd)":/io quay.io/pypa/${image} /io/wheel/build.sh ${pkg} ${version}
        fi
    done
done
