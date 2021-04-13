docker run --rm --privileged -v $PWD/yocto-build:/home/motesque/build \
           -v $PWD/yocto-src/layers/meta-coral-tpu:/home/motesque/sources/meta-coral-tpu -it yocto:latest

# . ./run_me_first.sh
# bitbake core-image-base
