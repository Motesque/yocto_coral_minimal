DESCRIPTION = "Motesque Image customization"
LICENSE = "MIT"

inherit core-image

CORE_IMAGE_EXTRA_INSTALL += " bash"
CORE_IMAGE_EXTRA_INSTALL += " e2fsprogs"
CORE_IMAGE_EXTRA_INSTALL += " e2fsprogs-e2fsck"
CORE_IMAGE_EXTRA_INSTALL += " e2fsprogs-mke2fs"
CORE_IMAGE_EXTRA_INSTALL += " e2fsprogs-tune2fs"
CORE_IMAGE_EXTRA_INSTALL += " e2fsprogs-badblocks"
CORE_IMAGE_EXTRA_INSTALL += " coreutils"

IMAGE_INSTALL_append = " \
    python3-edgetpu-examples \
    "
