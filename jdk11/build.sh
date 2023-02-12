#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

registry="docker.io"
repository="fanq1213/eclipse-temurin"
tag="11.0.18_10-jre-alpine"

BUILD () {
for tag in ${tag};
do
    docker build --pull --no-cache -f ${dir}/Dockerfile -t ${registry}/${repository}:${tag} ${dir}
done
}

TEST () {
docker rm -f image-test
docker run --name image-test -tid ${registry}/${repository}:${tag} /bin/sh
docker exec -i image-test /bin/sh -c "java --version"
if [ $? -eq 0 ]; then
    echo "image run check success.";
else
    echo "image run check failed.";
    exit 1;
fi
docker rm -f image-test
}

PUSH () {
for tag in ${tag};
do
docker push ${registry}/${repository}:${tag}
done
}


HELP () {
cat << USAGE
usage:
    --build : Build images
    --push : Push images
    --test : Test images
USAGE
exit 0
}


case "${1}" in
--build)
        BUILD
        ;;
--push)
        PUSH
        ;;
--test)
        TEST
        ;;
*)
        HELP;
        ;;
esac