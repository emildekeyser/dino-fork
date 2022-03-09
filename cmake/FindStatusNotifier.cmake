include(PkgConfigWithFallback)
find_pkg_config_with_fallback(StatusNotifier
    PKG_CONFIG_NAME statusnotifier
    LIB_NAMES statusnotifier
    INCLUDE_NAMES statusnotifier.h
    # DEPENDS gdk-pixbuf-2.0
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(StatusNotifier
    REQUIRED_VARS StatusNotifier_LIBRARY
    VERSION_VAR StatusNotifier_VERSION)
