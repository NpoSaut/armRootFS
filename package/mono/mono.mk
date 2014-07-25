################################################################################
#
# mono
#
################################################################################

MONO_VERSION         = 3.4.0
MONO_SOURCE	     = mono-$(MONO_VERSION).tar.bz2
MONO_SITE            = http://download.mono-project.com/sources/mono/
MONO_LICENSE         = GPLv2 LGPLv2.1+
MONO_LICENSE_FILES   = COPYING LGPL-2.1
MONO_DEPENDENCIES    = monodll

#MONO_CONF_OPT += --with-tls=pthread --with-sigaltstack=no --disable-mono-debugger --disable-backtrace --disable-mcs-build
MONO_CONF_OPT += --with-sigaltstack=no --disable-mono-debugger --disable-backtrace --enable-mcs-build --with-x=no --with-profile2=no --with-profile4=no --with-profile4_5=yes --with-lazy-gc-thread-creation=yes

$(eval $(autotools-package))
