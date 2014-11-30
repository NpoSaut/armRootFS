#############################################################
#
# QtSerialPort 
#
#############################################################

QTSERIALPORT_VERSION = stable
QTSERIALPORT_SOURCE  = $(QTSERIALPORT_VERSION).tar.gz
QTSERIALPORT_SITE = https://gitorious.org/qt/qtserialport.git
QTSERIALPORT_SITE_METHOD = git
QTSERIALPORT_LICENSE = LGPLv2
QTSERIALPORT_LICENSE_FILES = LICENSE.LGPL
QTSERIALPORT_INSTALL_STAGING = YES

QTSERIALPORT_DEPENDENCIES = qt

QTSERIALPORT_LDFLAGS = $(TARGET_LDFLAGS)

define QTSERIALPORT_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(QT_QMAKE))
endef

define QTSERIALPORT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QTSERIALPORT_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
	cp -a $(@D)/src/serialport/*.so.* $(TARGET_DIR)/usr/lib
endef

$(eval $(generic-package))
