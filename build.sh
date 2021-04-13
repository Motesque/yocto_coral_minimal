#make sure we use the same user id as the host to enable volume sharing.
docker build --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" -t yocto .

mkdir -p ./yocto-build
chown $(id -u):$(id -g) yocto-build

