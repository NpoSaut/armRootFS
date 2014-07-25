################################################################################
#
# monodll
#
################################################################################

MONODLL_VERSION         = 3.4.0
MONODLL_SOURCE	        = mono-$(MONODLL_VERSION).tar.bz2
MONODLL_SITE            = http://download.mono-project.com/sources/mono/
MONODLL_LICENSE         = GPLv2 LGPLv2.1+
MONODLL_LICENSE_FILES   = COPYING LGPL-2.1

define MONODLL_CONFIGURE_CMDS
	(cd $(@D); \
		./configure \
			--prefix=/usr --exec-prefix=/usr --sysconfdir=/etc --program-prefix= \
			--with-profile2=no --with-profile4=no --with-profile4_5=yes \
	)
endef

define MONODLL_BUILD_CMDS
	(cd $(@D); \
		make -j 5 \
	)
endef

define MONODLL_INSTALL_TARGET_CMDS
	(cd $(@D)/mcs; \
		make install DESTDIR=$(TARGET_DIR) \
	)
endef

$(eval $(generic-package))

#bzcat /home/anton/arm-system/armRootFS/dl/mono-3.4.0.tar.bz2 | tar --strip-components=1 -C /home/anton/arm-system/armRootFS/output/build/mono-3.4.0  -xf -