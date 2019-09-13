# This work is licensed under a Creative Commons Attribution 3.0 Unported License (http://creativecommons.org/licenses/by/3.0/)
#
# Very simple makefile - just to translate the text files through cpp into txt files
# We do NOT use lslplus anymore. But we do use mcpp, the python lsl optimizer and
# my own perl based optimizer (not great for everything - but works for my scripts).
#
# A definitions for how to build:
#    Define BUILD_FOR: SL = second life, OpenSim = open simulator
BUILD_FOR := SL

ifeq ($(BUILD_FOR),SL)
LSLOPTIMIZER := lsl-optimizer -O -ListAdd,+AddStrings,-OptSigns,-OptFloats - 
DEFINES := -DBUILD_FOR_SL
else
LSLOPTIMIZER := lsl-optimizer -O -ListAdd,-ListLength,+AddStrings,-OptSigns,-OptFloats - 
DEFINES := -DBUILD_FOR_OPENSIM
endif

GENERATED_KEYWORDS := include/Keywords include/KeywordSearch

BASENAMES := FSChat FSDancerControl FSDancer FSDancers FSLanguage FSLists \
		FSMenu FSPrepare FSProduct FSRead FSServices FSUI FSZHAO

GENERATED_SCRIPTS := $(addsuffix .lsl,$(BASENAMES))

all:	$(GENERATED_KEYWORDS) $(GENERATED_SCRIPTS)

$(GENERATED_KEYWORDS): GenerateKeywords
	./GenerateKeywords

# Generate the optimizied scripts
FSChat.lsl:	FSChat $(addprefix include/,Trace GlobalDefinitions DanceControl.h Dancers.h Lists.h MenuList.h Services.h Chat.h Dancer.h Read.h Debug Keywords Utility UtilOwnerSay)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

FSDancerControl.lsl:	FSDancerControl $(addpreffix include/,Trace GlobalDefinitions DanceControl.h Dancers.h Dancer.h Lists.h MenuList.h Chat.h Services.h Debug Keywords Utility UtilOwnerSay KeywordSearch)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

FSDancer.lsl:	FSDancer $(addprefix include/,Trace GlobalDefinitions Dancer.h DanceControl.h Dancers.h Lists.h MenuList.h Read.h Services.h Chat.h Debug Utility UtilOwnerSay)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

FSDancers.lsl:	FSDancers $(addprefix include/,Trace GlobalDefinitions DanceControl.h Dancers.h Dancer.h Lists.h MenuList.h Chat.h Services.h Debug Keywords Utility UtilOwnerSay)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

FSLists.lsl:	FSLists $(addprefix include/,Trace GlobalDefinitions LinkIds.h Lists.h MenuList.h DanceControl.h Dancers.h Dancer.h Services.h Read.h Chat.h Debug Keywords Utility UtilOwnerSay)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

FSLanguage.lsl:	FSLanguage $(addprefix include/,Trace GlobalDefinitions Utility)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

FSMenu.lsl:	FSMenu $(addprefix include/,Trace GlobalDefinitions Lists.h MenuList.h Read.h Services.h Debug Keywords Utility UtilOwnerSay)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

FSPrepare.lsl:	FSPrepare $(addprefix include/,GlobalDefinitions Debug Keywords Utility UtilOwnerSay)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

FSProduct.lsl:	FSProduct $(addprefix include/,GlobalDefinitions LinkIds.h Lists.h)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

FSRead.lsl:	FSRead $(addprefix include/,GlobalDefinitions Read.h Lists.h MenuList.h Read.h Debug Keywords Utility UtilOwnerSay)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

FSServices.lsl:	FSServices $(addprefix include/,Trace GlobalDefinitions LinkIds.h Services.h Lists.h MenuList.h Dancer.h Dancers.h DanceControl.h Debug Keywords Utility UtilOwnerSay)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

FSUI.lsl:	FSUI $(addprefix include/,Trace GlobalDefinitions Services.h Lists.h MenuList.h DanceControl.h Dancers.h Read.h Debug Keywords Utility UtilOwnerSay)
	mcpp -I- -P -I. -Iinclude $(DEFINES) $(subst .lsl,,$@) | $(LSLOPTIMIZER) | ./FSOptimize $@ > $@
	lslint -m $@

# ZHAO doesn't optimize with my hacky perl optimizer... it's ok - not going to use my optimizer on it :)
# We have two different ZHAO scripts - one works in SL, the other works in OpenSim
ifeq ($(BUILD_FOR),SL)
FSZHAO.lsl:	FSZHAO $(addprefix include/,GlobalDefinitions MenuList.h Lists.h)
	mcpp -I- -P -I. -Iinclude FSZHAO | ./PostForZHAO 1 >  $@
	lslint -m $@
else
FSZHAO.lsl:	FSZHAO-OS $(addprefix include/,GlobalDefinitions MenuList.h Lists.h)
	mcpp -I- -P -I. -Iinclude FSZHAO-OS | ./PostForZHAO 2 >  $@
	lslint -m $@
endif

clean:	;
	rm -f $(GENERATED_KEYWORDS) $(GENERATED_SCRIPTS)

