# Very simple makefile - just to translate the text files through cpp into lslp files
#  so that we can use the lslplus environment for unit tests (not for much else though)

GENERATED_KEYWORDS := include/Keywords include/KeywordSearch

BASENAMES := FSChat FSDanceControl FSDancer FSDancers FSDebug FSLanguage FSLists FSLists2 \
			 FSMenu FSPrepare FSRead FSServices FSUI FSZHAO FSUI-Lookup

GENERATED_SCRIPTS := $(addsuffix .lslp,$(BASENAMES))

LSLPLUS_SCRIPTS := $(addsuffix .lsl,$(BASENAMES))
POSTLSLPLUS_SCRIPTS := $(addsuffix .plsl,$(BASENAMES))

all:	$(GENERATED_KEYWORDS) $(GENERATED_SCRIPTS)

post:	$(POSTLSLPLUS_SCRIPTS)

$(GENERATED_KEYWORDS): GenerateKeywords
	./GenerateKeywords

# Generate the input to lslplus
FSChat.lslp:	FSChat $(addprefix include/,Trace GlobalDefinitions DanceControl.h Dancers.h Lists.h MenuList.h Services.h Chat.h Dancer.h Read.h Debug Keywords Utility UtilOwnerSay)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSDanceControl.lslp:	FSDanceControl $(addpreffix include/,Trace GlobalDefinitions DanceControl.h Dancers.h Dancer.h Lists.h MenuList.h Chat.h Services.h Debug Keywords Utility UtilOwnerSay KeywordSearch)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSDancer.lslp:	FSDancer $(addprefix include/,Trace GlobalDefinitions Dancer.h DanceControl.h Dancers.h Lists.h MenuList.h Read.h Services.h Chat.h Debug Utility UtilOwnerSay)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSDancers.lslp:	FSDancers $(addprefix include/,Trace GlobalDefinitions DanceControl.h Dancers.h Dancer.h Lists.h MenuList.h Chat.h Services.h Debug Keywords Utility UtilOwnerSay)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSDebug.lslp:	FSDebug $(addprefix include/,GlobalDefinitions Keywords Utility)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSLanguage.lslp:	FSLanguage $(addprefix include/,Trace GlobalDefinitions Utility)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSLists.lslp:	FSLists $(addprefix include/,Trace GlobalDefinitions Lists.h MenuList.h DanceControl.h Dancers.h Dancer.h Services.h Read.h Chat.h Debug Keywords Utility UtilOwnerSay)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSLists2.lslp:	FSLists2 $(addprefix include/,Trace GlobalDefinitions Lists.h MenuList.h DanceControl.h Dancers.h Dancer.h Services.h Read.h Chat.h Debug Keywords Utility UtilOwnerSay)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSMenu.lslp:	FSMenu $(addprefix include/,Trace GlobalDefinitions Lists.h MenuList.h Read.h Services.h Debug Keywords Utility UtilOwnerSay)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSPrepare.lslp:	FSPrepare $(addprefix include/,GlobalDefinitions Debug Keywords Utility UtilOwnerSay)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSRead.lslp:	FSRead $(addprefix include/,GlobalDefinitions Read.h Lists.h MenuList.h Read.h Debug Keywords Utility UtilOwnerSay)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSServices.lslp:	FSServices $(addprefix include/,Trace GlobalDefinitions Services.h Lists.h MenuList.h Dancer.h Dancers.h DanceControl.h Debug Keywords Utility UtilOwnerSay)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSUI.lslp:	FSUI $(addprefix include/,Trace GlobalDefinitions Services.h Lists.h MenuList.h DanceControl.h Dancers.h Read.h Debug Keywords Utility UtilOwnerSay)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSUI-Lookup.lslp: FSUI-Lookup $(addprefix include/,Trace GlobalDefinitions Services.h Lists.h MenuList.h DanceControl.h Dancers.h Read.h Debug Keywords Utility UtilOwnerSay)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

FSZHAO.lslp:	FSZHAO $(addprefix include/,GlobalDefinitions MenuList.h Lists.h)
	cpp -nostdinc -P -I. -Iinclude $(subst .lslp,,$@) | ./StripComments > $@

# Generate the input that we use for SL/OpenSim - unwraps some expressions
FSChat.plsl:	FSChat.lsl
	./PostLslPlus < $^ > $@

FSDanceControl.plsl:	FSDanceControl.lsl
	./PostLslPlus < $^ > $@

FSDancer.plsl:	FSDancer.lsl
	./PostLslPlus < $^ > $@

FSDancers.plsl:	FSDancers.lsl
	./PostLslPlus < $^ > $@

FSDebug.plsl:	FSDebug.lsl
	./PostLslPlus < $^ > $@

FSLanguage.plsl:	FSLanguage.lsl
	./PostLslPlus < $^ > $@

FSLists.plsl:	FSLists.lsl
	./PostLslPlus < $^ > $@

FSLists2.plsl:	FSLists2.lsl
	./PostLslPlus < $^ > $@

FSMenu.plsl:	FSMenu.lsl
	./PostLslPlus < $^ > $@

FSPrepare.plsl:	FSPrepare.lsl
	./PostLslPlus < $^ > $@

FSRead.plsl:	FSRead.lsl
	./PostLslPlus < $^ > $@

FSServices.plsl:	FSServices.lsl
	./PostLslPlus < $^ > $@

FSUI.plsl:	FSUI.lsl
	./PostLslPlus < $^ > $@

FSUI-Lookup.plsl:	FSUI-Lookup.lsl
	./PostLslPlus < $^ > $@

FSZHAO.plsl:	FSZHAO.lsl
	./PostLslPlus < $^ | ./PostForZHAO > $@

clean:	;
	rm -f $(GENERATED_KEYWORDS) $(GENERATED_SCRIPTS) \
		$(LSLPLUS_SCRIPTS)  $(POSTLSLPLUS_SCRIPTS) BuildHUD.lsl PrimScript.lsl

