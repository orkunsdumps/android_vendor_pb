# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# Internal version
PB_VERSION ?= unity
PB_BUILD_TYPE ?= unsigned

TARGET_PRODUCT_SHORT := $(subst aosp_,,$(PB_BUILD))
PIXELBUILDS_VERSION ?= PixelBuilds_$(TARGET_PRODUCT_SHORT)-$(PB_VERSION)-$(shell date +%Y%m%d-%H%M)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.version.custom?=$(PB_VERSION) \
    ro.build.version.device=$(TARGET_PRODUCT_SHORT) \
    ro.pb.build.version?=$(PIXELBUILDS_VERSION) \
    ro.pb.buildtype?=$(PB_BUILD_TYPE)

# Signing
ifeq (user,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/pb/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/pb/signing/keys/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard vendor/pb/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/pb/signing/keys/otakey.x509.pem
endif
endif
