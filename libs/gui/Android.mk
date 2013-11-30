LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	IGraphicBufferConsumer.cpp \
	IConsumerListener.cpp \
	BitTube.cpp \
	BufferItemConsumer.cpp \
	BufferQueue.cpp \
	ConsumerBase.cpp \
	CpuConsumer.cpp \
	DisplayEventReceiver.cpp \
	GLConsumer.cpp \
	GraphicBufferAlloc.cpp \
	GuiConfig.cpp \
	IDisplayEventConnection.cpp \
	IGraphicBufferAlloc.cpp \
	IGraphicBufferProducer.cpp \
	ISensorEventConnection.cpp \
	ISensorServer.cpp \
	ISurfaceComposer.cpp \
	ISurfaceComposerClient.cpp \
	LayerState.cpp \
	Sensor.cpp \
	SensorEventQueue.cpp \
	SensorManager.cpp \
	Surface.cpp \
	SurfaceControl.cpp \
	SurfaceComposerClient.cpp \
	SyncFeatures.cpp \

LOCAL_SHARED_LIBRARIES := \
	libbinder \
	libcutils \
	libEGL \
	libGLESv2 \
	libsync \
	libui \
	libutils \
	liblog

# Executed only on QCOM BSPs
ifeq ($(TARGET_USES_QCOM_BSP),true)
ifneq ($(TARGET_QCOM_DISPLAY_VARIANT),)
    LOCAL_C_INCLUDES += hardware/qcom/display-$(TARGET_QCOM_DISPLAY_VARIANT)/libgralloc
else
    LOCAL_C_INCLUDES += hardware/qcom/display/$(TARGET_BOARD_PLATFORM)/libgralloc
endif
    LOCAL_CFLAGS += -DQCOM_BSP
endif

LOCAL_MODULE:= libgui

ifeq ($(TARGET_BOARD_PLATFORM), tegra)
	LOCAL_CFLAGS += -DDONT_USE_FENCE_SYNC
endif
ifeq ($(TARGET_BOARD_PLATFORM), tegra3)
	LOCAL_CFLAGS += -DDONT_USE_FENCE_SYNC
endif
ifeq ($(TARGET_TOROPLUS_RADIO), true)
	LOCAL_CFLAGS += -DTOROPLUS_RADIO
endif

ifeq ($(SENSORS_NEED_SETRATE_ON_ENABLE), true)
        LOCAL_CFLAGS += -DSENSORS_SETRATE_ON_ENABLE
endif

include $(BUILD_SHARED_LIBRARY)

ifeq (,$(ONE_SHOT_MAKEFILE))
include $(call first-makefiles-under,$(LOCAL_PATH))
endif
