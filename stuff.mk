msrepo = https://github.com/dushoff
oarepo = https://github.com/Outbreak_analysis

gitroot = ./
export ms = $(gitroot)/makestuff
Drop = ~/Dropbox/Outbreak_analysis/
-include local.mk
-include $(gitroot)/local.mk
export ms = $(gitroot)/makestuff
-include $(ms)/os.mk

In = $(Drop)/data/NIH/NIHt

Makefile: $(ms) $(subdirs)

$(ms):
	cd $(dir $(ms)) && git clone $(msrepo)/$(notdir $(ms)).git

subdirs += data
data:
	ln -fs $(In) $@

subdirs += data
$(gitroot)/WA_Ebola_Outbreak:
	cd $(gitroot) && git clone $(oarepo)/WA_Ebola_Outbreak.git
	ln -fs $(In) $@

$(gitroot)/WA_Ebola_Outbreak/%:
	$(MAKE) $(gitroot)/WA_Ebola_Outbreak
	cd $(gitroot)/WA_Ebola_Outbreak && $(MAKE) $*

Makefile: $(ms) $(subdirs)
