msrepo = https://github.com/dushoff
gitroot = ./
export ms = $(gitroot)/makestuff
Drop = ~/Dropbox/Outbreak_analysis/
-include local.mk
-include $(gitroot)/local.mk
export ms = $(gitroot)/makestuff
-include $(ms)/os.mk

In = $(Drop)/data/NIH/NIHt

$(ms):
	cd $(dir $(ms)) && git clone $(msrepo)/$(notdir $(ms)).git

subdirs += data
data:
	ln -fs $(In) $@

Makefile: $(ms) $(subdirs)
