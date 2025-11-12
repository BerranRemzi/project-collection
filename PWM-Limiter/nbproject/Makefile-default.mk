#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/PWM_Limiter.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/PWM_Limiter.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=src/adc/adc.c src/mcc/mcc.c src/device_config/device_config.c src/main.c src/dio/dio.c src/flash/flash.c src/tmr/tmr.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/src/adc/adc.p1 ${OBJECTDIR}/src/mcc/mcc.p1 ${OBJECTDIR}/src/device_config/device_config.p1 ${OBJECTDIR}/src/main.p1 ${OBJECTDIR}/src/dio/dio.p1 ${OBJECTDIR}/src/flash/flash.p1 ${OBJECTDIR}/src/tmr/tmr.p1
POSSIBLE_DEPFILES=${OBJECTDIR}/src/adc/adc.p1.d ${OBJECTDIR}/src/mcc/mcc.p1.d ${OBJECTDIR}/src/device_config/device_config.p1.d ${OBJECTDIR}/src/main.p1.d ${OBJECTDIR}/src/dio/dio.p1.d ${OBJECTDIR}/src/flash/flash.p1.d ${OBJECTDIR}/src/tmr/tmr.p1.d

# Object Files
OBJECTFILES=${OBJECTDIR}/src/adc/adc.p1 ${OBJECTDIR}/src/mcc/mcc.p1 ${OBJECTDIR}/src/device_config/device_config.p1 ${OBJECTDIR}/src/main.p1 ${OBJECTDIR}/src/dio/dio.p1 ${OBJECTDIR}/src/flash/flash.p1 ${OBJECTDIR}/src/tmr/tmr.p1

# Source Files
SOURCEFILES=src/adc/adc.c src/mcc/mcc.c src/device_config/device_config.c src/main.c src/dio/dio.c src/flash/flash.c src/tmr/tmr.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/PWM_Limiter.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=10F322
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/adc/adc.p1: src/adc/adc.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/adc" 
	@${RM} ${OBJECTDIR}/src/adc/adc.p1.d 
	@${RM} ${OBJECTDIR}/src/adc/adc.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/adc/adc.p1 src/adc/adc.c 
	@-${MV} ${OBJECTDIR}/src/adc/adc.d ${OBJECTDIR}/src/adc/adc.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/adc/adc.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/mcc/mcc.p1: src/mcc/mcc.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/mcc" 
	@${RM} ${OBJECTDIR}/src/mcc/mcc.p1.d 
	@${RM} ${OBJECTDIR}/src/mcc/mcc.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/mcc/mcc.p1 src/mcc/mcc.c 
	@-${MV} ${OBJECTDIR}/src/mcc/mcc.d ${OBJECTDIR}/src/mcc/mcc.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/mcc/mcc.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/device_config/device_config.p1: src/device_config/device_config.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/device_config" 
	@${RM} ${OBJECTDIR}/src/device_config/device_config.p1.d 
	@${RM} ${OBJECTDIR}/src/device_config/device_config.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/device_config/device_config.p1 src/device_config/device_config.c 
	@-${MV} ${OBJECTDIR}/src/device_config/device_config.d ${OBJECTDIR}/src/device_config/device_config.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/device_config/device_config.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/main.p1: src/main.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/main.p1.d 
	@${RM} ${OBJECTDIR}/src/main.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/main.p1 src/main.c 
	@-${MV} ${OBJECTDIR}/src/main.d ${OBJECTDIR}/src/main.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/main.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/dio/dio.p1: src/dio/dio.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/dio" 
	@${RM} ${OBJECTDIR}/src/dio/dio.p1.d 
	@${RM} ${OBJECTDIR}/src/dio/dio.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/dio/dio.p1 src/dio/dio.c 
	@-${MV} ${OBJECTDIR}/src/dio/dio.d ${OBJECTDIR}/src/dio/dio.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/dio/dio.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/flash/flash.p1: src/flash/flash.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/flash" 
	@${RM} ${OBJECTDIR}/src/flash/flash.p1.d 
	@${RM} ${OBJECTDIR}/src/flash/flash.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/flash/flash.p1 src/flash/flash.c 
	@-${MV} ${OBJECTDIR}/src/flash/flash.d ${OBJECTDIR}/src/flash/flash.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/flash/flash.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/tmr/tmr.p1: src/tmr/tmr.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/tmr" 
	@${RM} ${OBJECTDIR}/src/tmr/tmr.p1.d 
	@${RM} ${OBJECTDIR}/src/tmr/tmr.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/tmr/tmr.p1 src/tmr/tmr.c 
	@-${MV} ${OBJECTDIR}/src/tmr/tmr.d ${OBJECTDIR}/src/tmr/tmr.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/tmr/tmr.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
else
${OBJECTDIR}/src/adc/adc.p1: src/adc/adc.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/adc" 
	@${RM} ${OBJECTDIR}/src/adc/adc.p1.d 
	@${RM} ${OBJECTDIR}/src/adc/adc.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/adc/adc.p1 src/adc/adc.c 
	@-${MV} ${OBJECTDIR}/src/adc/adc.d ${OBJECTDIR}/src/adc/adc.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/adc/adc.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/mcc/mcc.p1: src/mcc/mcc.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/mcc" 
	@${RM} ${OBJECTDIR}/src/mcc/mcc.p1.d 
	@${RM} ${OBJECTDIR}/src/mcc/mcc.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/mcc/mcc.p1 src/mcc/mcc.c 
	@-${MV} ${OBJECTDIR}/src/mcc/mcc.d ${OBJECTDIR}/src/mcc/mcc.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/mcc/mcc.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/device_config/device_config.p1: src/device_config/device_config.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/device_config" 
	@${RM} ${OBJECTDIR}/src/device_config/device_config.p1.d 
	@${RM} ${OBJECTDIR}/src/device_config/device_config.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/device_config/device_config.p1 src/device_config/device_config.c 
	@-${MV} ${OBJECTDIR}/src/device_config/device_config.d ${OBJECTDIR}/src/device_config/device_config.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/device_config/device_config.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/main.p1: src/main.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/main.p1.d 
	@${RM} ${OBJECTDIR}/src/main.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/main.p1 src/main.c 
	@-${MV} ${OBJECTDIR}/src/main.d ${OBJECTDIR}/src/main.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/main.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/dio/dio.p1: src/dio/dio.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/dio" 
	@${RM} ${OBJECTDIR}/src/dio/dio.p1.d 
	@${RM} ${OBJECTDIR}/src/dio/dio.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/dio/dio.p1 src/dio/dio.c 
	@-${MV} ${OBJECTDIR}/src/dio/dio.d ${OBJECTDIR}/src/dio/dio.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/dio/dio.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/flash/flash.p1: src/flash/flash.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/flash" 
	@${RM} ${OBJECTDIR}/src/flash/flash.p1.d 
	@${RM} ${OBJECTDIR}/src/flash/flash.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/flash/flash.p1 src/flash/flash.c 
	@-${MV} ${OBJECTDIR}/src/flash/flash.d ${OBJECTDIR}/src/flash/flash.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/flash/flash.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/tmr/tmr.p1: src/tmr/tmr.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/src/tmr" 
	@${RM} ${OBJECTDIR}/src/tmr/tmr.p1.d 
	@${RM} ${OBJECTDIR}/src/tmr/tmr.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     -o ${OBJECTDIR}/src/tmr/tmr.p1 src/tmr/tmr.c 
	@-${MV} ${OBJECTDIR}/src/tmr/tmr.d ${OBJECTDIR}/src/tmr/tmr.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/tmr/tmr.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/PWM_Limiter.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -Wl,-Map=${DISTDIR}/PWM_Limiter.X.${IMAGE_TYPE}.map  -D__DEBUG=1  -mdebugger=none  -DXPRJ_default=$(CND_CONF)  -Wl,--defsym=__MPLAB_BUILD=1   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits -std=c90 -gdwarf-3 -mstack=compiled:auto:auto        $(COMPARISON_BUILD) -Wl,--memorysummary,${DISTDIR}/memoryfile.xml -o ${DISTDIR}/PWM_Limiter.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	@${RM} ${DISTDIR}/PWM_Limiter.X.${IMAGE_TYPE}.hex 
	
else
${DISTDIR}/PWM_Limiter.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -Wl,-Map=${DISTDIR}/PWM_Limiter.X.${IMAGE_TYPE}.map  -DXPRJ_default=$(CND_CONF)  -Wl,--defsym=__MPLAB_BUILD=1   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"src/adc" -I"src/device_config" -I"src/mcc" -I"src/flash" -I"src/dio" -I"src/tmr" -I"src" -mwarn=-3 -Wa,-a -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mdefault-config-bits -std=c90 -gdwarf-3 -mstack=compiled:auto:auto     $(COMPARISON_BUILD) -Wl,--memorysummary,${DISTDIR}/memoryfile.xml -o ${DISTDIR}/PWM_Limiter.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
